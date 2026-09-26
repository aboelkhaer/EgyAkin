import 'package:egy_akin/features/chat_room/presentation/widgets/chat_room_background.dart';

import '../../../../exports.dart';

/// WhatsApp-style emoji picker shown under the chat composer.
class ChatEmojiPanel extends StatefulWidget {
  final ValueChanged<String> onEmojiSelected;
  final VoidCallback? onBackspace;
  /// Should match the system keyboard height (WhatsApp-style).
  final double height;

  const ChatEmojiPanel({
    super.key,
    required this.onEmojiSelected,
    required this.height,
    this.onBackspace,
  });

  @override
  State<ChatEmojiPanel> createState() => _ChatEmojiPanelState();
}

class _ChatEmojiPanelState extends State<ChatEmojiPanel> {
  static const _categories = <_EmojiCategory>[
    _EmojiCategory(
      icon: Icons.emoji_emotions_outlined,
      emojis: [
        '😀', '😃', '😄', '😁', '😆', '😅', '🤣', '😂', '🙂', '🙃',
        '😉', '😊', '😇', '🥰', '😍', '🤩', '😘', '😗', '☺️', '😚',
        '😙', '🥲', '😋', '😛', '😜', '🤪', '😝', '🤑', '🤗', '🤭',
        '🤫', '🤔', '🤐', '🤨', '😐', '😑', '😶', '😏', '😒', '🙄',
        '😬', '😮‍💨', '🤥', '😌', '😔', '😪', '🤤', '😴', '😷', '🤒',
        '🤕', '🤢', '🤮', '🥵', '🥶', '🥴', '😵', '🤯', '🤠', '🥳',
        '🥸', '😎', '🤓', '🧐', '😕', '😟', '🙁', '☹️', '😮', '😯',
        '😲', '😳', '🥺', '😦', '😧', '😨', '😰', '😥', '😢', '😭',
        '😱', '😖', '😣', '😞', '😓', '😩', '😫', '🥱', '😤', '😡',
        '😠', '🤬', '😈', '👿', '💀', '☠️', '💩', '🤡', '👹', '👺',
        '👻', '👽', '👾', '🤖', '😺', '😸', '😹', '😻', '😼', '😽',
      ],
    ),
    _EmojiCategory(
      icon: Icons.favorite_border_rounded,
      emojis: [
        '👋', '🤚', '🖐️', '✋', '🖖', '👌', '🤌', '🤏', '✌️', '🤞',
        '🤟', '🤘', '🤙', '👈', '👉', '👆', '🖕', '👇', '☝️', '👍',
        '👎', '✊', '👊', '🤛', '🤜', '👏', '🙌', '👐', '🤲', '🤝',
        '🙏', '✍️', '💅', '🤳', '💪', '🦾', '🦿', '🦵', '🦶', '👂',
        '🦻', '👃', '🧠', '🫀', '🫁', '🦷', '🦴', '👀', '👁️', '👅',
        '👄', '💋', '🩸', '👶', '🧒', '👦', '👧', '🧑', '👱', '👨',
        '🧔', '👩', '🧓', '👴', '👵', '🙍', '🙎', '🙅', '🙆', '💁',
        '🙋', '🧏', '🙇', '🤦', '🤷', '👮', '🕵️', '💂', '🥷', '👷',
        '🤴', '👸', '👳', '👲', '🧕', '🤵', '👰', '🤰', '🤱', '👼',
        '🎅', '🤶', '🦸', '🦹', '🧙', '🧚', '🧛', '🧜', '🧝', '🧞',
      ],
    ),
    _EmojiCategory(
      icon: Icons.pets_rounded,
      emojis: [
        '🐶', '🐱', '🐭', '🐹', '🐰', '🦊', '🐻', '🐼', '🐻‍❄️', '🐨',
        '🐯', '🦁', '🐮', '🐷', '🐽', '🐸', '🐵', '🙈', '🙉', '🙊',
        '🐒', '🐔', '🐧', '🐦', '🐤', '🐣', '🐥', '🦆', '🦅', '🦉',
        '🦇', '🐺', '🐗', '🐴', '🦄', '🐝', '🪱', '🐛', '🦋', '🐌',
        '🐞', '🐜', '🪰', '🪲', '🪳', '🦟', '🦗', '🕷️', '🕸️', '🦂',
        '🐢', '🐍', '🦎', '🦖', '🦕', '🐙', '🦑', '🦐', '🦞', '🦀',
        '🐡', '🐠', '🐟', '🐬', '🐳', '🐋', '🦈', '🐊', '🐅', '🐆',
        '🦓', '🦍', '🦧', '🦣', '🐘', '🦛', '🦏', '🐪', '🐫', '🦒',
        '🦘', '🦬', '🐃', '🐂', '🐄', '🐎', '🐖', '🐏', '🐑', '🦙',
        '🐐', '🦌', '🐕', '🐩', '🦮', '🐕‍🦺', '🐈', '🐈‍⬛', '🪶', '🐓',
      ],
    ),
    _EmojiCategory(
      icon: Icons.fastfood_rounded,
      emojis: [
        '🍏', '🍎', '🍐', '🍊', '🍋', '🍌', '🍉', '🍇', '🍓', '🫐',
        '🍈', '🍒', '🍑', '🥭', '🍍', '🥥', '🥝', '🍅', '🍆', '🥑',
        '🥦', '🥬', '🥒', '🌶️', '🫑', '🌽', '🥕', '🫒', '🧄', '🧅',
        '🥔', '🍠', '🥐', '🥯', '🍞', '🥖', '🥨', '🧀', '🥚', '🍳',
        '🧈', '🥞', '🧇', '🥓', '🥩', '🍗', '🍖', '🦴', '🌭', '🍔',
        '🍟', '🍕', '🫓', '🥪', '🥙', '🧆', '🌮', '🌯', '🫔', '🥗',
        '🥘', '🫕', '🥫', '🍝', '🍜', '🍲', '🍛', '🍣', '🍱', '🥟',
        '🦪', '🍤', '🍙', '🍚', '🍘', '🍥', '🥠', '🥮', '🍢', '🍡',
        '🍧', '🍨', '🍦', '🥧', '🧁', '🍰', '🎂', '🍮', '🍭', '🍬',
        '🍫', '🍿', '🍩', '🍪', '🌰', '🥜', '🍯', '🥛', '🍼', '🫖',
      ],
    ),
    _EmojiCategory(
      icon: Icons.sports_soccer_rounded,
      emojis: [
        '⚽️', '🏀', '🏈', '⚾️', '🥎', '🎾', '🏐', '🏉', '🥏', '🎱',
        '🪀', '🏓', '🏸', '🏒', '🏑', '🥍', '🏏', '🪃', '🥅', '⛳️',
        '🪁', '🏹', '🎣', '🤿', '🥊', '🥋', '🎽', '🛹', '🛼', '🛷',
        '⛸', '🥌', '🎿', '⛷️', '🏂', '🪂', '🏋️', '🤼', '🤸', '⛹️',
        '🤺', '🤾', '🏌️', '🏇', '🧘', '🏄', '🏊', '🤽', '🚣', '🧗',
        '🚵', '🚴', '🏆', '🥇', '🥈', '🥉', '🏅', '🎖', '🏵', '🎗',
        '🎫', '🎟', '🎪', '🤹', '🎭', '🩰', '🎨', '🎬', '🎤', '🎧',
        '🎼', '🎹', '🥁', '🪘', '🎷', '🎺', '🪗', '🎸', '🪕', '🎻',
        '🎲', '♟️', '🎯', '🎳', '🎮', '🎰', '🧩', '🚗', '🚕', '🚙',
        '🚌', '🚎', '🏎', '🚓', '🚑', '🚒', '🚐', '🛻', '🚚', '🚛',
      ],
    ),
    _EmojiCategory(
      icon: Icons.lightbulb_outline_rounded,
      emojis: [
        '⌚️', '📱', '📲', '💻', '⌨️', '🖥️', '🖨️', '🖱️', '🖲️', '🕹️',
        '🗜️', '💽', '💾', '💿', '📀', '📼', '📷', '📸', '📹', '🎥',
        '📽️', '🎞️', '📞', '☎️', '📟', '📠', '📺', '📻', '🎙️', '🎚️',
        '🎛️', '🧭', '⏱️', '⏲️', '⏰', '🕰️', '⌛️', '⏳', '📡', '🔋',
        '🔌', '💡', '🔦', '🕯️', '🪔', '🧯', '🛢️', '💸', '💵', '💴',
        '💶', '💷', '🪙', '💰', '💳', '💎', '⚖️', '🪜', '🧰', '🪛',
        '🔧', '🔨', '⚒️', '🛠️', '⛏️', '🪚', '🔩', '⚙️', '🪤', '🧱',
        '⛓️', '🧲', '🔫', '💣', '🧨', '🪓', '🔪', '🗡️', '⚔️', '🛡️',
        '🚬', '⚰️', '🪦', '⚱️', '🏺', '🔮', '📿', '🧿', '💈', '⚗️',
        '🔭', '🔬', '🕳', '🩹', '🩺', '💊', '💉', '🩸', '🧬', '🦠',
      ],
    ),
    _EmojiCategory(
      icon: Icons.flag_outlined,
      emojis: [
        '❤️', '🧡', '💛', '💚', '💙', '💜', '🖤', '🤍', '🤎', '💔',
        '❣️', '💕', '💞', '💓', '💗', '💖', '💘', '💝', '💟', '☮️',
        '✝️', '☪️', '🕉️', '☸️', '✡️', '🔯', '🕎', '☯️', '☦️', '🛐',
        '⛎', '♈️', '♉️', '♊️', '♋️', '♌️', '♍️', '♎️', '♏️', '♐️',
        '♑️', '♒️', '♓️', '🆔', '⚛️', '🉑', '☢️', '☣️', '📴', '📳',
        '🈶', '🈚️', '🈸', '🈺', '🈷️', '✴️', '🆚', '💮', '🉐', '㊙️',
        '㊗️', '🈴', '🈵', '🈹', '🈲', '🅰️', '🅱️', '🆎', '🆑', '🅾️',
        '🆘', '❌', '⭕️', '🛑', '⛔️', '📛', '🚫', '💯', '💢', '♨️',
        '🚷', '🚯', '🚳', '🚱', '🔞', '📵', '🚭', '❗️', '❕', '❓',
        '❔', '‼️', '⁉️', '🔅', '🔆', '〽️', '⚠️', '🚸', '🔱', '⚜️',
      ],
    ),
  ];

