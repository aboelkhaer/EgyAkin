import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';

import '../../../../exports.dart';

Future<void> showSendConsultationConfirmDialog({
  required BuildContext context,
  required bool isDark,
  required bool isConsultation,
  required int selectedCount,
  required String confirmLabel,
  required ValueChanged<String> onNoteChanged,
  required VoidCallback onConfirm,
}) {
  return showGeneralDialog<void>(
    context: context,
    barrierDismissible: true,
    barrierLabel: context.tr(AppStrings.dismiss),
    barrierColor: Colors.black.withOpacity(0.45),
    transitionDuration: const Duration(milliseconds: 220),
    pageBuilder: (context, animation, secondaryAnimation) {
      return _SendConsultationConfirmDialog(
        isDark: isDark,
        isConsultation: isConsultation,
        selectedCount: selectedCount,
        confirmLabel: confirmLabel,
        onNoteChanged: onNoteChanged,
        onConfirm: onConfirm,
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
      );
      return FadeTransition(
        opacity: curved,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.04),
            end: Offset.zero,
          ).animate(curved),
          child: child,
        ),
      );
    },
  );
}

class _SendConsultationConfirmDialog extends StatefulWidget {
  final bool isDark;
  final bool isConsultation;
  final int selectedCount;
  final String confirmLabel;
  final ValueChanged<String> onNoteChanged;
  final VoidCallback onConfirm;

  const _SendConsultationConfirmDialog({
    required this.isDark,
    required this.isConsultation,
    required this.selectedCount,
    required this.confirmLabel,
    required this.onNoteChanged,
    required this.onConfirm,
  });

  @override
  State<_SendConsultationConfirmDialog> createState() =>
      _SendConsultationConfirmDialogState();
}

class _SendConsultationConfirmDialogState
    extends State<_SendConsultationConfirmDialog> {
  late final TextEditingController _noteController;

  @override
  void initState() {
    super.initState();
    _noteController = TextEditingController();
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDark;
    final primary = HomeDashboardColors.primary(isDark);
    final keyboardInset = MediaQuery.viewInsetsOf(context).bottom;
    final title = widget.isConsultation
        ? context.tr(AppStrings.consultation)
        : context.tr(AppStrings.invitation);
    final description = widget.isConsultation
        ? context.tr(AppStrings.writeNoteForChosenDoctors)
        : context.tr(AppStrings.youAreDone);

    return Material(
      color: Colors.transparent,
      child: AnimatedPadding(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        padding: EdgeInsets.fromLTRB(
          20.w,
          16.h,
          20.w,
          keyboardInset + 16.h,
        ),
        child: Align(
          alignment: keyboardInset > 0
              ? Alignment.bottomCenter
              : Alignment.center,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 420.w,
              maxHeight: MediaQuery.sizeOf(context).height -
                  keyboardInset -
                  48.h,
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: HomeDashboardColors.cardBg(isDark),
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: HomeDashboardColors.border(isDark).withOpacity(0.8),
                ),
                boxShadow: isDark
                    ? null
                    : [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 24,
                          offset: const Offset(0, 10),
                        ),
                      ],
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(18.w, 18.h, 18.w, 16.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40.r,
                          height: 40.r,
                          decoration: BoxDecoration(
                            color: primary.withOpacity(isDark ? 0.22 : 0.12),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Icon(
                            widget.isConsultation
                                ? Icons.medical_services_outlined
                                : Icons.group_add_outlined,
                            color: primary,
                            size: 20.sp,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w800,
                                  color: HomeDashboardColors.title(isDark),
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                '${widget.selectedCount} ${context.tr(widget.selectedCount == 1 ? AppStrings.doctorUnit : AppStrings.doctorsUnit)} ${context.tr(AppStrings.selectedLower)}',
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w600,
                                  color: primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          visualDensity: VisualDensity.compact,
                          icon: Icon(
                            Icons.close_rounded,
                            size: 20.sp,
                            color: HomeDashboardColors.subtitle(isDark),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 14.h),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 12.sp,
                        height: 1.4,
                        color: HomeDashboardColors.subtitle(isDark),
                      ),
                    ),
                    if (widget.isConsultation) ...[
                      SizedBox(height: 12.h),
                      TextField(
                        controller: _noteController,
                        autofocus: true,
                        maxLines: 4,
                        minLines: keyboardInset > 0 ? 2 : 3,
                        cursorColor: primary,
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: HomeDashboardColors.title(isDark),
                        ),
                        onChanged: widget.onNoteChanged,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: isDark
                              ? Colors.white.withOpacity(0.04)
                              : Colors.black.withOpacity(0.03),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 12.h,
                          ),
                          hintText: context.tr(
                            AppStrings.addShortClinicalNoteOptional,
                          ),
                          hintStyle: TextStyle(
                            fontSize: 12.sp,
                            color: HomeDashboardColors.subtitle(isDark),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide(
                              color: HomeDashboardColors.border(isDark),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide(
                              color: HomeDashboardColors.border(isDark),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide(
                              color: primary,
                              width: 1.4,
                            ),
                          ),
                        ),
                      ),
                    ],
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 40.h,
                            child: OutlinedButton(
                              onPressed: () => Navigator.of(context).pop(),
                              style: OutlinedButton.styleFrom(
                                foregroundColor:
                                    HomeDashboardColors.title(isDark),
                                side: BorderSide(
                                  color: HomeDashboardColors.border(isDark),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                              child: Text(
                                context.tr(AppStrings.cancel),
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: SizedBox(
                            height: 40.h,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                widget.onConfirm();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primary,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                              child: Text(
                                widget.confirmLabel,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
