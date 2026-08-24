import 'dart:ui' show ImageFilter;

import '../../../../exports.dart';

class BuildSelectValueQuestion extends StatelessWidget {
  final List<QuestionModel> questionList;
  final int index;
  final Function(dynamic)? onChanged;
  final Function(dynamic)? onChangedForOtherField;
  final String? Function(dynamic)? validator;
  final dynamic selected;
  final bool isAddPatient;
  final Map<String, dynamic>? formData;
  final bool showAiFilledBanner;
  final VoidCallback? onClearAiFilledMark;

  /// Horizontal inset so the overlay aligns under a leading icon (add-patient).
  /// Use `0` when the select field has no leading icon (section details).
  final double? overlayLeadingInset;

  /// When true with overlay mode, show the "Others" text field inline.
  final bool embedOthersField;

  /// Draws a bordered input shell like [CustomTextFormField].
  final bool showFieldBorder;

  const BuildSelectValueQuestion({
    super.key,
    required this.questionList,
    required this.validator,
    required this.selected,
    required this.index,
    required this.onChanged,
    required this.onChangedForOtherField,
    this.isAddPatient = false,
    this.formData,
    this.showAiFilledBanner = false,
    this.onClearAiFilledMark,
    this.overlayLeadingInset,
    this.embedOthersField = false,
    this.showFieldBorder = false,
  });

  String _displayHint() {
    final id = questionList[index].id.toString();
    if (formData != null && formData!.containsKey(id)) {
      final raw = formData![id];
      if (raw is Map) {
        final answers = raw[AppStrings.answers];
        if (answers != null &&
            answers.toString().trim().isNotEmpty &&
            answers.toString() != AppStrings.empty) {
          return answers.toString();
        }
      }
    }
    if (selected != null &&
        selected.toString().trim().isNotEmpty &&
        selected.toString() != AppStrings.empty) {
      return selected.toString();
    }
    return AppStrings.choose;
  }

  bool get _isOthersSelected {
    final hint = _displayHint();
    return hint == AppStrings.others || hint == 'Others';
  }

  @override
  Widget build(BuildContext context) {
    if (isAddPatient) {
      final otherInitial = () {
        final id = questionList[index].id.toString();
        final raw = formData?[id];
        if (raw is Map) {
          final other = raw[AppStrings.otherField];
          if (other is String) return other;
        }
        final answer = questionList[index].answer;
        if (answer is Map) {
          final other = answer[AppStrings.otherField];
          if (other is String) return other;
        }
        return AppStrings.empty;
      }();

      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (showAiFilledBanner) const AiFilledFieldBanner(),
          _OverlaySelectField(
            values: questionList[index].values ?? const [],
            selected: selected,
            displayHint: _displayHint(),
            validator: validator,
            overlayLeadingInset: overlayLeadingInset ?? 31.w,
            showFieldBorder: showFieldBorder,
            onChanged: (v) {
              onClearAiFilledMark?.call();
              onChanged?.call(v);
            },
          ),
          if (embedOthersField && _isOthersSelected) ...[
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  context.tr(AppStrings.yourOtherAnswer),
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 5),
            CustomTextFormField(
              title: context.tr(AppStrings.answerHere),
              initialValue: otherInitial,
              textInputType: TextInputType.text,
              textInputAction: TextInputAction.next,
              validator: validator,
              onChanged: (v) {
                onClearAiFilledMark?.call();
                onChangedForOtherField?.call(v);
              },
            ),
          ],
        ],
      );
    }

    final screenH = MediaQuery.sizeOf(context).height;
    final menuMaxHeight = (screenH * 0.38).clamp(200.0, 380.0);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showAiFilledBanner) const AiFilledFieldBanner(),
        Container(
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.06),
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButtonFormField<dynamic>(
            menuMaxHeight: menuMaxHeight,
            hint: Text(
              questionList[index].answer['answers'] == '' ||
                      questionList[index].answer['answers'] == null
                  ? context.tr(AppStrings.choose)
                  : questionList[index].answer['answers'],
            ),
            validator: validator,
            value: selected,
            items: questionList[index].values!.map((value) {
              return DropdownMenuItem<dynamic>(
                value: value,
                child: Text(value.toString()),
              );
            }).toList(),
            onChanged: (v) {
              onClearAiFilledMark?.call();
              onChanged?.call(v);
            },
            isExpanded: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide.none),
            ),
          ),
        ),
        questionList[index].answer['answers'] == 'Others'
            ? Column(
                children: [
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        context.tr(AppStrings.yourOtherAnswer),
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  CustomTextFormField(
                    title: context.tr(AppStrings.answerHere),
                    initialValue: questionList[index].answer['other_field'],
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    validator: validator,
                    onChanged: (v) {
                      onClearAiFilledMark?.call();
                      onChangedForOtherField?.call(v);
                    },
                  )
                ],
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}

