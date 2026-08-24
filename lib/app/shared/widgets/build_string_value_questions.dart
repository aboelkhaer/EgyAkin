import '../../../exports.dart';

/// Shared height for compact question inputs (select + text) in section details.
double get kSectionQuestionFieldHeight => 40.h;

class BuildStringValueQuestions extends StatelessWidget {
  final List<QuestionModel> questionList;
  final int index;
  final ValueChanged<String> onChanged;
  final String? Function(String?)? validator;
  final String? initialValue;
  final List<TextInputFormatter>? textInputFormatter;
  final bool showAiFilledBanner;
  final VoidCallback? onClearAiFilledMark;
  final bool isAddPatient;

  /// Use the same bordered shell height as overlay select fields.
  final bool compact;

  const BuildStringValueQuestions({
    super.key,
    required this.questionList,
    required this.index,
    this.initialValue,
    required this.onChanged,
    required this.validator,
    this.textInputFormatter,
    this.showAiFilledBanner = false,
    this.onClearAiFilledMark,
    this.isAddPatient = false,
    this.compact = false,
  });

  TextInputType get _keyboardType {
    final keyboardType = questionList[index].keyboardType;
    if (keyboardType == 'number') return TextInputType.phone;
    if (keyboardType == 'email') return TextInputType.emailAddress;
    if (keyboardType == 'date') return TextInputType.datetime;
    return TextInputType.text;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (showAiFilledBanner && !isAddPatient) const AiFilledFieldBanner(),
        if (compact)
          _CompactQuestionTextField(
            title: context.tr(AppStrings.answerHere),
            initialValue: initialValue,
            keyboardType: _keyboardType,
            inputFormatters: textInputFormatter,
            textInputAction: TextInputAction.next,
            validator: validator,
            onChanged: (v) {
              onClearAiFilledMark?.call();
              onChanged(v);
            },
          )
        else
          CustomTextFormField(
            title: context.tr(AppStrings.answerHere),
            textInputType: _keyboardType,
            textInputAction:
                isAddPatient ? TextInputAction.done : TextInputAction.next,
            inputFormatters: textInputFormatter,
            initialValue: initialValue,
            validator: validator,
            isCreatePostInCommunity: isAddPatient,
            fillColor: isAddPatient ? Colors.transparent : null,
            contentPadding: isAddPatient
                ? EdgeInsets.symmetric(horizontal: 2.w, vertical: 8.h)
                : null,
            style: isAddPatient
                ? TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500)
                : null,
            onChanged: (v) {
              onClearAiFilledMark?.call();
              onChanged(v);
            },
          ),
      ],
    );
  }
}

/// Same outer shell as bordered overlay select (`40.h` + radius 10 + 1px border).
class _CompactQuestionTextField extends StatefulWidget {
  final String title;
  final String? initialValue;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;
  final ValueChanged<String> onChanged;

  const _CompactQuestionTextField({
    required this.title,
    required this.initialValue,
    required this.keyboardType,
    required this.inputFormatters,
    required this.textInputAction,
    required this.validator,
    required this.onChanged,
  });

  @override
  State<_CompactQuestionTextField> createState() =>
      _CompactQuestionTextFieldState();
}

class _CompactQuestionTextFieldState extends State<_CompactQuestionTextField> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
    _focusNode = FocusNode()..addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (mounted) setState(() {});
  }

  @override
  void didUpdateWidget(covariant _CompactQuestionTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue &&
        widget.initialValue != _controller.text) {
      _controller.text = widget.initialValue ?? '';
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final primary = isDark ? AppColors.darkPrimary : AppColors.primary;
        final muted = isDark ? AppColors.darkDescription : Colors.grey;
        final title = isDark ? AppColors.darkTitle : const Color(0xFF111827);

        return FormField<String>(
          initialValue: widget.initialValue,
          validator: widget.validator,
          builder: (state) {
            final hasError = state.hasError;
            final borderColor = hasError
                ? const Color(0xFFEF4444)
                : _focusNode.hasFocus
                    ? primary
                    : (isDark ? AppColors.darkBorder : Colors.grey.shade300);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: kSectionQuestionFieldHeight,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkCardBG : AppColors.subBG,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: borderColor, width: 1),
                  ),
                  child: TextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    keyboardType: widget.keyboardType,
                    textInputAction: widget.textInputAction,
                    inputFormatters: widget.inputFormatters,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      height: 1.2,
                      color: title,
                    ),
                    cursorWidth: 1.2,
                    cursorHeight: 14.sp,
                    textAlignVertical: TextAlignVertical.center,
                    onChanged: (v) {
                      state.didChange(v);
                      widget.onChanged(v);
                    },
                    decoration: InputDecoration(
                      isDense: true,
                      isCollapsed: true,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      hintText: widget.title,
                      hintStyle: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        height: 1.2,
                        color: muted,
                      ),
                    ),
                  ),
                ),
                if (hasError)
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
        );
      },
    );
  }
}
