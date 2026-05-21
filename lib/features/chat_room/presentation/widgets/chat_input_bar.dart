import 'package:egy_akin/exports.dart';

class ChatInputBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onAttach;
  final VoidCallback onRecordOrSend;
  final bool hasText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEmoji;

  const ChatInputBar({
    super.key,
    required this.controller,
    required this.onAttach,
    required this.onRecordOrSend,
    required this.hasText,
    this.onChanged,
    this.onEmoji,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;
        final borderColor =
            isDarkMode ? AppColors.darkBorder : Colors.grey.shade300;
        final scaffoldBg =
            isDarkMode ? AppColors.darkScaffoldBG : AppColors.scaffoldBG;

        return Container(
          padding: EdgeInsets.fromLTRB(10.w, 6.h, 10.w, 6.h),
          decoration: BoxDecoration(
            color: scaffoldBg,
            border: Border(top: BorderSide(color: borderColor, width: 2)),
          ),
          child: SafeArea(
            top: false,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _CircleIconButton(
                  onPressed: onAttach,
                  backgroundColor: Colors.white,
                  icon: Icons.add_rounded,
                  iconColor: Colors.grey.shade600,
                  showBorder: true,
                  borderColor: borderColor,
                ),
                SizedBox(width: 6.w),
                Expanded(
                  child: CustomTextFormField(
                    title: '${context.tr(AppStrings.message)}...',
                    textFormFieldController: controller,
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.send,
                    maxLines: 1,
                    isChatInput: true,
                    enableSuggestions: true,
                    onChanged: onChanged,
                    onFieldSubmitted: (_) => onRecordOrSend(),
                    validator: (_) => null,
                    style: TextStyle(
                      fontSize: 12.sp,
                      height: 1.2,
                      color: isDarkMode
                          ? AppColors.darkTitle
                          : AppColors.title,
                    ),
                    contentPadding: EdgeInsets.only(
                      left: 12.w,
                      right: 4.w,
                      top: 6.h,
                      bottom: 6.h,
                    ),
                    suffix: IconButton(
                      onPressed: onEmoji ?? () {},
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(
                        minWidth: 32.w,
                        minHeight: 32.h,
                      ),
                      visualDensity: VisualDensity.compact,
                      icon: Icon(
                        Icons.emoji_emotions_outlined,
                        color: isDarkMode
                            ? AppColors.darkDescription
                            : Colors.grey.shade500,
                        size: 20.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 6.w),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.35),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Material(
                    color: AppColors.primary,
                    shape: const CircleBorder(),
                    elevation: 0,
                    child: InkWell(
                      onTap: onRecordOrSend,
                      customBorder: const CircleBorder(),
                      child: Padding(
                        padding: EdgeInsets.all(8.w),
                        child: Icon(
                          hasText ? Icons.send_rounded : Icons.mic_rounded,
                          color: Colors.white,
                          size: 18.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color backgroundColor;
  final IconData icon;
  final Color iconColor;
  final bool showBorder;
  final Color? borderColor;

  const _CircleIconButton({
    required this.onPressed,
    required this.backgroundColor,
    required this.icon,
    required this.iconColor,
    this.showBorder = false,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: showBorder && borderColor != null
                ? Border.all(color: borderColor!)
                : null,
          ),
          padding: EdgeInsets.all(7.w),
          child: Icon(icon, color: iconColor, size: 18.sp),
        ),
      ),
    );
  }
}