class _OverlaySelectField extends StatefulWidget {
  final List<dynamic> values;
  final dynamic selected;
  final String displayHint;
  final String? Function(dynamic)? validator;
  final ValueChanged<dynamic> onChanged;
  final double overlayLeadingInset;
  final bool showFieldBorder;

  const _OverlaySelectField({
    required this.values,
    required this.selected,
    required this.displayHint,
    required this.validator,
    required this.onChanged,
    required this.overlayLeadingInset,
    this.showFieldBorder = false,
  });

  @override
  State<_OverlaySelectField> createState() => _OverlaySelectFieldState();
}

class _OverlaySelectFieldState extends State<_OverlaySelectField> {
  final LayerLink _link = LayerLink();
  final ScrollController _overlayScrollController = ScrollController();
  final GlobalKey<FormFieldState<dynamic>> _fieldKey =
      GlobalKey<FormFieldState<dynamic>>();
  OverlayEntry? _entry;
  bool _open = false;

  static const _chooseKey = '__choose__';

  @override
  void didUpdateWidget(covariant _OverlaySelectField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selected != widget.selected ||
        oldWidget.displayHint != widget.displayHint) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        _fieldKey.currentState?.didChange(widget.selected);
        _entry?.markNeedsBuild();
      });
    }
  }

  @override
  void dispose() {
    _removeOverlay();
    _overlayScrollController.dispose();
    super.dispose();
  }

  void _removeOverlay() {
    _entry?.remove();
    _entry = null;
    if (_overlayScrollController.hasClients) {
      _overlayScrollController.jumpTo(0);
    }
    if (_open && mounted) {
      setState(() => _open = false);
    } else {
      _open = false;
    }
  }

  void _toggle(bool isDark, Color primary, Color muted, Color title) {
    if (_open) {
      _removeOverlay();
      return;
    }

    final box = context.findRenderObject() as RenderBox?;
    if (box == null) return;
    final size = box.size;
    final leading = widget.overlayLeadingInset;
    final menuWidth = size.width + leading;

    final items = <dynamic>[_chooseKey, ...widget.values];

    _entry = OverlayEntry(
      builder: (context) {
        final trackColor = isDark
            ? Colors.white.withOpacity(0.08)
            : Colors.black.withOpacity(0.06);
        final thumbColor = primary.withOpacity(0.85);

        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: _removeOverlay,
                child: const SizedBox.expand(),
              ),
            ),
            CompositedTransformFollower(
              link: _link,
              showWhenUnlinked: false,
              offset: Offset(-leading, size.height + 4),
              child: Material(
                color: Colors.transparent,
                elevation: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                    child: Container(
                      width: menuWidth,
                      constraints: BoxConstraints(maxHeight: 260.h),
                      decoration: BoxDecoration(
                        color: isDark
                            ? const Color(0xCC2C2C30)
                            : Colors.white.withOpacity(0.94),
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: isDark
                              ? Colors.white.withOpacity(0.10)
                              : const Color(0xFFE5E7EB),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.black.withOpacity(isDark ? 0.4 : 0.12),
                            blurRadius: 22,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          scrollbarTheme: ScrollbarThemeData(
                            thumbVisibility: const WidgetStatePropertyAll(true),
                            trackVisibility: const WidgetStatePropertyAll(true),
                            thickness: WidgetStatePropertyAll(4.w),
                            radius: Radius.circular(8.r),
                            thumbColor: WidgetStatePropertyAll(thumbColor),
                            trackColor: WidgetStatePropertyAll(trackColor),
                            trackBorderColor: const WidgetStatePropertyAll(
                                Colors.transparent),
                            crossAxisMargin: 4.w,
                            mainAxisMargin: 8.h,
                          ),
                        ),
                        child: Scrollbar(
                          controller: _overlayScrollController,
                          thumbVisibility: true,
                          trackVisibility: true,
                          interactive: true,
                          thickness: 4.w,
                          radius: Radius.circular(8.r),
                          child: ListView.builder(
                            controller: _overlayScrollController,
                            padding: EdgeInsets.fromLTRB(0, 6.h, 8.w, 6.h),
                            shrinkWrap: true,
                            itemCount: items.length,
                            itemBuilder: (context, i) {
                              final value = items[i];
                              final isChoose = value == _chooseKey;
                              final label = isChoose
                                  ? AppStrings.choose
                                  : value.toString();
                              final nothingSelected = widget.selected == null ||
                                  widget.selected.toString().isEmpty ||
                                  widget.displayHint == AppStrings.choose;
                              final isSelected = isChoose
                                  ? nothingSelected
                                  : (widget.selected == value ||
                                      widget.displayHint == value.toString());

                              return InkWell(
                                onTap: () {
                                  if (isChoose) {
                                    widget.onChanged('');
                                    _fieldKey.currentState?.didChange('');
                                  } else {
                                    widget.onChanged(value);
                                    _fieldKey.currentState?.didChange(value);
                                  }
                                  _removeOverlay();
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 14.w,
                                    vertical: 11.h,
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 18.w,
                                        child: isSelected
                                            ? Icon(
                                                Icons.check_rounded,
                                                size: 14.sp,
                                                color:
                                                    isChoose ? muted : primary,
                                              )
                                            : null,
                                      ),
                                      SizedBox(width: 8.w),
                                      Expanded(
                                        child: Text(
                                          label,
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: isSelected
                                                ? FontWeight.w600
                                                : FontWeight.w500,
                                            color: isChoose ? muted : title,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

    Overlay.of(context).insert(_entry!);
    setState(() => _open = true);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final primary = isDark ? AppColors.darkPrimary : AppColors.primary;
        final muted = isDark ? AppColors.darkDescription : Colors.grey;
        final title = isDark ? AppColors.darkTitle : const Color(0xFF111827);
        final hasValue = widget.selected != null &&
            widget.selected.toString().isNotEmpty &&
            widget.displayHint != AppStrings.choose;

        return CompositedTransformTarget(
          link: _link,
          child: FormField<dynamic>(
            key: _fieldKey,
            validator: widget.validator,
            initialValue: widget.selected,
            builder: (state) {
              final field = GestureDetector(
                onTap: () => _toggle(isDark, primary, muted, title),
                behavior: HitTestBehavior.opaque,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        widget.displayHint,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: hasValue ? title : muted,
                        ),
                      ),
                    ),
                    Icon(
                      _open
                          ? Icons.keyboard_arrow_up_rounded
                          : Icons.keyboard_arrow_down_rounded,
                      size: 18.sp,
                      color: muted,
                    ),
                  ],
                ),
              );

              final sizedField = SizedBox(
                height: kSectionQuestionFieldHeight,
                width: double.infinity,
                child: field,
              );

              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.showFieldBorder)
                    Container(
                      height: kSectionQuestionFieldHeight,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.darkCardBG : AppColors.subBG,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: state.hasError
                              ? const Color(0xFFEF4444)
                              : _open
                                  ? primary
                                  : (isDark
                                      ? AppColors.darkBorder
                                      : Colors.grey.shade300),
                          width: 1,
                        ),
                      ),
                      child: field,
                    )
                  else
                    sizedField,
                  if (state.hasError)
                    Padding(
                      padding: EdgeInsets.only(top: 2.h, bottom: 2.h),
                      child: Text(
                        state.errorText ?? '',
                        style: TextStyle(
                          fontSize: 9.sp,
                          height: 1.2,
                          color: const Color(0xFFEF4444),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
