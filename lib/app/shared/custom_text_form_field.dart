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
  final Widget? prefixIcon;
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

  const CustomTextFormField({
    super.key,
    required this.title,
    this.textFormFieldController,
    this.onTextClick,
    this.prefixIcon,
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
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late TextEditingController _controller;
  bool _isTextEmpty = true;
  TextDirection _currentTextDirection = TextDirection.ltr;

  // @override
  // void initState() {
  //   super.initState();
  //   _controller = widget.textFormFieldController ??
  //       TextEditingController(text: widget.initialValue);

  //   // Listen for text changes to update _isTextEmpty state
  //   _controller.addListener(() {
  //     setState(() {
  //       _isTextEmpty = _controller.text.isEmpty;
  //     });
  //   });
  // }
  @override
  void initState() {
    super.initState();
    _controller = widget.textFormFieldController ??
        TextEditingController(text: widget.initialValue);

    // Set initial text direction based on initial value
    if (widget.initialValue != null && widget.initialValue!.isNotEmpty) {
      _currentTextDirection =
          RegExp(r'[\u0600-\u06FF]').hasMatch(widget.initialValue!)
              ? TextDirection.rtl
              : TextDirection.ltr;
    }
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

        return SizedBox(
          height: 40.h,
          child: Stack(
            alignment: Alignment.center,
            children: [
              TextFormField(
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

                    // Update text direction based on first character
                    if (value.isNotEmpty) {
                      _currentTextDirection =
                          RegExp(r'[\u0600-\u06FF]').hasMatch(value[0])
                              ? TextDirection.rtl
                              : TextDirection.ltr;
                    } else {
                      _currentTextDirection = TextDirection.ltr;
                    }
                  });
                },
                maxLength: widget.maxLength,
                maxLines: widget.maxLines,
                textAlign: widget.textAlign,
                style: widget.style,
                obscureText: widget.obscureText,
                textInputAction: widget.textInputAction,
                decoration: InputDecoration(
                  contentPadding: widget.contentPadding ??
                      const EdgeInsets.only(
                        left: 11,
                        right: 11,
                        top: 14,
                        bottom: 14,
                      ),
                  counterText: widget.showCounter ? null : '',
                  hintText: widget.title,
                  hintStyle: TextStyle(
                      color:
                          isDarkMode ? AppColors.darkDescription : Colors.grey,
                      fontSize: 12.sp),
                  errorStyle: widget.isOTP
                      ? const TextStyle(height: 0, fontSize: 0)
                      : const TextStyle(fontSize: 9, height: 0.3),
                  filled: true,
                  fillColor: widget.isCreatePostInCommunity
                      ? Colors.transparent
                      : isDarkMode
                          ? AppColors.darkCardBG
                          : AppColors.subBG,
                  enabledBorder: widget.isCreatePostInCommunity
                      ? InputBorder.none
                      : OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: isDarkMode
                                  ? AppColors.darkBorder
                                  : Colors.grey.shade300),
                        ),
                  focusedBorder: widget.isCreatePostInCommunity
                      ? InputBorder.none
                      : widget.isCommunitySearch
                          ? OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: isDarkMode
                                      ? AppColors.darkBorder
                                      : Colors.grey.shade300),
                            )
                          : OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: isDarkMode
                                      ? AppColors.darkPrimary
                                      : AppColors.primary),
                            ),
                  disabledBorder: widget.isCreatePostInCommunity
                      ? InputBorder.none
                      : OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: isDarkMode
                                  ? AppColors.darkBorder
                                  : Colors.grey.shade300),
                        ),
                  errorBorder: widget.isCreatePostInCommunity
                      ? InputBorder.none
                      : OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
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
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: isDarkMode
                                  ? AppColors.darkPrimary
                                  : AppColors.primary),
                        ),
                  suffixIcon: widget.visiblePasswordIcon == true
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
                              : null,
                  prefixIcon: widget.prefixIcon,
                  prefixIconConstraints: widget.prefixIconConstraints,
                ),
                readOnly: widget.readOnly,
                validator: widget.validator,
              ),

              // Show search icon only if isSearchIconInCenter is true and text field is empty
              if (widget.isSearchIconInCenter && _isTextEmpty)
                Positioned(
                  left: 0,
                  right: context.currentLocale?.languageCode == 'ar' ? 110 : 80,
                  top: 5,
                  bottom: 0,
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
            ],
          ),
        );
      },
    );
  }
}
