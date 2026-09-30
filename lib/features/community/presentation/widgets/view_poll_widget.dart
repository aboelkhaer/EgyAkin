import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';
import 'package:egy_akin/features/poll_voters/presentation/cubit/poll_voters_cubit.dart';
import 'package:egy_akin/features/poll_voters/presentation/pages/poll_voters_screen.dart';
import '../../../../exports.dart';
import 'package:egy_akin/app/shared/functions/permissions_helper.dart';

class ViewPollWidget extends StatefulWidget {
  final PollModelResponse? poll;
  final Set<int> selectedOptions;
  final int? selectedOption;
  final Function(int? optionId) onOptionSelected;
  final Function(int optionId, bool isSelected) onOptionToggled;
  final bool initiallyExpanded;
  final Function(String pollId, String option)? onAddOption;
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;

  const ViewPollWidget({
    super.key,
    required this.poll,
    required this.selectedOptions,
    required this.selectedOption,
    required this.onOptionSelected,
    required this.onOptionToggled,
    this.initiallyExpanded = false,
    this.onAddOption,
    required this.currentDoctorModel,
    required this.homeDataModel,
  });

  @override
  State<ViewPollWidget> createState() => _ViewPollWidgetState();
}

class _ViewPollWidgetState extends State<ViewPollWidget>
    with SingleTickerProviderStateMixin {
  static const int maxOptionLength = 60;

  late bool showAllOptions;
  final TextEditingController _newOptionController = TextEditingController();
  bool _isAddingOption = false;
  late final AnimationController _enterCtrl;

  @override
  void initState() {
    super.initState();
    showAllOptions = widget.initiallyExpanded;
    _enterCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 780),
    )..forward();
  }

  @override
  void dispose() {
    _newOptionController.dispose();
    _enterCtrl.dispose();
    super.dispose();
  }

  Future<bool> _ensurePermission(
    AppPermissions permission,
    String deniedMessage,
  ) async {
    final hasPermission = await PermissionHelper.hasPermission(permission);
    if (hasPermission) return true;
    if (!mounted) return false;
    showCustomDialog(
      context: context,
      title: context.tr(AppStrings.attention),
      description: context.tr(deniedMessage),
      coloredButtonText: context.tr(AppStrings.ok),
      coloredButtonOnTap: () => Navigator.of(context).pop(),
      isNoColorShow: false,
    );
    return false;
  }

  Future<void> _addNewOption() async {
    final text = _newOptionController.text.trim();
    if (text.isEmpty) return;

    final allowed = await _ensurePermission(
      AppPermissions.addPollOption,
      AppStrings.youDontHavePermissionToAddPollOptions,
    );
    if (!allowed) return;

    setState(() => _isAddingOption = true);

    await widget.onAddOption!(widget.poll!.id.toString(), text);

    if (!mounted) return;
    setState(() {
      _isAddingOption = false;
      _newOptionController.clear();
    });
  }

  Future<void> _voteSingle(int? optionId) async {
    final allowed = await _ensurePermission(
      AppPermissions.votePoll,
      AppStrings.youDontHavePermissionToVoteInPolls,
    );
    if (!allowed) return;
    widget.onOptionSelected(optionId);
  }

  Future<void> _voteMulti(int optionId, bool selected) async {
    final allowed = await _ensurePermission(
      AppPermissions.votePoll,
      AppStrings.youDontHavePermissionToVoteInPolls,
    );
    if (!allowed) return;
    widget.onOptionToggled(optionId, selected);
  }

  Future<void> _openVoters(PollOptionsModelResponse option) async {
    if ((option.votesCount ?? 0) <= 0) return;

    final allowed = await _ensurePermission(
      AppPermissions.viewPollVoters,
      AppStrings.youDontHavePermissionToViewPollVoters,
    );
    if (!allowed || !mounted) return;

    showCustomBottomSheet(
      context: context,
      builder: (context) {
        return BlocProvider(
          create: (context) => PollVotersCubit(sl()),
          child: PollVotersScreen(
            pollId: widget.poll!.id.toString(),
            optionId: option.id.toString(),
            currentDoctorModel: widget.currentDoctorModel,
            homeDataModel: widget.homeDataModel,
          ),
        );
      },
    );
  }

  void _unfocus() => FocusManager.instance.primaryFocus?.unfocus();

  @override
  Widget build(BuildContext context) {
    if (widget.poll == null) return const SizedBox.shrink();

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final primary = HomeDashboardColors.primary(isDark);
        final optionsList = widget.poll!.options ?? const [];
        final optionsToShow =
            showAllOptions ? optionsList : optionsList.take(2).toList();
        final totalVotes = optionsList.fold<int>(
          0,
          (sum, opt) => sum + (opt.votesCount ?? 0),
        );
        final allowMultiple = widget.poll?.allowMultipleChoice ?? false;
        // Multi-choice: one person can vote on many options, so summing
        // votes overcounts members. Max option votes ≈ unique voters.
        final memberCount = allowMultiple
            ? optionsList.fold<int>(
                0,
                (max, opt) =>
                    (opt.votesCount ?? 0) > max ? (opt.votesCount ?? 0) : max,
              )
            : totalVotes;
        final leadingVotes = optionsList.fold<int>(
          0,
          (max, opt) =>
              (opt.votesCount ?? 0) > max ? (opt.votesCount ?? 0) : max,
        );

        return GestureDetector(
          onTap: _unfocus,
          behavior: HitTestBehavior.deferToChild,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
            child: FadeTransition(
              opacity: CurvedAnimation(
                parent: _enterCtrl,
                curve: const Interval(0, 0.45, curve: Curves.easeOut),
              ),
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.06),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: _enterCtrl,
                    curve: const Interval(0, 0.55, curve: Curves.easeOutCubic),
                  ),
                ),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: HomeDashboardColors.cardBg(isDark),
                    borderRadius: BorderRadius.circular(18.r),
                    border: Border.all(
                      color: isDark
                          ? Colors.white.withOpacity(0.08)
                          : const Color(0xFFE9E5F8),
                    ),
                    boxShadow: isDark
                        ? null
                        : [
                            BoxShadow(
                              color: primary.withOpacity(0.09),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _PollHeader(
                        isDark: isDark,
                        primary: primary,
                        question: widget.poll?.question,
                        memberCount: memberCount,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(12.w, 4.h, 12.w, 12.h),
                        child: Column(
                          children: [
                            ...optionsToShow.asMap().entries.map((entry) {
                              final globalIndex = showAllOptions
                                  ? entry.key
                                  : optionsList.indexOf(entry.value);
                              final option = entry.value;
                              final votes = option.votesCount ?? 0;
                              final percentage =
                                  totalVotes > 0 ? votes / totalVotes : 0.0;
                              final selected = allowMultiple
                                  ? widget.selectedOptions.contains(option.id)
                                  : widget.selectedOption == option.id;
                              final isLeading = totalVotes > 0 &&
                                  votes > 0 &&
                                  votes == leadingVotes;
                              final start =
                                  (0.18 + entry.key * 0.1).clamp(0.0, 0.75);
                              final end = (start + 0.35).clamp(0.0, 1.0);

                              return _StaggeredItem(
                                animation: _enterCtrl,
                                start: start,
                                end: end,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    bottom:
                                        entry.key == optionsToShow.length - 1
                                            ? 0
                                            : 8.h,
                                  ),
                                  child: _PollOptionTile(
                                    isDark: isDark,
                                    primary: primary,
                                    index: globalIndex < 0
                                        ? entry.key
                                        : globalIndex,
                                    label: option.optionText ?? '',
                                    votes: votes,
                                    percentage: percentage,
                                    selected: selected,
                                    isLeading: isLeading,
                                    allowMultiple: allowMultiple,
                                    onTap: () {
                                      _unfocus();
                                      if (option.id == null) return;
                                      if (allowMultiple) {
                                        _voteMulti(option.id!, !selected);
                                      } else {
                                        _voteSingle(option.id);
                                      }
                                    },
                                    onVotesTap: () {
                                      _unfocus();
                                      _openVoters(option);
                                    },
                                  ),
                                ),
                              );
                            }),
                            if ((widget.poll?.allowAddOptions ?? false) &&
                                (optionsList.length == 2 ||
                                    showAllOptions)) ...[
                              SizedBox(height: 10.h),
                              _AddOptionRow(
                                isDark: isDark,
                                primary: primary,
                                controller: _newOptionController,
                                isAdding: _isAddingOption,
                                maxLength: maxOptionLength,
                                onAdd: _addNewOption,
                              ),
                            ],
                            if (optionsList.length > 2) ...[
                              SizedBox(height: 10.h),
                              _ExpandToggle(
                                isDark: isDark,
                                primary: primary,
                                expanded: showAllOptions,
                                remaining: optionsList.length - 2,
                                onTap: () {
                                  _unfocus();
                                  setState(() {
                                    showAllOptions = !showAllOptions;
                                  });
                                },
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _StaggeredItem extends StatelessWidget {
  final Animation<double> animation;
  final double start;
  final double end;
  final Widget child;

  const _StaggeredItem({
    required this.animation,
    required this.start,
    required this.end,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final curved = CurvedAnimation(
      parent: animation,
      curve: Interval(start, end, curve: Curves.easeOutCubic),
    );
    return FadeTransition(
      opacity: curved,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.12),
          end: Offset.zero,
        ).animate(curved),
        child: child,
      ),
    );
  }
}

class _PollHeader extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final String? question;
  final int memberCount;

  const _PollHeader({
    required this.isDark,
    required this.primary,
    required this.question,
    required this.memberCount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 34.r,
                height: 34.r,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      primary,
                      primary.withOpacity(0.72),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(11.r),
                  boxShadow: [
                    BoxShadow(
                      color: primary.withOpacity(0.28),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.how_to_vote_rounded,
                  color: Colors.white,
                  size: 18.sp,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.tr(AppStrings.poll).toUpperCase(),
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.2,
                        color: primary,
                      ),
                    ),
                    if (question?.isNotEmpty ?? false) ...[
                      SizedBox(height: 2.h),
                      Text(
                        question!,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w800,
                          height: 1.25,
                          fontFamily: 'Tajawal',
                          color: HomeDashboardColors.title(isDark),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              TweenAnimationBuilder<double>(
                tween: Tween<double>(end: memberCount.toDouble()),
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOutCubic,
                builder: (context, value, _) {
                  return Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: primary.withOpacity(isDark ? 0.18 : 0.09),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.people_alt_rounded,
                          size: 13.sp,
                          color: primary,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          '${value.round()}',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w800,
                            color: primary,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PollOptionTile extends StatefulWidget {
  final bool isDark;
  final Color primary;
  final int index;
  final String label;
  final int votes;
  final double percentage;
  final bool selected;
  final bool isLeading;
  final bool allowMultiple;
  final VoidCallback onTap;
  final VoidCallback onVotesTap;

  const _PollOptionTile({
    required this.isDark,
    required this.primary,
    required this.index,
    required this.label,
    required this.votes,
    required this.percentage,
    required this.selected,
    required this.isLeading,
    required this.allowMultiple,
    required this.onTap,
    required this.onVotesTap,
  });

  @override
  State<_PollOptionTile> createState() => _PollOptionTileState();
}

class _PollOptionTileState extends State<_PollOptionTile> {
  @override
  Widget build(BuildContext context) {
    final pct = (widget.percentage * 100).round();
    final selected = widget.selected;
    final isLeading = widget.isLeading;
    final primary = widget.primary;
    final isDark = widget.isDark;
    final accent = isLeading && !selected
        ? const Color(0xFFD97706)
        : primary;

    final track = isDark
        ? Colors.white.withOpacity(0.05)
        : const Color(0xFFF6F4FC);
    final fillColors = selected
        ? [primary.withOpacity(isDark ? 0.42 : 0.26), primary.withOpacity(0.08)]
        : isLeading
            ? [
                const Color(0xFFF59E0B).withOpacity(isDark ? 0.32 : 0.18),
                const Color(0xFFFBBF24).withOpacity(0.06),
              ]
            : [
                primary.withOpacity(isDark ? 0.22 : 0.12),
                primary.withOpacity(0.03),
              ];

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(14.r),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeOutCubic,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(
                color: selected
                    ? primary
                    : isLeading
                        ? const Color(0xFFF59E0B).withOpacity(0.5)
                        : HomeDashboardColors.border(isDark).withOpacity(0.75),
                width: 1.2,
              ),
              boxShadow: selected
                  ? [
                      BoxShadow(
                        color: primary.withOpacity(isDark ? 0.22 : 0.14),
                        blurRadius: 14,
                        offset: const Offset(0, 5),
                      ),
                    ]
                  : null,
            ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(13.r),
            child: Stack(
              children: [
                Positioned.fill(child: ColoredBox(color: track)),
                Positioned.fill(
                  child: TweenAnimationBuilder<double>(
                    tween: Tween<double>(
                      end: widget.percentage.clamp(0.0, 1.0),
                    ),
                    duration: const Duration(milliseconds: 650),
                    curve: Curves.easeOutCubic,
                    builder: (context, value, _) {
                      return Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: FractionallySizedBox(
                          widthFactor: value == 0 ? 0.001 : value,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: fillColors),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _IndexChip(
                          index: widget.index,
                          selected: selected,
                          isLeading: isLeading,
                          primary: primary,
                          isDark: isDark,
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            widget.label,
                            style: TextStyle(
                              fontSize: 13.sp,
                              // Keep weight stable so wrap count doesn't jump
                              // when selection changes.
                              fontWeight: FontWeight.w700,
                              height: 1.3,
                              fontFamily: 'Tajawal',
                              color: HomeDashboardColors.title(isDark),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        // Fixed trailing slot so % never reflows option text.
                        SizedBox(
                          width: 72.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: widget.votes > 0
                                    ? widget.onVotesTap
                                    : null,
                                child: Container(
                                  width: 42.w,
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(vertical: 4.h),
                                  decoration: BoxDecoration(
                                    color: (selected || widget.votes > 0)
                                        ? accent.withOpacity(
                                            isDark ? 0.22 : 0.12,
                                          )
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: Text(
                                    '$pct%',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w800,
                                      color: selected ||
                                              widget.votes > 0 ||
                                              isLeading
                                          ? accent
                                          : HomeDashboardColors.subtitle(
                                              isDark,
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.w),
                              _SelectionMark(
                                selected: selected,
                                allowMultiple: widget.allowMultiple,
                                primary: primary,
                                isDark: isDark,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _IndexChip extends StatelessWidget {
  final int index;
  final bool selected;
  final bool isLeading;
  final Color primary;
  final bool isDark;

  const _IndexChip({
    required this.index,
    required this.selected,
    required this.isLeading,
    required this.primary,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final label = (index + 1).toString().padLeft(2, '0');
    return AnimatedContainer(
      duration: const Duration(milliseconds: 240),
      width: 28.r,
      height: 28.r,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: selected
            ? primary
            : isLeading
                ? const Color(0xFFF59E0B)
                : (isDark
                    ? Colors.white.withOpacity(0.07)
                    : Colors.white.withOpacity(0.9)),
        borderRadius: BorderRadius.circular(9.r),
        border: selected || isLeading
            ? null
            : Border.all(
                color: HomeDashboardColors.border(isDark).withOpacity(0.85),
              ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.w800,
          color: selected || isLeading
              ? Colors.white
              : HomeDashboardColors.subtitle(isDark),
        ),
      ),
    );
  }
}

class _SelectionMark extends StatelessWidget {
  final bool selected;
  final bool allowMultiple;
  final Color primary;
  final bool isDark;

  const _SelectionMark({
    required this.selected,
    required this.allowMultiple,
    required this.primary,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutBack,
      width: 18.r,
      height: 18.r,
      decoration: BoxDecoration(
        color: selected ? primary : Colors.transparent,
        shape: allowMultiple ? BoxShape.rectangle : BoxShape.circle,
        borderRadius: allowMultiple ? BorderRadius.circular(5.r) : null,
        border: Border.all(
          color: selected
              ? primary
              : HomeDashboardColors.subtitle(isDark).withOpacity(0.4),
          width: 1.5,
        ),
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 180),
        child: selected
            ? Icon(
                allowMultiple ? Icons.check_rounded : Icons.circle,
                key: const ValueKey('on'),
                size: allowMultiple ? 12.sp : 7.sp,
                color: Colors.white,
              )
            : const SizedBox.shrink(key: ValueKey('off')),
      ),
    );
  }
}

class _AddOptionRow extends StatefulWidget {
  final bool isDark;
  final Color primary;
  final TextEditingController controller;
  final bool isAdding;
  final int maxLength;
  final VoidCallback onAdd;

  const _AddOptionRow({
    required this.isDark,
    required this.primary,
    required this.controller,
    required this.isAdding,
    required this.maxLength,
    required this.onAdd,
  });

  @override
  State<_AddOptionRow> createState() => _AddOptionRowState();
}

class _AddOptionRowState extends State<_AddOptionRow>
    with WidgetsBindingObserver {
  late final FocusNode _focusNode;
  bool _focused = false;
  bool _didScrollForFocus = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _focusNode = FocusNode()
      ..addListener(() {
        if (!mounted) return;
        final focused = _focusNode.hasFocus;
        setState(() => _focused = focused);
        if (focused) {
          try {
            ShowSingleFeedCubit.get(context).commentFocusNode.unfocus();
          } catch (_) {}
          _didScrollForFocus = false;
          _scrollAfterKeyboardOpens();
        } else {
          _didScrollForFocus = false;
        }
      });
  }

  @override
  void didChangeMetrics() {
    // Fallback if focus fired before keyboard inset existed.
    if (_focused && !_didScrollForFocus) {
      _scrollAfterKeyboardOpens();
    }
  }

  Future<void> _scrollAfterKeyboardOpens() async {
    // Keyboard open animation is ~250–300ms; wait for final inset once.
    await Future<void>.delayed(const Duration(milliseconds: 320));
    if (!mounted || !_focused || _didScrollForFocus) return;
    if (MediaQuery.viewInsetsOf(context).bottom <= 0) return;
    _didScrollForFocus = true;
    // Layout spacer/padding with final keyboard height, then scroll.
    await WidgetsBinding.instance.endOfFrame;
    if (!mounted || !_focused) return;
    await _scrollFieldAboveKeyboard();
  }

  Future<void> _scrollFieldAboveKeyboard() async {
    final media = MediaQuery.of(context);
    final keyboard = media.viewInsets.bottom;
    if (keyboard <= 0) return;

    final renderObject = context.findRenderObject();
    if (renderObject is! RenderBox || !renderObject.hasSize) return;

    final scrollableState = Scrollable.maybeOf(context);
    if (scrollableState == null) return;
    final position = scrollableState.position;
    if (!position.hasPixels) return;

    // Ensure comment composer doesn't steal focus / rise with keyboard.
    try {
      final feedCubit = ShowSingleFeedCubit.get(context);
      if (feedCubit.commentFocusNode.hasFocus) {
        feedCubit.commentFocusNode.unfocus();
      }
    } catch (_) {}

    final fieldTop = renderObject.localToGlobal(Offset.zero).dy;
    final fieldBottom = fieldTop + renderObject.size.height;
    // Comment bar stays behind the keyboard while this field is focused.
    final desiredBottom = media.size.height - keyboard - 12;
    final delta = fieldBottom - desiredBottom;
    if (delta <= 1) return;

    final target = (position.pixels + delta).clamp(
      position.minScrollExtent,
      position.maxScrollExtent,
    );
    await position.animateTo(
      target,
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primary = widget.primary;
    final isDark = widget.isDark;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 240),
      curve: Curves.easeOutCubic,
      width: double.infinity,
      height: 48.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: _focused
              ? [
                  primary.withOpacity(isDark ? 0.22 : 0.12),
                  primary.withOpacity(isDark ? 0.1 : 0.05),
                ]
              : [
                  isDark
                      ? Colors.white.withOpacity(0.06)
                      : const Color(0xFFF5F2FF),
                  isDark
                      ? Colors.white.withOpacity(0.03)
                      : const Color(0xFFFAF8FF),
                ],
        ),
        border: Border.all(
          color: _focused
              ? primary
              : primary.withOpacity(isDark ? 0.32 : 0.2),
          width: _focused ? 1.5 : 1,
        ),
        boxShadow: _focused
            ? [
                BoxShadow(
                  color: primary.withOpacity(0.16),
                  blurRadius: 14,
                  offset: const Offset(0, 5),
                ),
              ]
            : [
                BoxShadow(
                  color: primary.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 8.w),
          AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            width: 30.r,
            height: 30.r,
            decoration: BoxDecoration(
              color: primary.withOpacity(_focused ? 0.2 : 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.add_rounded,
              size: 18.sp,
              color: primary,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Theme(
              data: Theme.of(context).copyWith(
                inputDecorationTheme: const InputDecorationTheme(
                  filled: false,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  isDense: true,
                ),
              ),
              child: TextField(
                controller: widget.controller,
                focusNode: _focusNode,
                maxLength: widget.maxLength,
                textAlign: TextAlign.start,
                textAlignVertical: TextAlignVertical.center,
                textInputAction: TextInputAction.done,
                scrollPadding: EdgeInsets.zero,
                onTapOutside: (_) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                onSubmitted: (_) {
                  FocusManager.instance.primaryFocus?.unfocus();
                  widget.onAdd();
                },
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                  fontFamily: 'Tajawal',
                  color: HomeDashboardColors.title(isDark),
                ),
                decoration: InputDecoration(
                  filled: false,
                  isDense: true,
                  counterText: '',
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: context.tr(AppStrings.addANewOption),
                  hintStyle: TextStyle(
                    fontSize: 12.5.sp,
                    fontWeight: FontWeight.w500,
                    height: 1.2,
                    color: HomeDashboardColors.subtitle(isDark),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 14.h),
                ),
              ),
            ),
          ),
          SizedBox(width: 6.w),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.isAdding
                  ? null
                  : () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      widget.onAdd();
                    },
              borderRadius: BorderRadius.circular(12.r),
              child: Ink(
                width: 36.r,
                height: 36.r,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      primary,
                      primary.withOpacity(0.78),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: primary.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 180),
                    child: widget.isAdding
                        ? SizedBox(
                            key: const ValueKey('loading'),
                            width: 14.r,
                            height: 14.r,
                            child: const CircularProgressIndicator(
                              strokeWidth: 1.8,
                              color: Colors.white,
                            ),
                          )
                        : Icon(
                            Icons.arrow_upward_rounded,
                            key: const ValueKey('send'),
                            color: Colors.white,
                            size: 18.sp,
                          ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 6.w),
        ],
      ),
    );
  }
}

class _ExpandToggle extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final bool expanded;
  final int remaining;
  final VoidCallback onTap;

  const _ExpandToggle({
    required this.isDark,
    required this.primary,
    required this.expanded,
    required this.remaining,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final label = expanded
        ? context.tr(AppStrings.seeLess)
        : '${context.tr(AppStrings.seeMore)} (+$remaining)';

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 8.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: primary.withOpacity(0.18)),
            color: primary.withOpacity(isDark ? 0.12 : 0.05),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: primary,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(width: 4.w),
              AnimatedRotation(
                turns: expanded ? 0.5 : 0,
                duration: const Duration(milliseconds: 220),
                child: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 18.sp,
                  color: primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
