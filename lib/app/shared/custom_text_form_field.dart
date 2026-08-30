import 'package:egy_akin/app/services/theme_bloc.dart';
import '../../exports.dart';

class CustomTextFormField extends StatefulWidget {
  final String title;
  final TextEditingController? textFormFieldController;
  final TextInputType textInputType;
  final VoidCallback? visiblePasswordIconFunction;
  final VoidCallback? unVisiblePasswordIconFunction;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final bool enableSuggestions;
  final BoxConstraints? prefixIconConstraints;
  final String? initialValue;
  final int? maxLines;
  final int? minLines;
  final Widget? prefixIcon;
  final Widget? suffix;
  final bool? visiblePasswordIcon;
  final TextInputAction? textInputAction;
  final bool isSearchIconInCenter;
  final FocusNode? focusNode;
  final bool isCommunitySearch;
  final bool autoFocus;
  final bool enabled;
  final TextAlign textAlign;
  final bool obscureText;
  final bool isCreatePostInCommunity;
  final bool isOTP;
  final TextDirection? textDirectionForCreatePostInCommunity;
  final bool readOnly;
  final Function(String?)? onSave;
  final void Function()? onTextClick;
  final int? maxLength;
  final TextStyle? style;
  final EdgeInsetsGeometry? contentPadding;
  final bool showClearButton;
  final VoidCallback? onClear;
  final bool showCounter;
  final bool isChatInput;
  final Color? fillColor;
  final double? height;