  int _selectedCategory = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final borderColor =
            (isDark ? AppColors.darkBorder : Colors.grey.shade300)
                .withOpacity(0.45);
        final iconColor =
            isDark ? AppColors.darkDescription : AppColors.description;
        final selectedColor =
            isDark ? AppColors.darkPrimary : AppColors.primary;
        final emojis = _categories[_selectedCategory].emojis;

        return ChatRoomGlassSurface(
          isDark: isDark,
          border: Border(top: BorderSide(color: borderColor, width: 1)),
          // Same footprint as the system keyboard — no extra SafeArea bottom
          // (keyboard height already covers the home-indicator region).
          child: SizedBox(
            height: widget.height,
            width: double.infinity,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final barH = 44.h;
                // While the panel is animating open/closed, height can be
                // smaller than the bar — avoid RenderFlex overflow.
                final canShowBar = constraints.maxHeight >= barH;
                final canShowGrid = constraints.maxHeight > barH + 12;

                return Column(
                  children: [
                    if (canShowGrid)
                      Expanded(
                        child: GridView.builder(
                          padding:
                              EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 4.h),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 8,
                            mainAxisSpacing: 4.h,
                            crossAxisSpacing: 2.w,
                          ),
                          itemCount: emojis.length,
                          itemBuilder: (context, index) {
                            final emoji = emojis[index];
                            return Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () => widget.onEmojiSelected(emoji),
                                borderRadius: BorderRadius.circular(8.r),
                                child: Center(
                                  child: Text(
                                    emoji,
                                    style: TextStyle(fontSize: 24.sp),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    else
                      const Spacer(),
                    if (canShowBar)
                      SizedBox(
                        height: barH,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(color: borderColor, width: 1),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6.w),
                            child: Row(
                              children: [
                                Expanded(
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: _categories.length,
                                    separatorBuilder: (_, __) =>
                                        SizedBox(width: 2.w),
                                    itemBuilder: (context, index) {
                                      final selected =
                                          index == _selectedCategory;
                                      return IconButton(
                                        onPressed: () {
                                          setState(
                                            () => _selectedCategory = index,
                                          );
                                        },
                                        padding: EdgeInsets.zero,
                                        constraints: BoxConstraints(
                                          minWidth: 36.w,
                                          minHeight: 36.h,
                                        ),
                                        icon: Icon(
                                          _categories[index].icon,
                                          size: 20.sp,
                                          color: selected
                                              ? selectedColor
                                              : iconColor,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                if (widget.onBackspace != null)
                                  IconButton(
                                    onPressed: widget.onBackspace,
                                    tooltip: 'Backspace',
                                    padding: EdgeInsets.zero,
                                    constraints: BoxConstraints(
                                      minWidth: 40.w,
                                      minHeight: 36.h,
                                    ),
                                    icon: Icon(
                                      Icons.backspace_outlined,
                                      size: 20.sp,
                                      color: iconColor,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _EmojiCategory {
  final IconData icon;
  final List<String> emojis;

  const _EmojiCategory({
    required this.icon,
    required this.emojis,
  });
}
