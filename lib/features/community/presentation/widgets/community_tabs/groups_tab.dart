import 'package:egy_akin/app/shared/functions/permissions_helper.dart';
import 'package:egy_akin/features/all_groups_in_community/presentation/cubit/my_groups_cubit/my_groups_in_community_state.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';

import '../../../../../exports.dart';

class GroupsTab extends StatefulWidget {
  final HomeModelResponse homeDataModel;
  final DoctorModel currentDoctorModel;

  const GroupsTab({
    super.key,
    required this.homeDataModel,
    required this.currentDoctorModel,
  });

  @override
  State<GroupsTab> createState() => _GroupsTabState();
}

class _GroupsTabState extends State<GroupsTab>
    with AutomaticKeepAliveClientMixin {
  late final MyGroupsInCommunityCubit _myGroupsCubit;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _myGroupsCubit = sl<MyGroupsInCommunityCubit>();
    // Load once when the tab is first created; keep-alive prevents
    // reloading when switching away to Feeds/Trending.
    final alreadyLoaded = _myGroupsCubit.state.maybeWhen(
      loaded: (_, __, ___, ____) => true,
      orElse: () => false,
    );
    if (!alreadyLoaded && _myGroupsCubit.callMyGroups == 0) {
      _myGroupsCubit.callMyGroups = 1;
      _myGroupsCubit.getMyGroups();
    }
  }

  @override
  void dispose() {
    _myGroupsCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider<MyGroupsInCommunityCubit>.value(
      value: _myGroupsCubit,
      child: _GroupsTabView(
        homeDataModel: widget.homeDataModel,
        currentDoctorModel: widget.currentDoctorModel,
      ),
    );
  }
}

class _GroupsTabView extends StatefulWidget {
  final HomeModelResponse homeDataModel;
  final DoctorModel currentDoctorModel;

  const _GroupsTabView({
    required this.homeDataModel,
    required this.currentDoctorModel,
  });

  @override
  State<_GroupsTabView> createState() => _GroupsTabViewState();
}