  const CustomTextFormField({
    super.key,
    required this.title,
    this.textFormFieldController,
    this.onTextClick,
    this.prefixIcon,
    this.suffix,
    this.unVisiblePasswordIconFunction,
    this.isSearchIconInCenter = false,
    this.isCommunitySearch = false,
    this.visiblePasswordIcon,
    this.readOnly = false,
    this.textDirectionForCreatePostInCommunity,
    this.isCreatePostInCommunity = false,
    this.obscureText = false,
    this.enabled = true,
    this.isOTP = false,
    this.initialValue,
    this.autoFocus = false,
    this.prefixIconConstraints,
    this.onFieldSubmitted,
    this.onSave,
    this.style,
    this.textAlign = TextAlign.start,
    this.maxLength,
    this.maxLines = 1,
    this.minLines,
    required this.textInputType,
    this.focusNode,
    this.enableSuggestions = true,
    this.visiblePasswordIconFunction,
    this.textInputAction,
    required this.validator,
    this.onChanged,
    this.inputFormatters,
    this.contentPadding,
    this.showClearButton = false,
    this.onClear,
    this.showCounter = false,
    this.isChatInput = false,
    this.fillColor,
    this.height,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late TextEditingController _controller;
  bool _isTextEmpty = true;
  late TextDirection _currentTextDirection;

  static final _arabicChar = RegExp(r'[\u0600-\u06FF]');
  static final _latinChar = RegExp(r'[A-Za-z]');

  TextDirection _appTextDirection() =>
      context.isRTL ? TextDirection.rtl : TextDirection.ltr;

  TextDirection _directionFor(String text) {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return _appTextDirection();
    for (final match in RegExp(r'[A-Za-z\u0600-\u06FF]').allMatches(trimmed)) {
      final ch = match.group(0)!;
      if (_arabicChar.hasMatch(ch)) return TextDirection.rtl;
      if (_latinChar.hasMatch(ch)) return TextDirection.ltr;
    }
    return _appTextDirection();
  }

  @override
  void initState() {
    super.initState();
    _controller = widget.textFormFieldController ??
        TextEditingController(text: widget.initialValue);

    _currentTextDirection =
        (widget.initialValue != null && widget.initialValue!.trim().isNotEmpty)
            ? _directionFor(widget.initialValue!)
            : _appTextDirection();
  }

  @override
  void didUpdateWidget(CustomTextFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.textFormFieldController != null) return;

    final oldIv = oldWidget.initialValue ?? '';
    final newIv = widget.initialValue ?? '';
    if (oldIv == newIv) return;

    // Avoid setState / controller notifications during build (assertion).
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || widget.textFormFieldController != null) return;
      final iv = widget.initialValue ?? '';
      if (iv != _controller.text) {
        _controller.value = TextEditingValue(
          text: iv,
          selection: TextSelection.collapsed(offset: iv.length),
        );
      }
      setState(() {
        _isTextEmpty = iv.isEmpty;
        _currentTextDirection = _directionFor(iv);
      });
    });
  }

  @override
  void dispose() {
    if (widget.textFormFieldController == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;
        final isMultiline = (widget.maxLines ?? 1) > 1 ||
            (widget.minLines != null && widget.minLines! > 1);

        final textField = TextFormField(
          controller: _controller,
          keyboardType: widget.textInputType,
          textDirection: widget.isCreatePostInCommunity
              ? widget.textDirectionForCreatePostInCommunity
              : _currentTextDirection,
          inputFormatters: widget.inputFormatters ??
              [
                LengthLimitingTextInputFormatter(widget.maxLength ?? 500),
              ],
          enableSuggestions: widget.enableSuggestions,
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          enabled: widget.enabled,
          onTap: widget.onTextClick,
          autofocus: widget.autoFocus,
          onSaved: widget.onSave,
          onFieldSubmitted: widget.onFieldSubmitted,
          focusNode: widget.focusNode,
          onChanged: (value) {
            widget.onChanged?.call(value);
            setState(() {
              _isTextEmpty = value.isEmpty;
              _currentTextDirection = _directionFor(value);
            });
          },
          maxLength: widget.maxLength,
          maxLines: widget.maxLines,
          minLines: widget.minLines ?? (widget.isChatInput ? 1 : null),
          textAlign: widget.textAlign,
          textAlignVertical: isMultiline
              ? TextAlignVertical.top
              : TextAlignVertical.center,
          style: widget.style,
          obscureText: widget.obscureText,
          textInputAction: widget.textInputAction,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: widget.contentPadding ??
                (widget.isChatInput
                    ? const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      )
                    : const EdgeInsets.symmetric(
                        horizontal: 11,
                        vertical: 12,
                      )),
            counterText: widget.showCounter ? null : '',
            hintText: widget.title,
            hintStyle: TextStyle(
                color: isDarkMode ? AppColors.darkDescription : Colors.grey,
                fontSize: 12.sp),
            errorStyle: widget.isOTP
                ? const TextStyle(height: 0, fontSize: 0)
                : const TextStyle(fontSize: 9, height: 0.3),
            filled: true,
            fillColor: widget.fillColor ??
                (widget.isCreatePostInCommunity
                    ? Colors.transparent
                    : widget.isChatInput
                        ? (isDarkMode ? AppColors.darkCardBG : Colors.white)
                        : isDarkMode
                            ? AppColors.darkCardBG
                            : AppColors.subBG),
            enabledBorder: widget.isCreatePostInCommunity
                ? InputBorder.none
                : OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      widget.isChatInput ? 20 : 10,
                    ),
                    borderSide: BorderSide(
                      color: isDarkMode
                          ? AppColors.darkBorder
                          : Colors.grey.shade300,
                      width: widget.isChatInput ? 1 : 1,
                    ),
                  ),
            focusedBorder: widget.isCreatePostInCommunity
                ? InputBorder.none
                : widget.isCommunitySearch
                    ? OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          widget.isChatInput ? 20 : 10,
                        ),
                        borderSide: BorderSide(
                            color: isDarkMode
                                ? AppColors.darkBorder
                                : Colors.grey.shade300),
                      )
                    : OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          widget.isChatInput ? 20 : 10,
                        ),
                        borderSide: BorderSide(
                            color: isDarkMode
                                ? AppColors.darkPrimary
                                : AppColors.primary),
                      ),
            disabledBorder: widget.isCreatePostInCommunity
                ? InputBorder.none
                : OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      widget.isChatInput ? 20 : 10,
                    ),
                    borderSide: BorderSide(
                      color: isDarkMode
                          ? AppColors.darkBorder
                          : Colors.grey.shade300,
                    ),
                  ),
            errorBorder: widget.isCreatePostInCommunity
                ? InputBorder.none
                : OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      widget.isChatInput ? 20 : 10,
                    ),
                    borderSide: BorderSide(
                        color: widget.isOTP
                            ? Colors.red
                            : isDarkMode
                                ? AppColors.darkBorder
                                : Colors.grey.shade300),
                  ),
            focusedErrorBorder: widget.isCreatePostInCommunity
                ? InputBorder.none
                : OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      widget.isChatInput ? 20 : 10,
                    ),
                    borderSide: BorderSide(
                        color: isDarkMode
                            ? AppColors.darkPrimary
                            : AppColors.primary),
                  ),
            suffixIcon: widget.suffix ??
                (widget.visiblePasswordIcon == true
                    ? GestureDetector(
                        onTap: widget.visiblePasswordIconFunction,
                        child: Icon(
                          Icons.visibility_off,
                          color: isDarkMode
                              ? AppColors.darkDescription
                              : Colors.grey,
                        ),
                      )
                    : widget.visiblePasswordIcon == false
                        ? GestureDetector(
                            onTap: widget.unVisiblePasswordIconFunction,
                            child: Icon(
                              Icons.visibility,
                              color: isDarkMode
                                  ? AppColors.darkDescription
                                  : Colors.grey,
                            ),
                          )
                        : widget.showClearButton && !_isTextEmpty
                            ? GestureDetector(
                                onTap: () {
                                  _controller.clear();
                                  widget.onChanged?.call('');
                                  widget.onClear?.call();
                                  setState(() {
                                    _isTextEmpty = true;
                                  });
                                },
                                child: Icon(
                                  Icons.clear,
                                  color: isDarkMode
                                      ? AppColors.darkDescription
                                      : Colors.grey,
                                  size: 20,
                                ),
                              )
                            : null),
            prefixIcon: widget.prefixIcon,
            prefixIconConstraints: widget.prefixIconConstraints ??
                BoxConstraints(
                  minWidth: 40,
                  minHeight: widget.isChatInput ? 36.h : (widget.height ?? 40.h),
                ),
          ),
          readOnly: widget.readOnly,
          validator: widget.validator,
        );

        final field = widget.isSearchIconInCenter && _isTextEmpty
            ? Stack(
                alignment: Alignment.center,
                children: [
                  textField,
                  Positioned(
                    left: 0,
                    right: context.currentLocale?.languageCode == 'ar'
                        ? 110
                        : 80,
                    top: 5,
                    bottom: 0,
                    child: IgnorePointer(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/search.png',
                            color: isDarkMode
                                ? AppColors.darkDescription
                                : Colors.grey,
                            width: 20,
                            height: 20,
                          ),
                          const SizedBox(height: 4),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : textField;

        if (widget.isChatInput) {
          return SizedBox(
            height: 36.h,
            child: field,
          );
        }

        // Single-line fields keep a compact fixed height.
        // Multiline fields must size from minLines/maxLines.
        if (isMultiline) {
          return field;
        }

        return SizedBox(
          height: widget.height ?? 40.h,
          child: field,
        );
      },
    );
  }
}
