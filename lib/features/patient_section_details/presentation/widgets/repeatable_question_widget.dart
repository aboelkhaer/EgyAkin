import 'package:egy_akin/exports.dart';
import 'package:flutter/services.dart';
import 'package:egy_akin/features/patient_section_details/presentation/models/repeatable_reading_entry.dart';
import 'package:egy_akin/features/patient_section_details/presentation/widgets/add_repeatable_reading_sheet.dart';

class RepeatableQuestionWidget extends StatelessWidget {
  final int questionIndex;
  final String? keyboardType;
  final bool mandatory;
  final bool showAiFilledBanner;
  final VoidCallback? onClearAiFilledMark;

  const RepeatableQuestionWidget({
    super.key,
    required this.questionIndex,
    this.keyboardType,
    this.mandatory = false,
    this.showAiFilledBanner = false,
    this.onClearAiFilledMark,
  });

  List<RepeatableReadingEntry> _entriesFromCubit(
      PatientSectionDetailsCubit cubit) {
    return RepeatableReadingEntry.listFromAnswer(
      cubit.questionModelList[questionIndex].answer,
    );
  }

  String _questionId(PatientSectionDetailsCubit cubit) =>
      cubit.questionModelList[questionIndex].id.toString();

  void _persistEntries(
    BuildContext context,
    List<RepeatableReadingEntry> entries,
  ) {
    final cubit = PatientSectionDetailsCubit.get(context);
    final payload = RepeatableReadingEntry.toApiPayload(entries);
    onClearAiFilledMark?.call();
    cubit.updateQuestionAnswer(_questionId(cubit), payload);
    cubit.formData[_questionId(cubit)] = payload;
  }

  Future<void> _openSheet(
    BuildContext context, {
    required List<RepeatableReadingEntry> entries,
    int? editIndex,
  }) async {
    final initial = editIndex != null ? entries[editIndex] : null;
    final result = await showAddRepeatableReadingSheet(
      context: context,
      initialEntry: initial,
      keyboardType: keyboardType ?? 'text',
    );

    FocusManager.instance.primaryFocus?.unfocus();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    if (!context.mounted) return;
    if (result == null) return;

    final updated = [...entries];
    if (editIndex != null) {
      final previous = entries[editIndex];
      if (previous.hasSameDataAs(result)) return;

      updated[editIndex] = result;
      _persistEntries(context, updated);
      _showSavedSnackBarWithUndo(
        context,
        editIndex: editIndex,
        previousEntry: previous,
      );
    } else {
      updated.add(result);
      _persistEntries(context, updated);
      _showSavedSnackBarWithUndo(context, addedIndex: updated.length - 1);
    }
  }

  void _showSavedSnackBarWithUndo(
    BuildContext context, {
    int? addedIndex,
    int? editIndex,
    RepeatableReadingEntry? previousEntry,
  }) {
    final cubit = PatientSectionDetailsCubit.get(context);
    final isUpdate = editIndex != null && previousEntry != null;

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.grey.shade900,
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green.shade400, size: 20.sp),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                context.tr(isUpdate
                    ? AppStrings.readingUpdated
                    : AppStrings.readingSaved),
                style: TextStyle(color: Colors.white, fontSize: 13.sp),
              ),
            ),
          ],
        ),
        action: SnackBarAction(
          label: context.tr(AppStrings.undo),
          textColor: AppColors.primary,
          onPressed: () {
            final entries = _entriesFromCubit(cubit);
            if (isUpdate) {
              if (editIndex >= entries.length) return;
              final reverted = [...entries];
              reverted[editIndex] = previousEntry;
              _persistEntries(context, reverted);
            } else {
              if (addedIndex == null || addedIndex >= entries.length) return;
              final reverted = [...entries]..removeAt(addedIndex);
              _persistEntries(context, reverted);
            }
          },
        ),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  void _deleteEntry(
      BuildContext context, List<RepeatableReadingEntry> entries, int index) {
    final updated = [...entries]..removeAt(index);
    _persistEntries(context, updated);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PatientSectionDetailsCubit, PatientSectionDetailsState>(
      builder: (context, state) {
        final cubit = PatientSectionDetailsCubit.get(context);
        final entries = _entriesFromCubit(cubit);

        return BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, themeState) {
            final isDarkMode =
                themeState is ThemeLoaded && themeState.isDarkMode;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (showAiFilledBanner) const AiFilledFieldBanner(),
                if (entries.isEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    child: Text(
                      context.tr(AppStrings.noReadingsAddedYet),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontStyle: FontStyle.italic,
                        height: 1.50,
                        color: isDarkMode
                            ? AppColors.darkDescription
                            : Colors.grey.shade500,
                      ),
                    ),
                  )
                else
                  ...List.generate(entries.length, (index) {
                    final entry = entries[index];
                    return _ReadingEntryCard(
                      entry: entry,
                      onEdit: () => _openSheet(
                        context,
                        entries: entries,
                        editIndex: index,
                      ),
                      onDelete: () => _deleteEntry(context, entries, index),
                    );
                  }),
                SizedBox(height: 12.h),
                SafeArea(
                  minimum: EdgeInsets.only(bottom: 8.h),
                  top: false,
                  left: false,
                  right: false,
                  child: OutlinedButton.icon(
                    onPressed: () => _openSheet(context, entries: entries),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      side: BorderSide(
                        color: AppColors.primary.withOpacity(0.45),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    icon:
                        Icon(Icons.add, size: 16.sp, color: AppColors.primary),
                    label: Text(
                      context.tr(AppStrings.addReading),
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13.sp,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _ReadingEntryCard extends StatelessWidget {
  final RepeatableReadingEntry entry;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _ReadingEntryCard({
    required this.entry,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;

        return Container(
          margin: EdgeInsets.only(bottom: 6.h),
          padding: EdgeInsets.fromLTRB(10.w, 6.h, 4.w, 6.h),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(isDarkMode ? 0.12 : 0.06),
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: AppColors.primary.withOpacity(0.2),
              width: 0.8,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 11.sp,
                          color: AppColors.primary,
                        ),
                        SizedBox(width: 4.w),
                        Flexible(
                          child: Text(
                            entry.displayLabel,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500,
                              height: 1.2,
                              color: isDarkMode
                                  ? AppColors.darkDescription
                                  : Colors.grey.shade600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      entry.value,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        height: 1.15,
                        color: isDarkMode
                            ? AppColors.darkTitle
                            : Colors.grey.shade900,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onEdit,
                visualDensity: VisualDensity.compact,
                icon: Icon(
                  Icons.edit_outlined,
                  color: AppColors.primary,
                  size: 17.sp,
                ),
                padding: EdgeInsets.all(4.w),
                constraints: BoxConstraints(minWidth: 28.w, minHeight: 28.w),
              ),
              IconButton(
                onPressed: onDelete,
                visualDensity: VisualDensity.compact,
                icon: Icon(
                  Icons.delete_outline,
                  color: Colors.red.shade500,
                  size: 17.sp,
                ),
                padding: EdgeInsets.all(4.w),
                constraints: BoxConstraints(minWidth: 28.w, minHeight: 28.w),
              ),
            ],
          ),
        );
      },
    );
  }
}