class _GroupsTabViewState extends State<_GroupsTabView> {
  static const _accents = <Color>[
    Color(0xFF22C55E),
    Color(0xFFF59E0B),
    Color(0xFF8B5CF6),
    Color(0xFF3B82F6),
    Color(0xFFEF4444),
    Color(0xFF14B8A6),
  ];

  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final groupsCubit = context.read<GroupsCubit>();
      if (groupsCubit.callGroupsTabTimes == 0) {
        groupsCubit.getGroupsTab();
        groupsCubit.callGroupsTabTimes++;
      }
    });
  }

  Future<void> _refresh() async {
    if (_isRefreshing) return;
    setState(() => _isRefreshing = true);
    try {
      await Future.wait([
        context.read<GroupsCubit>().getGroupsTab(showLoading: false),
        context
            .read<MyGroupsInCommunityCubit>()
            .getMyGroups(showLoading: false),
      ]);
    } finally {
      if (mounted) setState(() => _isRefreshing = false);
    }
  }

  void _openAllGroups({int initialTab = 0}) {
    navigatorKey.currentState?.pushNamed(
      AppRoutes.allGroupsInCommunity,
      arguments: AppRoutesArgs.allGroupsInCommunityRouteArgs(
        currentDoctorModel: widget.currentDoctorModel,
        homeDataModel: widget.homeDataModel,
        initialTab: initialTab,
      ),
    );
  }

  void _openGroup(GroupModel group) {
    if (group.id == null) return;
    navigatorKey.currentState?.pushNamed(
      AppRoutes.groupDetailsInCommunity,
      arguments: AppRoutesArgs.groupDetailsInCommunityRouteArgs(
        currentDoctorModel: widget.currentDoctorModel,
        homeDataModel: widget.homeDataModel,
        groupId: group.id.toString(),
      ),
    );
  }

  Color _accentFor(GroupModel group) {
    return _accents[(group.id ?? 0).abs() % _accents.length];
  }

  bool _canJoin(GroupModel group) {
    final status = group.userStatus;
    return status != GroupInviteStatus.invited.name &&
        status != GroupInviteStatus.joined.name &&
        status != GroupInviteStatus.accepted.name &&
        status != GroupInviteStatus.pending.name;
  }

  Future<void> _onJoin(GroupModel group) async {
    if (group.id == null || !_canJoin(group)) return;

    final hasPermission =
        await PermissionHelper.hasPermission(AppPermissions.joinGroup);
    if (!mounted) return;
    if (!hasPermission) {
      showCustomDialog(
        context: context,
        title: context.tr(AppStrings.attention),
        description: context.tr(AppStrings.youDontHavePermissionToJoinGroups),
        coloredButtonText: context.tr(AppStrings.ok),
        coloredButtonOnTap: () => Navigator.of(context).pop(),
        isNoColorShow: false,
      );
      return;
    }

    context.read<GroupsCubit>().joinGroup(group.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final primary = HomeDashboardColors.primary(isDark);

        return ColoredBox(
          color: HomeDashboardColors.scaffold(isDark),
          child: RefreshIndicator(
            color: primary,
            onRefresh: _refresh,
            child: BlocListener<GroupsCubit, GroupsState>(
              listener: (context, state) {
                state.maybeWhen(
                  orElse: () {},
                  loaded: (_, __, dialogMessage, ___, ____) {
                    if (dialogMessage.isNotEmpty) {
                      customSnackBar(
                        context: context,
                        message: dialogMessage,
                      );
                    }
                  },
                  error: (message) {
                    customSnackBar(context: context, message: message);
                  },
                );
              },
              child: ListView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                padding: EdgeInsets.fromLTRB(0, 8.h, 0, 110.h),
                children: [
                  _SectionHeader(
                    title: context.tr(AppStrings.yourGroups),
                    isDark: isDark,
                    primary: primary,
                    onSeeAll: _openAllGroups,
                  ),
                  SizedBox(height: 12.h),
                  if (_isRefreshing)
                    _YourGroupsLoading(isDark: isDark)
                  else
                    BlocBuilder<MyGroupsInCommunityCubit,
                        MyGroupsInCommunityState>(
                      builder: (context, state) {
                        return state.maybeWhen(
                          orElse: () => _YourGroupsLoading(isDark: isDark),
                          error: (_) => _YourGroupsEmpty(isDark: isDark),
                          loaded: (response, _, __, ___) {
                            final groups = response.data?.data ?? [];
                            if (groups.isEmpty) {
                              return _YourGroupsEmpty(isDark: isDark);
                            }
                            return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (var i = 0; i < groups.length; i++) ...[
                                    if (i > 0) SizedBox(width: 12.w),
                                    _YourGroupCard(
                                      key: ValueKey(
                                        'your-group-${groups[i].id}',
                                      ),
                                      group: groups[i],
                                      isDark: isDark,
                                      primary: primary,
                                      onTap: () => _openGroup(groups[i]),
                                    ),
                                  ],
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  SizedBox(height: 22.h),
                  _SectionHeader(
                    title: context.tr(AppStrings.discoverGroups),
                    isDark: isDark,
                    primary: primary,
                    onSeeAll: () => _openAllGroups(initialTab: 2),
                  ),
                  SizedBox(height: 12.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: _isRefreshing
                        ? _DiscoverLoading(isDark: isDark)
                        : BlocBuilder<GroupsCubit, GroupsState>(
                            builder: (context, state) {
                              return state.maybeWhen(
                                orElse: () => _DiscoverLoading(isDark: isDark),
                                error: (_) => _DiscoverEmpty(isDark: isDark),
                                loaded: (response, _, __, ___, ____) {
                                  final groups =
                                      response.data?.latestGroups ?? [];
                                  if (groups.isEmpty) {
                                    return _DiscoverEmpty(isDark: isDark);
                                  }
                                  return Column(
                                    children: [
                                      for (var i = 0;
                                          i < groups.length;
                                          i++) ...[
                                        if (i > 0) SizedBox(height: 10.h),
                                        _DiscoverGroupRow(
                                          key: ValueKey(
                                            'discover-group-${groups[i].id}',
                                          ),
                                          group: groups[i],
                                          isDark: isDark,
                                          primary: primary,
                                          accent: _accentFor(groups[i]),
                                          canJoin: _canJoin(groups[i]),
                                          onTap: () => _openGroup(groups[i]),
                                          onJoin: () => _onJoin(groups[i]),
                                        ),
                                      ],
                                    ],
                                  );
                                },
                              );
                            },
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

class _SectionHeader extends StatelessWidget {
  final String title;
  final bool isDark;
  final Color primary;
  final VoidCallback onSeeAll;

  const _SectionHeader({
    required this.title,
    required this.isDark,
    required this.primary,
    required this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: HomeDashboardColors.title(isDark),
                letterSpacing: -0.1,
              ),
            ),
          ),
          GestureDetector(
            onTap: onSeeAll,
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 2.w),
              child: Text(
                context.tr(AppStrings.seeAllLower),
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GroupAvatar extends StatelessWidget {
  final GroupModel group;
  final Color accent;
  final double size;
  final double radius;

  const _GroupAvatar({
    required this.group,
    required this.accent,
    required this.size,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = group.groupImage;
    final hasImage = imageUrl != null && imageUrl.trim().isNotEmpty;
    final cacheSize =
        (size * MediaQuery.devicePixelRatioOf(context)).round().clamp(48, 256);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: accent.withOpacity(0.14),
        borderRadius: BorderRadius.circular(radius),
      ),
      clipBehavior: Clip.antiAlias,
      child: hasImage
          ? CachedNetworkImage(
              imageUrl: imageUrl,
              width: size,
              height: size,
              fit: BoxFit.cover,
              fadeInDuration: Duration.zero,
              fadeOutDuration: Duration.zero,
              memCacheWidth: cacheSize,
              memCacheHeight: cacheSize,
              placeholder: (_, __) => ColoredBox(
                color: accent.withOpacity(0.14),
              ),
              errorWidget: (_, __, ___) => Icon(
                Icons.groups_rounded,
                size: size * 0.42,
                color: accent,
              ),
            )
          : Icon(
              Icons.groups_rounded,
              size: size * 0.42,
              color: accent,
            ),
    );
  }
}

class _YourGroupCard extends StatelessWidget {
  final GroupModel group;
  final bool isDark;
  final Color primary;
  final VoidCallback onTap;

  const _YourGroupCard({
    super.key,
    required this.group,
    required this.isDark,
    required this.primary,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cardBg = isDark ? const Color(0xFF1C1C1E) : Colors.white;
    final muted = HomeDashboardColors.subtitle(isDark);
    final titleStyle = TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w700,
      color: HomeDashboardColors.title(isDark),
      height: 1.2,
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18.r),
        child: Ink(
          width: 138.w,
          padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(
              color: isDark
                  ? Colors.white.withOpacity(0.06)
                  : const Color(0xFFE8E8EE),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _GroupAvatar(
                group: group,
                accent: primary,
                size: 40.r,
                radius: 12.r,
              ),
              SizedBox(height: 8.h),
              Text(
                group.name ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: titleStyle,
              ),
              SizedBox(height: 6.h),
              Row(
                children: [
                  Icon(
                    Icons.people_alt_outlined,
                    size: 11.sp,
                    color: muted,
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Text(
                      '${group.memberCount ?? 0} members',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                        color: muted,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DiscoverGroupRow extends StatelessWidget {
  final GroupModel group;
  final bool isDark;
  final Color primary;
  final Color accent;
  final bool canJoin;
  final VoidCallback onTap;
  final VoidCallback onJoin;

  const _DiscoverGroupRow({
    super.key,
    required this.group,
    required this.isDark,
    required this.primary,
    required this.accent,
    required this.canJoin,
    required this.onTap,
    required this.onJoin,
  });

  @override
  Widget build(BuildContext context) {
    final cardBg = isDark ? const Color(0xFF1C1C1E) : Colors.white;
    final muted = HomeDashboardColors.subtitle(isDark);
    final statusLabel =
        translateGroupStatus(group.userStatus.toString(), context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18.r),
        child: Ink(
          padding: EdgeInsets.fromLTRB(12.w, 12.h, 10.w, 12.h),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(
              color: isDark
                  ? Colors.white.withOpacity(0.06)
                  : const Color(0xFFE8E8EE),
            ),
          ),
          child: Row(
            children: [
              _GroupAvatar(
                group: group,
                accent: accent,
                size: 46.r,
                radius: 14.r,
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      group.name ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12.5.sp,
                        fontWeight: FontWeight.w700,
                        color: HomeDashboardColors.title(isDark),
                        height: 1.15,
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Row(
                      children: [
                        Icon(
                          Icons.people_alt_outlined,
                          size: 11.sp,
                          color: muted,
                        ),
                        SizedBox(width: 3.w),
                        Flexible(
                          child: Text(
                            [
                              '${group.memberCount ?? 0}',
                              if ((group.description ?? '').trim().isNotEmpty)
                                group.description!.trim(),
                            ].join(' · '),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500,
                              color: muted,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: canJoin ? onJoin : null,
                  borderRadius: BorderRadius.circular(20.r),
                  child: Ink(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
                    decoration: BoxDecoration(
                      color: canJoin
                          ? primary
                          : (isDark
                              ? Colors.white.withOpacity(0.08)
                              : const Color(0xFFF3F4F6)),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          canJoin
                              ? Icons.person_add_alt_1_rounded
                              : Icons.check_rounded,
                          size: 12.sp,
                          color: canJoin
                              ? Colors.white
                              : HomeDashboardColors.subtitle(isDark),
                        ),
                        SizedBox(width: 3.w),
                        Text(
                          statusLabel,
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                            color: canJoin
                                ? Colors.white
                                : HomeDashboardColors.subtitle(isDark),
                          ),
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
  }
}

class _YourGroupsLoading extends StatelessWidget {
  final bool isDark;

  const _YourGroupsLoading({required this.isDark});

  @override
  Widget build(BuildContext context) {
    final cardBg = isDark ? const Color(0xFF1C1C1E) : Colors.white;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var i = 0; i < 3; i++) ...[
            if (i > 0) SizedBox(width: 12.w),
            Container(
              width: 138.w,
              padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(18.r),
                border: Border.all(
                  color: isDark
                      ? Colors.white.withOpacity(0.06)
                      : const Color(0xFFE8E8EE),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _ShimmerBox(
                    isDark: isDark,
                    width: 40.r,
                    height: 40.r,
                    radius: 12.r,
                  ),
                  SizedBox(height: 8.h),
                  _ShimmerBox(
                    isDark: isDark,
                    width: 90.w,
                    height: 12.h,
                    radius: 6.r,
                  ),
                  SizedBox(height: 6.h),
                  _ShimmerBox(
                    isDark: isDark,
                    width: 70.w,
                    height: 10.h,
                    radius: 5.r,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _DiscoverLoading extends StatelessWidget {
  final bool isDark;

  const _DiscoverLoading({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < 4; i++) ...[
          if (i > 0) SizedBox(height: 10.h),
          _ShimmerBox(
            isDark: isDark,
            width: double.infinity,
            height: 70.h,
            radius: 18.r,
          ),
        ],
      ],
    );
  }
}

class _YourGroupsEmpty extends StatelessWidget {
  final bool isDark;

  const _YourGroupsEmpty({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1C1C1E) : Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isDark
                ? Colors.white.withOpacity(0.06)
                : const Color(0xFFE8E8EE),
          ),
        ),
        child: Text(
          context.tr(AppStrings.joinGroupToSeeHere),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: HomeDashboardColors.subtitle(isDark),
          ),
        ),
      ),
    );
  }
}

class _DiscoverEmpty extends StatelessWidget {
  final bool isDark;

  const _DiscoverEmpty({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 18.h),
      child: Text(
        context.tr(AppStrings.noGroupsToDiscoverYet),
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: HomeDashboardColors.subtitle(isDark),
        ),
      ),
    );
  }
}

class _ShimmerBox extends StatelessWidget {
  final bool isDark;
  final double width;
  final double height;
  final double radius;

  const _ShimmerBox({
    required this.isDark,
    required this.width,
    required this.height,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: isDark ? AppColors.darkSurface : Colors.grey[300]!,
      highlightColor: isDark ? AppColors.darkBorder : Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCardBG : Colors.white,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
