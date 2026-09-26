import 'package:egy_akin/exports.dart';
import 'package:egy_akin/features/chat_room/presentation/widgets/chat_room_background.dart';

enum ChatSelectionIntent { forward, delete }

/// WhatsApp-style top bar while multi-selecting messages.
class ChatSelectionHeader extends StatelessWidget {
  final int selectedCount;
  final ChatSelectionIntent intent;
  final VoidCallback onClose;
  final VoidCallback? onForward;
  final VoidCallback? onDelete;

  const ChatSelectionHeader({
    super.key,
    required this.selectedCount,
    required this.intent,
    required this.onClose,
    this.onForward,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;
        final borderColor =
            (isDarkMode ? AppColors.darkBorder : Colors.grey.shade300)
                .withOpacity(0.55);
        final titleColor =
            isDarkMode ? Colors.white : const Color(0xFF0B141A);
        final canAct = selectedCount > 0;
        final showForward = intent == ChatSelectionIntent.forward;
        final showDelete = intent == ChatSelectionIntent.delete;

        return ChatRoomGlassSurface(
          isDark: isDarkMode,
          border: Border(
            bottom: BorderSide(color: borderColor, width: 1),
          ),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
              child: Row(
                children: [
                  IconButton(
                    onPressed: onClose,
                    padding: EdgeInsets.zero,
                    constraints:
                        BoxConstraints(minWidth: 40.w, minHeight: 40.h),
                    visualDensity: VisualDensity.compact,
                    icon: Icon(
                      Icons.close_rounded,
                      color: AppColors.primary,
                      size: 22.sp,
                    ),
                  ),
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      switchInCurve: Curves.easeOutCubic,
                      switchOutCurve: Curves.easeInCubic,
                      transitionBuilder: (child, animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0, 0.25),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          ),
                        );
                      },
                      child: Text(
                        selectedCount <= 0
                            ? context.tr(AppStrings.selectMessages)
                            : '$selectedCount ${context.tr(AppStrings.selectedLower)}',
                        key: ValueKey('sel_$selectedCount'),
                        style: TextStyle(
                          color: titleColor,
                          fontSize: 13.5.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  if (showForward)
                    IconButton(
                      onPressed: canAct ? onForward : null,
                      padding: EdgeInsets.zero,
                      constraints:
                          BoxConstraints(minWidth: 40.w, minHeight: 40.h),
                      visualDensity: VisualDensity.compact,
                      icon: Icon(
                        Icons.forward_rounded,
                        color: canAct
                            ? AppColors.primary
                            : AppColors.primary.withOpacity(0.35),
                        size: 22.sp,
                      ),
                    ),
                  if (showDelete)
                    IconButton(
                      onPressed: canAct ? onDelete : null,
                      padding: EdgeInsets.zero,
                      constraints:
                          BoxConstraints(minWidth: 40.w, minHeight: 40.h),
                      visualDensity: VisualDensity.compact,
                      icon: Icon(
                        Icons.delete_outline_rounded,
                        color: canAct
                            ? const Color(0xFFE5484D)
                            : const Color(0xFFE5484D).withOpacity(0.35),
                        size: 22.sp,
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
