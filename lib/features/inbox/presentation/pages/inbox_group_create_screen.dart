import 'package:egy_akin/app/shared/functions/animate_to_right_end_of_screen.dart';
import 'package:egy_akin/features/chat/data/mappers/chat_mappers.dart';
import 'package:egy_akin/features/chat/data/models/chat_api_models.dart';
import 'package:egy_akin/features/chat/data/services/chat_realtime_service.dart';
import 'package:egy_akin/features/chat_room/domain/repositories/chat_room_repo.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';
import 'package:egy_akin/features/inbox/presentation/cubit/inbox_cubit.dart';
import 'package:egy_akin/features/inbox/presentation/cubit/inbox_member_search_cubit.dart';
import 'package:egy_akin/features/inbox/presentation/cubit/inbox_member_search_state.dart';

import '../../../../exports.dart';
import '../../../../injection_container.dart' as di;

class InboxGroupCreateScreen extends StatefulWidget {
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;

  const InboxGroupCreateScreen({
    super.key,
    required this.currentDoctorModel,
    required this.homeDataModel,
  });

  @override
  State<InboxGroupCreateScreen> createState() => _InboxGroupCreateScreenState();
}

class _InboxGroupCreateScreenState extends State<InboxGroupCreateScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _searchFocus = FocusNode();
  final List<ChatUserModel> _selected = [];
  final Set<int> _onlineUserIds = {};
  final ScrollController _selectedScrollController = ScrollController();
  StreamSubscription<ChatRealtimeEvent>? _presenceSub;
  late final AnimationController _intro;
  late final Animation<double> _introFade;
  late final Animation<Offset> _introSlide;
  bool _creating = false;
  bool _nameFocused = false;
  bool _searchFocused = false;

  @override
  void initState() {
    super.initState();
    _intro = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 520),
    );
    _introFade = CurvedAnimation(parent: _intro, curve: Curves.easeOutCubic);
    _introSlide = Tween<Offset>(
      begin: const Offset(0, 0.04),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _intro, curve: Curves.easeOutCubic));

    _nameFocus.addListener(() {
      if (mounted) setState(() => _nameFocused = _nameFocus.hasFocus);
    });
    _searchFocus.addListener(() {
      if (mounted) setState(() => _searchFocused = _searchFocus.hasFocus);
    });
    _nameController.addListener(() {
      if (mounted) setState(() {});
    });
    _searchController.addListener(() {
      if (mounted) setState(() {});
    });
    _listenToPresence();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _intro.forward();
      _nameFocus.requestFocus();
    });
  }

  void _listenToPresence() {
    if (!sl.isRegistered<ChatRealtimeService>()) return;
    final realtime = sl<ChatRealtimeService>();
    _seedOnlineIds(realtime);
    unawaited(_refreshPresence(realtime));
    _presenceSub = realtime.events.listen((event) {
      if (event is! ChatAppPresenceChangedEvent) return;
      final bool changed;
      if (event.isOnline) {
        changed = _onlineUserIds.add(event.userId);
      } else {
        final keepOnline = sl.isRegistered<InboxCubit>() &&
            sl<InboxCubit>().onlineCounterpartUserIds.contains(event.userId);
        changed = keepOnline ? false : _onlineUserIds.remove(event.userId);
      }
      if (changed && mounted) setState(() {});
    });
  }

  void _seedOnlineIds(ChatRealtimeService realtime) {
    _onlineUserIds
      ..clear()
      ..addAll(realtime.appOnlineUserIds);
    if (sl.isRegistered<InboxCubit>()) {
      _onlineUserIds.addAll(sl<InboxCubit>().onlineCounterpartUserIds);
    }
  }

  Future<void> _refreshPresence(ChatRealtimeService realtime) async {
    final userId = widget.currentDoctorModel.id;
    if (userId == null) return;
    await realtime.ensureAppPresence(
      currentUserId: userId,
      forceReenter: true,
    );
    await realtime.refreshAppPresenceSnapshot();
    if (!mounted) return;
    _seedOnlineIds(realtime);
    setState(() {});
  }

  void _dismissKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  void dispose() {
    _presenceSub?.cancel();
    _intro.dispose();
    _nameController.dispose();
    _searchController.dispose();
    _nameFocus.dispose();
    _searchFocus.dispose();
    _selectedScrollController.dispose();
    super.dispose();
  }

  void _toggleUser(ChatUserModel user) {
    final wasSelected = _selected.any((u) => u.id == user.id);
    setState(() {
      final idx = _selected.indexWhere((u) => u.id == user.id);
      if (idx >= 0) {
        _selected.removeAt(idx);
      } else {
        _selected.add(user);
      }
    });
    if (!wasSelected) {
      animateToRightEndOfScreen(_selectedScrollController);
    }
  }

  void _openDoctorProfile(ChatUserModel user) {
    final doctorId = user.id;
    if (doctorId == null) return;
    final home = widget.homeDataModel;
    navigatorKey.currentState?.pushNamed(
      AppRoutes.doctorInfoView,
      arguments: AppRoutesArgs.doctorInfoViewRouteArgs(
        doctorId: doctorId.toString(),
        initialIndex: 0,
        currentDoctorModel: widget.currentDoctorModel,
        isSyndicateCardRequired: home.isSyndicateCardRequired.toString(),
        accountVerification: home.verified ?? false,
        currentDoctorRole: home.role.toString(),
        currentDoctorPoints:
            int.tryParse(home.scoreValue?.toString() ?? '') ?? 0,
        homeDataModel: home,
        isNavigateToTheButtonOfInformationTab: false,
      ),
    );
  }

  void _clearSearch(BuildContext context) {
    _searchController.clear();
    context.read<InboxMemberSearchCubit>().onQueryChanged('');
    _searchFocus.requestFocus();
  }

  Future<void> _createGroup() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      customSnackBar(
        context: context,
        message: context.tr(AppStrings.groupNameRequired),
      );
      _nameFocus.requestFocus();
      return;
    }
    if (_selected.isEmpty) {
      customSnackBar(
        context: context,
        message: context.tr(AppStrings.selectAtLeastOneMember),
      );
      _searchFocus.requestFocus();
      return;
    }

    setState(() => _creating = true);
    final repo = di.sl<ChatRoomRepository>();
    final result = await repo.createGroup(
      name: name,
      participantIds: _selected.map((u) => u.id).whereType<int>().toList(),
    );
    if (!mounted) return;
    setState(() => _creating = false);

    result.fold(
      (failure) => customSnackBar(context: context, message: failure.message),
      (response) {
        final conversation = response.data;
        final conversationId = conversation?.id;
        if (conversationId == null) {
          customSnackBar(
            context: context,
            message: context.tr(AppStrings.somethingWentWrong),
          );
          return;
        }

        // Replace this create screen so Back from the new chat lands on Chats.
        unawaited(di.sl<InboxCubit>().refresh());
        navigatorKey.currentState?.pushReplacementNamed(
          AppRoutes.chatRoom,
          arguments: AppRoutesArgs.chatRoomRouteArgs(
            currentDoctorModel: widget.currentDoctorModel,
            homeDataModel: widget.homeDataModel,
            peerDisplayName: name,
            peerInitials: name.isNotEmpty ? name[0].toUpperCase() : 'G',
            chatType: ChatApiType.group,
            contextId: conversationId,
            conversationId: conversationId,
            peerImageUrl: conversation?.image,
            initialParticipants:
                (conversation?.participants?.isNotEmpty ?? false)
                    ? conversation!.participants
                    : List<ChatUserModel>.of(_selected),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.sl<InboxMemberSearchCubit>(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
          final primary = HomeDashboardColors.primary(isDark);
          final title = HomeDashboardColors.title(isDark);
          final subtitle = HomeDashboardColors.subtitle(isDark);
          final scaffold =
              isDark ? AppColors.darkScaffoldBG : const Color(0xFFF5F6FA);
          final canCreate = _nameController.text.trim().isNotEmpty &&
              _selected.isNotEmpty &&
              !_creating;

          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light,
              statusBarBrightness: Brightness.dark,
              systemStatusBarContrastEnforced: false,
            ),
            child: GestureDetector(
              onTap: _dismissKeyboard,
              behavior: HitTestBehavior.deferToChild,
              child: Scaffold(
                backgroundColor: scaffold,
                body: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      height: 240.h,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: isDark
                                ? [primary.withOpacity(0.22), scaffold]
                                : [primary.withOpacity(0.10), scaffold],
                          ),
                        ),
                      ),
                    ),
                    SafeArea(
                      child: FadeTransition(
                        opacity: _introFade,
                        child: SlideTransition(
                          position: _introSlide,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              _HeaderBar(
                                title: title,
                                subtitle: subtitle,
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 10.h),
                                child: _OutlinedField(
                                  controller: _nameController,
                                  focusNode: _nameFocus,
                                  isDark: isDark,
                                  primary: primary,
                                  focused: _nameFocused,
                                  icon: Icons.groups_rounded,
                                  hint: context.tr(AppStrings.groupNameHint),
                                  textInputAction: TextInputAction.next,
                                  onSubmitted: (_) =>
                                      _searchFocus.requestFocus(),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.fromLTRB(16.w, 2.h, 16.w, 10.h),
                                child: _OutlinedField(
                                  controller: _searchController,
                                  focusNode: _searchFocus,
                                  isDark: isDark,
                                  primary: primary,
                                  focused: _searchFocused,
                                  icon: Icons.search_rounded,
                                  hint:
                                      context.tr(AppStrings.searchMemberToChat),
                                  textInputAction: TextInputAction.search,
                                  hasClear: _searchController.text.isNotEmpty,
                                  onClear: () => _clearSearch(context),
                                  onChanged: context
                                      .read<InboxMemberSearchCubit>()
                                      .onQueryChanged,
                                ),
                              ),
                              AnimatedSize(
                                duration: const Duration(milliseconds: 280),
                                curve: Curves.easeOutCubic,
                                alignment: Alignment.topCenter,
                                child: _selected.isEmpty
                                    ? const SizedBox.shrink()
                                    : _SelectedMembersStrip(
                                        isDark: isDark,
                                        primary: primary,
                                        selected: _selected,
                                        scrollController:
                                            _selectedScrollController,
                                        onRemove: _toggleUser,
                                      ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: _dismissKeyboard,
                                  behavior: HitTestBehavior.opaque,
                                  child: BlocBuilder<InboxMemberSearchCubit,
                                      InboxMemberSearchState>(
                                    builder: (context, state) {
                                      return AnimatedSwitcher(
                                        duration:
                                            const Duration(milliseconds: 280),
                                        switchInCurve: Curves.easeOutCubic,
                                        switchOutCurve: Curves.easeInCubic,
                                        transitionBuilder: (child, animation) {
                                          final fade = CurvedAnimation(
                                            parent: animation,
                                            curve: Curves.easeOut,
                                          );
                                          final slide = Tween<Offset>(
                                            begin: const Offset(0, 0.03),
                                            end: Offset.zero,
                                          ).animate(fade);
                                          return FadeTransition(
                                            opacity: fade,
                                            child: SlideTransition(
                                              position: slide,
                                              child: child,
                                            ),
                                          );
                                        },
                                        child: KeyedSubtree(
                                          key: ValueKey(state.runtimeType),
                                          child: state.when(
                                            initial: () => _EmptyState(
                                              isDark: isDark,
                                              primary: primary,
                                              icon: Icons
                                                  .person_add_alt_1_rounded,
                                              title: context.tr(
                                                AppStrings
                                                    .startGroupChatSubtitle,
                                              ),
                                              message: context.tr(
                                                AppStrings.searchMemberToChat,
                                              ),
                                            ),
                                            hint: () => _EmptyState(
                                              isDark: isDark,
                                              primary: primary,
                                              icon: Icons.keyboard_rounded,
                                              title: context.tr(
                                                AppStrings
                                                    .typeAtLeastTwoCharactersToSearch,
                                              ),
                                              message: context.tr(
                                                AppStrings.searchMemberToChat,
                                              ),
                                            ),
                                            loading: () =>
                                                _LoadingList(isDark: isDark),
                                            empty: () => _EmptyState(
                                              isDark: isDark,
                                              primary: primary,
                                              icon: Icons.person_search_rounded,
                                              title: context.tr(
                                                  AppStrings.noResultsFound),
                                              message: context.tr(
                                                AppStrings.searchMemberToChat,
                                              ),
                                            ),
                                            error: (message) => _EmptyState(
                                              isDark: isDark,
                                              primary: primary,
                                              icon: Icons.error_outline_rounded,
                                              title: message,
                                              message: context.tr(
                                                AppStrings.searchMemberToChat,
                                              ),
                                            ),
                                            loaded: (users) => _ResultsList(
                                              isDark: isDark,
                                              primary: primary,
                                              users: users,
                                              selected: _selected,
                                              onlineUserIds: _onlineUserIds,
                                              onToggle: _toggleUser,
                                              onOpenProfile: _openDoctorProfile,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              _CreateButton(
                                isDark: isDark,
                                primary: primary,
                                enabled: canCreate,
                                creating: _creating,
                                selectedCount: _selected.length,
                                onPressed: _createGroup,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _HeaderBar extends StatelessWidget {
  final Color title;
  final Color subtitle;

  const _HeaderBar({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(6.w, 4.h, 16.w, 8.h),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 18.sp,
              color: title,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.tr(AppStrings.startGroupChat),
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.3,
                    color: title,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  context.tr(AppStrings.startGroupChatSubtitle),
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                    color: subtitle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OutlinedField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isDark;
  final Color primary;
  final bool focused;
  final IconData icon;
  final String hint;
  final TextInputAction textInputAction;
  final bool hasClear;
  final VoidCallback? onClear;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  const _OutlinedField({
    required this.controller,
    required this.focusNode,
    required this.isDark,
    required this.primary,
    required this.focused,
    required this.icon,
    required this.hint,
    required this.textInputAction,
    this.hasClear = false,
    this.onClear,
    this.onChanged,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    final fill = isDark ? const Color(0xFF1C1C1E) : Colors.white;
    final border = focused
        ? primary.withOpacity(0.85)
        : HomeDashboardColors.border(isDark).withOpacity(0.55);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
      height: 46.h,
      decoration: BoxDecoration(
        color: fill,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: border, width: focused ? 1.6 : 1),
        boxShadow: focused
            ? [
                BoxShadow(
                  color: primary.withOpacity(isDark ? 0.28 : 0.16),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(isDark ? 0.25 : 0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.all(6.r),
            decoration: BoxDecoration(
              color: focused
                  ? primary.withOpacity(isDark ? 0.25 : 0.12)
                  : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 18.sp,
              color: focused ? primary : HomeDashboardColors.subtitle(isDark),
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              onChanged: onChanged,
              onSubmitted: onSubmitted,
              onTapOutside: (_) =>
                  FocusManager.instance.primaryFocus?.unfocus(),
              textInputAction: textInputAction,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: HomeDashboardColors.title(isDark),
              ),
              cursorColor: primary,
              decoration: InputDecoration(
                isDense: true,
                filled: false,
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                hintText: hint,
                hintStyle: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: HomeDashboardColors.subtitle(isDark),
                ),
              ),
            ),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 180),
            child: hasClear
                ? IconButton(
                    key: const ValueKey('clear'),
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(
                      minWidth: 32.w,
                      minHeight: 32.h,
                    ),
                    onPressed: onClear,
                    icon: Icon(
                      Icons.cancel_rounded,
                      size: 18.sp,
                      color: HomeDashboardColors.subtitle(isDark),
                    ),
                  )
                : const SizedBox.shrink(key: ValueKey('empty')),
          ),
        ],
      ),
    );
  }
}

class _SelectedMembersStrip extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final List<ChatUserModel> selected;
  final ScrollController scrollController;
  final ValueChanged<ChatUserModel> onRemove;

  const _SelectedMembersStrip({
    required this.isDark,
    required this.primary,
    required this.selected,
    required this.scrollController,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(12.w, 8.h, 12.w, 8.h),
            decoration: BoxDecoration(
              color: isDark
                  ? primary.withOpacity(0.08)
                  : primary.withOpacity(0.05),
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(
                color: primary.withOpacity(isDark ? 0.18 : 0.12),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${selected.length} ${context.tr(AppStrings.selected)}',
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.2,
                    color: HomeDashboardColors.subtitle(isDark),
                  ),
                ),
                SizedBox(height: 6.h),
                SizedBox(
                  height: 32.h,
                  child: ListView.separated(
                    controller: scrollController,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: selected.length,
                    separatorBuilder: (_, __) => SizedBox(width: 6.w),
                    itemBuilder: (context, index) {
                      final user = selected[index];
                      return _SelectedChip(
                        key: ValueKey('selected_${user.id}'),
                        isDark: isDark,
                        primary: primary,
                        user: user,
                        onRemove: () => onRemove(user),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 4.h),
        ],
      ),
    );
  }
}

class _SelectedChip extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final ChatUserModel user;
  final VoidCallback onRemove;

  const _SelectedChip({
    super.key,
    required this.isDark,
    required this.primary,
    required this.user,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final name = ChatMappers.userDisplayName(user);
    final initials = ChatMappers.userInitials(user);
    final imageUrl = user.image?.trim();

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.9, end: 1),
      duration: const Duration(milliseconds: 240),
      curve: Curves.easeOutBack,
      builder: (context, scale, child) => Transform.scale(
        scale: scale,
        child: child,
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(3.w, 2.h, 5.w, 2.h),
        decoration: BoxDecoration(
          color: primary.withOpacity(isDark ? 0.22 : 0.12),
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(color: primary.withOpacity(0.35)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            imageUrl == null || imageUrl.isEmpty
                ? HomeInitialsAvatar(initials: initials, radius: 11)
                : CircleAvatar(
                    radius: 11.r,
                    backgroundColor: primary.withOpacity(0.12),
                    child: ClipOval(
                      child: CustomCachedNetworkImage(
                        imageUrl: imageUrl,
                        height: 22.r,
                        width: 22.r,
                      ),
                    ),
                  ),
            SizedBox(width: 5.w),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 84.w),
              child: Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w700,
                  color: primary,
                ),
              ),
            ),
            SizedBox(width: 2.w),
            GestureDetector(
              onTap: onRemove,
              child: Icon(
                Icons.close_rounded,
                size: 13.sp,
                color: primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final IconData icon;
  final String title;
  final String message;

  const _EmptyState({
    required this.isDark,
    required this.primary,
    required this.icon,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 36.w, vertical: 12.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.92, end: 1),
                      duration: const Duration(milliseconds: 700),
                      curve: Curves.easeOutBack,
                      builder: (context, scale, child) => Transform.scale(
                        scale: scale,
                        child: child,
                      ),
                      child: Container(
                        width: 64.r,
                        height: 64.r,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              primary.withOpacity(isDark ? 0.35 : 0.18),
                              primary.withOpacity(isDark ? 0.12 : 0.06),
                            ],
                          ),
                          border: Border.all(color: primary.withOpacity(0.2)),
                        ),
                        child: Icon(icon, size: 28.sp, color: primary),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w800,
                        color: HomeDashboardColors.title(isDark),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11.sp,
                        height: 1.4,
                        fontWeight: FontWeight.w500,
                        color: HomeDashboardColors.subtitle(isDark),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _LoadingList extends StatelessWidget {
  final bool isDark;

  const _LoadingList({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 24.h),
      itemCount: 6,
      separatorBuilder: (_, __) => SizedBox(height: 10.h),
      itemBuilder: (context, index) {
        return _ShimmerTile(isDark: isDark, delayMs: index * 60);
      },
    );
  }
}

class _ShimmerTile extends StatefulWidget {
  final bool isDark;
  final int delayMs;

  const _ShimmerTile({
    required this.isDark,
    required this.delayMs,
  });

  @override
  State<_ShimmerTile> createState() => _ShimmerTileState();
}

class _ShimmerTileState extends State<_ShimmerTile>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulse;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );
    Future<void>.delayed(Duration(milliseconds: widget.delayMs), () {
      if (mounted) _pulse.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final base =
        widget.isDark ? const Color(0xFF2A2A2E) : const Color(0xFFE8E9EE);
    final highlight =
        widget.isDark ? const Color(0xFF3A3A40) : const Color(0xFFF4F5F8);

    return AnimatedBuilder(
      animation: _pulse,
      builder: (context, _) {
        final t = Curves.easeInOut.transform(_pulse.value);
        final color = Color.lerp(base, highlight, t)!;
        return Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: widget.isDark ? const Color(0xFF1C1C1E) : Colors.white,
            borderRadius: BorderRadius.circular(18.r),
          ),
          child: Row(
            children: [
              Container(
                width: 46.r,
                height: 46.r,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 12.h,
                      width: 140.w,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      height: 10.h,
                      width: 96.w,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                    ),
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

class _ResultsList extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final List<ChatUserModel> users;
  final List<ChatUserModel> selected;
  final Set<int> onlineUserIds;
  final ValueChanged<ChatUserModel> onToggle;
  final ValueChanged<ChatUserModel> onOpenProfile;

  const _ResultsList({
    required this.isDark,
    required this.primary,
    required this.users,
    required this.selected,
    required this.onlineUserIds,
    required this.onToggle,
    required this.onOpenProfile,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 16.h),
      itemCount: users.length,
      separatorBuilder: (_, __) => SizedBox(height: 6.h),
      itemBuilder: (context, index) {
        final user = users[index];
        final userId = user.id;
        final isSelected = selected.any((u) => u.id == userId);
        final isOnline = userId != null && onlineUserIds.contains(userId);
        return _StaggeredResult(
          index: index,
          child: _MemberSelectTile(
            isDark: isDark,
            primary: primary,
            user: user,
            isSelected: isSelected,
            isOnline: isOnline,
            onToggle: () => onToggle(user),
            onOpenProfile: () => onOpenProfile(user),
          ),
        );
      },
    );
  }
}

class _StaggeredResult extends StatefulWidget {
  final int index;
  final Widget child;

  const _StaggeredResult({
    required this.index,
    required this.child,
  });

  @override
  State<_StaggeredResult> createState() => _StaggeredResultState();
}

class _StaggeredResultState extends State<_StaggeredResult>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 380),
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    final delay = (widget.index * 45).clamp(0, 280);
    Future<void>.delayed(Duration(milliseconds: delay), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: widget.child,
      ),
    );
  }
}

class _MemberSelectTile extends StatefulWidget {
  final bool isDark;
  final Color primary;
  final ChatUserModel user;
  final bool isSelected;
  final bool isOnline;
  final VoidCallback onToggle;
  final VoidCallback onOpenProfile;

  const _MemberSelectTile({
    required this.isDark,
    required this.primary,
    required this.user,
    required this.isSelected,
    required this.isOnline,
    required this.onToggle,
    required this.onOpenProfile,
  });

  @override
  State<_MemberSelectTile> createState() => _MemberSelectTileState();
}

class _MemberSelectTileState extends State<_MemberSelectTile> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final user = widget.user;
    final isDark = widget.isDark;
    final primary = widget.primary;
    final isSelected = widget.isSelected;
    final isOnline = widget.isOnline;
    final name = ChatMappers.userDisplayName(user);
    final initials = ChatMappers.userInitials(user);
    final specialty = user.specialty?.trim() ?? '';
    final workplace = user.workingplace?.trim() ?? '';
    final subtitle =
        [specialty, workplace].where((part) => part.isNotEmpty).join(' · ');
    final imageUrl = user.image?.trim();
    final presenceColor = isOnline
        ? HomeDashboardColors.online
        : (isDark ? const Color(0xFF6B7280) : const Color(0xFF9CA3AF));
    final cardBg = isDark ? const Color(0xFF1C1C1E) : Colors.white;

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapCancel: () => setState(() => _pressed = false),
      onTapUp: (_) => setState(() => _pressed = false),
      onTap: widget.onOpenProfile,
      child: AnimatedScale(
        scale: _pressed ? 0.985 : 1,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          padding: EdgeInsets.fromLTRB(10.w, 8.h, 10.w, 8.h),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: isSelected
                  ? primary.withOpacity(0.85)
                  : HomeDashboardColors.border(isDark).withOpacity(0.45),
              width: isSelected ? 1.4 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: isSelected
                    ? primary.withOpacity(isDark ? 0.18 : 0.1)
                    : Colors.black.withOpacity(isDark ? 0.22 : 0.04),
                blurRadius: isSelected ? 10 : 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: primary.withOpacity(0.2),
                        width: 1.2,
                      ),
                    ),
                    child: imageUrl == null || imageUrl.isEmpty
                        ? HomeInitialsAvatar(initials: initials, radius: 16)
                        : CircleAvatar(
                            radius: 16.r,
                            backgroundColor: primary.withOpacity(0.12),
                            child: ClipOval(
                              child: CustomCachedNetworkImage(
                                imageUrl: imageUrl,
                                height: 32.r,
                                width: 32.r,
                              ),
                            ),
                          ),
                  ),
                  Positioned(
                    right: -1,
                    bottom: -1,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      width: 9.r,
                      height: 9.r,
                      decoration: BoxDecoration(
                        color: presenceColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: cardBg, width: 1.2),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w700,
                              color: HomeDashboardColors.title(isDark),
                            ),
                          ),
                        ),
                        if (ChatMappers.userIsVerified(user)) ...[
                          SizedBox(width: 3.w),
                          const VerificationIcon(
                            duration: 0,
                            isSmaller: true,
                          ),
                        ],
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      [
                        if (subtitle.isNotEmpty) subtitle,
                        context.tr(
                          isOnline ? AppStrings.onlineNow : AppStrings.offline,
                        ),
                      ].join(' · '),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                        color: HomeDashboardColors.subtitle(isDark),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              GestureDetector(
                onTap: widget.onToggle,
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: EdgeInsets.all(2.r),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 22.r,
                    height: 22.r,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected ? primary : Colors.transparent,
                      border: Border.all(
                        color: isSelected
                            ? primary
                            : HomeDashboardColors.border(isDark),
                        width: 1.4,
                      ),
                    ),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 180),
                      child: isSelected
                          ? Icon(
                              Icons.check_rounded,
                              key: const ValueKey('on'),
                              size: 13.sp,
                              color: Colors.white,
                            )
                          : const SizedBox.shrink(key: ValueKey('off')),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CreateButton extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final bool enabled;
  final bool creating;
  final int selectedCount;
  final VoidCallback onPressed;

  const _CreateButton({
    required this.isDark,
    required this.primary,
    required this.enabled,
    required this.creating,
    required this.selectedCount,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 6.h, 16.w, 10.h),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 220),
          opacity: enabled || creating ? 1 : 0.55,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: creating ? null : onPressed,
              borderRadius: BorderRadius.circular(14.r),
              child: Ink(
                height: 44.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.r),
                  gradient: LinearGradient(
                    colors: [
                      primary,
                      primary.withOpacity(0.85),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: primary.withOpacity(isDark ? 0.28 : 0.2),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: creating
                      ? SizedBox(
                          width: 18.r,
                          height: 18.r,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.group_add_rounded,
                              size: 16.sp,
                              color: Colors.white,
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              selectedCount > 0
                                  ? '${context.tr(AppStrings.createGroup)} · $selectedCount'
                                  : context.tr(AppStrings.createGroup),
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
