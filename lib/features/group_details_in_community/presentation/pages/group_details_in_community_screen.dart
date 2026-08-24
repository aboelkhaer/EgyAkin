import 'dart:ui';

import 'package:egy_akin/app/shared/functions/date_formate_for_group.dart';
import 'package:egy_akin/app/shared/functions/permissions_helper.dart';
import 'package:egy_akin/app/shared/widgets/admin_only_badge.dart';
import 'package:egy_akin/exports.dart';
import 'package:egy_akin/features/group_details_in_community/presentation/cubit/group_details_in_community_state.dart';
import 'package:egy_akin/features/group_members/presentation/pages/group_members_screen.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';
import 'package:readmore/readmore.dart';

class GroupDetailsInCommunityScreen extends StatefulWidget {
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;
  final String groupId;

  const GroupDetailsInCommunityScreen({
    super.key,
    required this.currentDoctorModel,
    required this.homeDataModel,
    required this.groupId,
  });

  @override
  State<GroupDetailsInCommunityScreen> createState() =>
      _GroupDetailsInCommunityScreenState();
}

class _GroupDetailsInCommunityScreenState
    extends State<GroupDetailsInCommunityScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _newPostKey = GlobalKey();
  late final GroupDetailsInCommunityCubit _cubit;
  int _tab = 0;
  bool _showNewPostFab = false;

  @override
  void initState() {
    super.initState();
    context
        .read<GroupDetailsInCommunityCubit>()
        .getGroupDetails(widget.groupId);
    _cubit = context.read<GroupDetailsInCommunityCubit>();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    await context
        .read<GroupDetailsInCommunityCubit>()
        .getGroupDetails(widget.groupId);
    _syncNewPostFabAfterLayout();
  }

  void _onScroll() {
    _tryLoadMore();
    _updateNewPostFab();
  }

  void _updateNewPostFab() {
    if (!mounted) return;
    final ctx = _newPostKey.currentContext;
    if (ctx == null) {
      if (_showNewPostFab) setState(() => _showNewPostFab = false);
      return;
    }
    final box = ctx.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) {
      if (_showNewPostFab) setState(() => _showNewPostFab = false);
      return;
    }

    final top = box.localToGlobal(Offset.zero).dy;
    final bottom = top + box.size.height;
    // Show FAB only when the header New post button is fully off-screen.
    final shouldShow = bottom < MediaQuery.paddingOf(context).top;
    if (shouldShow != _showNewPostFab) {
      setState(() => _showNewPostFab = shouldShow);
    }
  }

  void _syncNewPostFabAfterLayout() {
    if (_showNewPostFab) {
      setState(() => _showNewPostFab = false);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _updateNewPostFab();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _updateNewPostFab();
      });
    });
  }

  void _tryLoadMore() {
    if (_tab != 0) return;
    if (_cubit.isClosed || _cubit.isLastPage || _cubit.isLoadingMoreForScroll) {
      return;
    }
    if (!_scrollController.hasClients) return;
    final hasPosts = _cubit.state.maybeWhen(
      loaded: (groupDetails, _, __, ___, ____, _____, ______, _______) =>
          (groupDetails.data?.posts?.data?.isNotEmpty ?? false),
      orElse: () => false,
    );
    if (!hasPosts) return;
    if (_scrollController.position.extentAfter > 280) return;
    _cubit.isLoadingMoreForScroll = true;
    _cubit.loadMoreFeeds(widget.groupId);
  }

  bool _isMember(GroupModel g) =>
      g.userStatus == GroupInviteStatus.accepted.name ||
      g.userStatus == GroupInviteStatus.joined.name;

  bool _canPost(GroupModel g) =>
      _isMember(g) ||
      (g.userStatus == GroupInviteStatus.invited.name &&
          g.privacy == GroupStatus.public.name);

  bool _isOwner(GroupModel g) =>
      widget.currentDoctorModel.id.toString() == g.owner?.id.toString();

  void _openImage(String url) {
    Navigator.push(
      context,
      FullScreenImage.route(imageUrl: url, isLocal: false),
    );
  }

  void _openMembers(GroupModel group) {
    showCustomBottomSheet(
      context: context,
      heightFactor: 0.78,
      builder: (context) {
        return BlocProvider(
          create: (context) => GroupMembersCubit(sl(), sl(), sl(), sl()),
          child: GroupMembersScreen(
            groupId: widget.groupId,
            currentDoctorModel: widget.currentDoctorModel,
            homeDataModel: widget.homeDataModel,
            postId: '',
            ownerId: group.owner?.id.toString() ?? '',
          ),
        );
      },
    );
  }

  void _openEdit(GroupModel group) {
    navigatorKey.currentState?.pushNamed(
      AppRoutes.createGroupInCommunity,
      arguments: AppRoutesArgs.createGroupInCommunityRouteArgs(
        currentDoctorModel: widget.currentDoctorModel,
        homeDataModel: widget.homeDataModel,
        isCreateNewGroup: false,
        groupModel: group,
      ),
    );
  }

  Future<void> _openCreatePost() async {
    final groupName = _cubit.state.maybeWhen(
      loaded: (groupDetails, _, __, ___, ____, _____, ______, _______) =>
          groupDetails.data?.group?.name?.trim(),
      orElse: () => null,
    );

    await navigatorKey.currentState?.pushNamed(
      AppRoutes.createPostInCommunity,
      arguments: AppRoutesArgs.createPostInCommunityRouteArgs(
        currentDoctorModel: widget.currentDoctorModel,
        homeDataModel: widget.homeDataModel,
        groupId: widget.groupId,
        groupName:
            (groupName != null && groupName.isNotEmpty) ? groupName : null,
        onPostUploaded: () async {
          await _cubit.getGroupDetails(widget.groupId);
          _syncNewPostFabAfterLayout();
        },
      ),
    );
    if (!mounted) return;
    _syncNewPostFabAfterLayout();
  }

  void _openInvite(GroupModel group) {
    navigatorKey.currentState?.pushNamed(
      AppRoutes.sendConsultation,
      arguments: AppRoutesArgs.sendConsultationRouteArgs(
        homeDataModel: widget.homeDataModel,
        currentDoctorModel: widget.currentDoctorModel,
        patientId: '',
        isSendConsultation: false,
        groupId: group.id.toString(),
        isForAddNewDoctors: false,
        consultationId: '',
        ownerOfConsultationId: '',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = GroupDetailsInCommunityCubit.get(context);

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final primary = HomeDashboardColors.primary(isDark);
        final scaffold = HomeDashboardColors.scaffold(isDark);

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,
          ),
          child: Scaffold(
            backgroundColor: scaffold,
            floatingActionButton: BlocBuilder<GroupDetailsInCommunityCubit,
                GroupDetailsInCommunityState>(
              buildWhen: (prev, next) => prev != next,
              builder: (context, state) {
                final canPost = state.maybeWhen(
                  loaded:
                      (groupDetails, _, __, ___, ____, _____, ______, _______) {
                    final group = groupDetails.data?.group;
                    return group != null && _canPost(group);
                  },
                  orElse: () => false,
                );
                if (!canPost) return const SizedBox.shrink();

                return AnimatedSlide(
                  duration: const Duration(milliseconds: 280),
                  curve: Curves.easeOutCubic,
                  offset: _showNewPostFab ? Offset.zero : const Offset(0, 1.4),
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 220),
                    curve: Curves.easeOut,
                    opacity: _showNewPostFab ? 1 : 0,
                    child: IgnorePointer(
                      ignoring: !_showNewPostFab,
                      child: FloatingActionButton.extended(
                        onPressed: _openCreatePost,
                        backgroundColor: primary,
                        foregroundColor: Colors.white,
                        elevation: 4,
                        icon: Icon(Icons.edit_rounded, size: 18.sp),
                        label: Text(
                          context.tr(AppStrings.newPost),
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            body: BlocConsumer<GroupDetailsInCommunityCubit,
                GroupDetailsInCommunityState>(
              listener: (context, state) {
                state.maybeWhen(
                  orElse: () {},
                  error: (message) =>
                      customSnackBar(context: context, message: message),
                  loaded: (
                    _,
                    snackBarMessage,
                    __,
                    ___,
                    isDeleteGroupLoaded,
                    ____,
                    _____,
                    ______,
                  ) {
                    if (snackBarMessage != '') {
                      customSnackBar(
                          context: context, message: snackBarMessage);
                    }
                    if (isDeleteGroupLoaded) {
                      navigatorKey.currentState
                          ?.pushReplacementNamed(AppRoutes.home, arguments: 0);
                      Future.delayed(Duration.zero, () {
                        navigatorKey.currentState?.pushNamed(
                          AppRoutes.community,
                          arguments: AppRoutesArgs.communityRouteArgs(
                            homeDataModel: widget.homeDataModel,
                            currentDoctorModel: widget.currentDoctorModel,
                            initialTab: 2,
                          ),
                        );
                      });
                    }
                  },
                );
              },
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () => _Loading(isDark: isDark),
                  loaded: (
                    groupDetails,
                    _,
                    __,
                    isDeleteGroupLoading,
                    ___,
                    ____,
                    isSeeMore,
                    isAcceptOrDecline,
                  ) {
                    final group = groupDetails.data?.group;
                    if (group == null) {
                      return _Loading(isDark: isDark);
                    }
                    final posts = groupDetails.data?.posts?.data ?? [];
                    final canSeePosts = group.userStatus != null &&
                        group.userStatus != GroupInviteStatus.pending.name &&
                        group.userStatus != GroupInviteStatus.declined.name;
                    final showPosts = canSeePosts && posts.isNotEmpty;

                    return NotificationListener<ScrollNotification>(
                      onNotification: (notification) {
                        if (notification.metrics.axis == Axis.vertical) {
                          _updateNewPostFab();
                          if (notification.metrics.extentAfter <= 280) {
                            _tryLoadMore();
                          }
                        }
                        return false;
                      },
                      child: RefreshIndicator(
                        color: primary,
                        onRefresh: _onRefresh,
                        child: CustomScrollView(
                          controller: _scrollController,
                          physics: const AlwaysScrollableScrollPhysics(
                            parent: BouncingScrollPhysics(),
                          ),
                          slivers: [
                            SliverToBoxAdapter(
                              child: _ProfileHeader(
                                isDark: isDark,
                                primary: primary,
                                group: group,
                                postsCount: posts.length,
                                canOpenMedia: _isMember(group),
                                canEdit: _isOwner(group) ||
                                    PermissionHelper.canPermission(
                                      AppPermissions.updateGroupForAdmin,
                                    ),
                                showAdminEditBadge:
                                    PermissionHelper.canPermission(
                                          AppPermissions.updateGroupForAdmin,
                                        ) &&
                                        !_isOwner(group),
                                isDeleteGroupLoading: isDeleteGroupLoading,
                                canLeave: _canPost(group),
                                canDelete: _isOwner(group) ||
                                    PermissionHelper.canPermission(
                                      AppPermissions.deleteGroupForAdmin,
                                    ),
                                showAdminDeleteBadge:
                                    PermissionHelper.canPermission(
                                          AppPermissions.deleteGroupForAdmin,
                                        ) &&
                                        !_isOwner(group),
                                canOpenMembers: _canPost(group) ||
                                    PermissionHelper.canPermission(
                                      AppPermissions.viewGroupMembersForAdmin,
                                    ) ||
                                    PermissionHelper.canPermission(
                                      AppPermissions
                                          .hasPendingInvitationsForAdmin,
                                    ),
                                showPendingDot: (_isOwner(group) ||
                                        PermissionHelper.canPermission(
                                          AppPermissions
                                              .hasPendingInvitationsForAdmin,
                                        )) &&
                                    (group.isHasPendingInvitations ?? false),
                                canPost: _canPost(group),
                                newPostKey: _newPostKey,
                                isOwner: _isOwner(group),
                                isInvitationLoading: isAcceptOrDecline,
                                tab: _tab,
                                onTab: (v) => setState(() => _tab = v),
                                onBack: () => Navigator.pop(context),
                                onOpenCover: () =>
                                    _openImage(group.headerPicture.toString()),
                                onOpenAvatar: () =>
                                    _openImage(group.groupImage.toString()),
                                onEdit: () => _openEdit(group),
                                onLeave: () {
                                  if (_isOwner(group)) {
                                    customSnackBar(
                                      context: context,
                                      message: context.tr(
                                        AppStrings.sorryCanTDoThatYouAreAdmin,
                                      ),
                                    );
                                    return;
                                  }
                                  cubit.leaveGroup(group.id.toString());
                                },
                                onDelete: () =>
                                    cubit.deleteGroup(group.id.toString()),
                                onMembers: () => _openMembers(group),
                                onInvite: () => _openInvite(group),
                                onCreatePost: _openCreatePost,
                                onJoin: () =>
                                    cubit.joinGroup(group.id.toString()),
                                onAccept: () {
                                  cubit.acceptOrDeclineGroupInvitation(
                                    groupId: group.id.toString(),
                                    invitationId: group.invitationId!,
                                    status: AcceptOrDeclineMemberInGroup
                                        .accepted.name,
                                    doctorId:
                                        widget.currentDoctorModel.id.toString(),
                                  );
                                },
                                onDecline: () {
                                  cubit.acceptOrDeclineGroupInvitation(
                                    groupId: group.id.toString(),
                                    invitationId: group.invitationId!,
                                    status: AcceptOrDeclineMemberInGroup
                                        .declined.name,
                                    doctorId:
                                        widget.currentDoctorModel.id.toString(),
                                  );
                                },
                              ),
                            ),
                            if (_tab == 1)
                              SliverToBoxAdapter(
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      16.w, 12.h, 16.w, 32.h),
                                  child: _AboutBody(
                                    isDark: isDark,
                                    primary: primary,
                                    group: group,
                                    createdLabel: formatDateForGroup(
                                      group.createdAt.toString(),
                                      context,
                                    ),
                                  ),
                                ),
                              )
                            else if (!showPosts)
                              SliverToBoxAdapter(
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      16.w, 20.h, 16.w, 40.h),
                                  child: DashboardEmptyState(
                                    isDark: isDark,
                                    icon: Icons.auto_stories_outlined,
                                    title: _canPost(group)
                                        ? context.tr(AppStrings.noPostsYet)
                                        : context.tr(AppStrings.postsAreLocked),
                                    subtitle: _canPost(group)
                                        ? context.tr(AppStrings
                                            .shareFirstClinicalUpdateWithGroup)
                                        : context.tr(AppStrings
                                            .joinGroupToReadMemberPosts),
                                    hint: _canPost(group)
                                        ? context.tr(AppStrings.tapNewPostAbove)
                                        : context.tr(
                                            AppStrings.requestAccessToContinue),
                                    hintIcon: _canPost(group)
                                        ? Icons.edit_outlined
                                        : Icons.lock_outline_rounded,
                                  ),
                                ),
                              )
                            else
                              SliverPadding(
                                padding:
                                    EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 28.h),
                                sliver: SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                    (context, index) {
                                      final post = posts[index];
                                      _primePoll(cubit, post);
                                      return Padding(
                                        padding: EdgeInsets.only(bottom: 12.h),
                                        child: _postCard(cubit, post),
                                      );
                                    },
                                    childCount: posts.length,
                                  ),
                                ),
                              ),
                            if (_tab == 0 && showPosts && isSeeMore)
                              SliverToBoxAdapter(
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 20.h),
                                  child: Center(
                                    child: SizedBox(
                                      width: 18,
                                      height: 18,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.4,
                                        color: primary,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            SliverToBoxAdapter(child: SizedBox(height: 16.h)),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _postCard(
      GroupDetailsInCommunityCubit cubit, PostCommunityModel post) {
    return PostCard(
      feed: post,
      homeDataModel: widget.homeDataModel,
      currentDoctorModel: widget.currentDoctorModel,
      isGroupPosts: true,
      showPostFrom: ShowPostFromEnum.groupDetails.name,
      viewPollWidget: ViewPollWidget(
        poll: post.poll,
        currentDoctorModel: widget.currentDoctorModel,
        homeDataModel: widget.homeDataModel,
        selectedOptions: cubit.postSelectedOptions[post.id] ?? {},
        onAddOption: (pollId, option) async {
          await _cubit.addOptionOnPoll(pollId, option);
        },
        selectedOption: cubit.postSelectedOption[post.id],
        onOptionSelected: (optionId) {
          cubit.postSelectedOption[post.id!] = optionId;
          cubit.addVoteAndUnVote(post.poll!.id.toString(), optionId!);
          cubit.refreshScreen();
        },
        onOptionToggled: (optionId, isSelected) {
          cubit.postSelectedOptions[post.id!] ??= {};
          cubit.addVoteAndUnVote(post.poll!.id.toString(), optionId);
          if (isSelected) {
            cubit.postSelectedOptions[post.id!]!.add(optionId);
          } else {
            cubit.postSelectedOptions[post.id!]!.remove(optionId);
          }
          cubit.refreshScreen();
        },
      ),
      onLikeAndUnlikeAdditional: () {
        cubit.addLikeOrUnlikeOnPost(
          post.id.toString(),
          likeOrUnlike: post.isLiked! ? 'unlike' : 'like',
        );
      },
      onSaveAndUnSaveAdditional: () {
        cubit.addSaveOrUnsaveOnPost(
          post.id.toString(),
          saveOrUnsave: post.isSaved! ? 'unsave' : 'save',
        );
      },
      onDeleteAdditional: () => cubit.deletePost(post.id.toString()),
    );
  }

  void _primePoll(GroupDetailsInCommunityCubit cubit, PostCommunityModel post) {
    final poll = post.poll;
    if (poll == null || post.id == null) return;
    if (poll.allowMultipleChoice == true &&
        !cubit.postSelectedOptions.containsKey(post.id)) {
      cubit.postSelectedOptions[post.id!] = {
        ...poll.options
                ?.where((o) => o.isVoted ?? false)
                .map((o) => o.id!)
                .toSet() ??
            {},
      };
    }
    if (poll.allowMultipleChoice == false &&
        !cubit.postSelectedOption.containsKey(post.id)) {
      cubit.postSelectedOption[post.id!] = poll.options
          ?.firstWhere(
            (o) => o.isVoted ?? false,
            orElse: () => const PollOptionsModelResponse(id: -1),
          )
          .id;
    }
  }
}

class _ProfileHeader extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final GroupModel group;
  final int postsCount;
  final bool canOpenMedia;
  final bool canEdit;
  final bool showAdminEditBadge;
  final bool isDeleteGroupLoading;
  final bool canLeave;
  final bool canDelete;
  final bool showAdminDeleteBadge;
  final bool canOpenMembers;
  final bool showPendingDot;
  final bool canPost;
  final GlobalKey? newPostKey;
  final bool isOwner;
  final bool isInvitationLoading;
  final int tab;
  final ValueChanged<int> onTab;
  final VoidCallback onBack;
  final VoidCallback onOpenCover;
  final VoidCallback onOpenAvatar;
  final VoidCallback onEdit;
  final VoidCallback onLeave;
  final VoidCallback onDelete;
  final VoidCallback onMembers;
  final VoidCallback onInvite;
  final VoidCallback onCreatePost;
  final VoidCallback onJoin;
  final VoidCallback onAccept;
  final VoidCallback onDecline;

  const _ProfileHeader({
    required this.isDark,
    required this.primary,
    required this.group,
    required this.postsCount,
    required this.canOpenMedia,
    required this.canEdit,
    required this.showAdminEditBadge,
    required this.isDeleteGroupLoading,
    required this.canLeave,
    required this.canDelete,
    required this.showAdminDeleteBadge,
    required this.canOpenMembers,
    required this.showPendingDot,
    required this.canPost,
    this.newPostKey,
    required this.isOwner,
    required this.isInvitationLoading,
    required this.tab,
    required this.onTab,
    required this.onBack,
    required this.onOpenCover,
    required this.onOpenAvatar,
    required this.onEdit,
    required this.onLeave,
    required this.onDelete,
    required this.onMembers,
    required this.onInvite,
    required this.onCreatePost,
    required this.onJoin,
    required this.onAccept,
    required this.onDecline,
  });

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.paddingOf(context).top;
    final private = group.privacy == GroupStatus.private.name;
    final scaffold = HomeDashboardColors.scaffold(isDark);
    final imageUrl = group.groupImage?.toString() ?? '';
    final initial = (group.name != null && group.name!.trim().isNotEmpty)
        ? group.name!.trim()[0].toUpperCase()
        : 'G';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ── Hero band (same language as doctor profile) ──
        SizedBox(
          width: double.infinity,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Rounded cover / gradient only (avatar & chrome stay unclipped)
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(28.r),
                    bottomRight: Radius.circular(28.r),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: isDark
                                ? const [
                                    Color(0xFF0B1220),
                                    Color(0xFF1A1035),
                                    Color(0xFF0F172A),
                                  ]
                                : const [
                                    Color(0xFFDDD6FE),
                                    Color(0xFFC4B5FD),
                                    Color(0xFFA78BFA),
                                  ],
                          ),
                        ),
                      ),
                      if ((group.headerPicture ?? '')
                          .toString()
                          .trim()
                          .isNotEmpty)
                        Opacity(
                          opacity: isDark ? 0.22 : 0.18,
                          child: GestureDetector(
                            onTap: canOpenMedia ? onOpenCover : null,
                            child: CustomCachedNetworkImage(
                              imageUrl: group.headerPicture.toString(),
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      // Keep chrome + title readable over busy cover art
                      IgnorePointer(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: const [0.0, 0.35, 0.62, 1.0],
                              colors: isDark
                                  ? [
                                      Colors.black.withOpacity(0.45),
                                      Colors.black.withOpacity(0.12),
                                      Colors.black.withOpacity(0.55),
                                      Colors.black.withOpacity(0.72),
                                    ]
                                  : [
                                      const Color(0xFFDDD6FE).withOpacity(0.55),
                                      const Color(0xFFC4B5FD).withOpacity(0.2),
                                      Colors.white.withOpacity(0.72),
                                      Colors.white.withOpacity(0.92),
                                    ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(8.w, top + 2.h, 12.w, 36.h),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
              Positioned.directional(
                textDirection: Directionality.of(context),
                end: -16.w,
                top: 8.h,
                child: IgnorePointer(
                  child: Transform.rotate(
                    angle: Directionality.of(context) == TextDirection.rtl
                        ? 0.18
                        : -0.18,
                    child: Icon(
                      Icons.groups_rounded,
                      size: 120.sp,
                      color: (isDark ? Colors.white : const Color(0xFF5B21B6))
                          .withOpacity(0.06),
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _GlassIconButton(
                        isDark: isDark,
                        icon: Icons.arrow_back_ios_new_rounded,
                        onTap: onBack,
                      ),
                      const Spacer(),
                      if (canEdit)
                        AdminOnlyBadge(
                          showBadge: showAdminEditBadge,
                          style: BadgeStyle.premium,
                          fontSize: 6.sp,
                          badgePadding: EdgeInsets.symmetric(
                            horizontal: 3.w,
                            vertical: 0.5.h,
                          ),
                          showIcon: false,
                          glowEffect: true,
                          pulseAnimation: true,
                          badgeText: 'A',
                          top: -6,
                          right: -6,
                          child: _GlassIconButton(
                            isDark: isDark,
                            icon: Icons.edit_rounded,
                            onTap: onEdit,
                          ),
                        ),
                      if (!isDeleteGroupLoading && (canLeave || canDelete)) ...[
                        SizedBox(width: 8.w),
                        PopupMenuButton<String>(
                          color: HomeDashboardColors.cardBg(isDark),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                          onSelected: (v) {
                            if (v == 'leave') onLeave();
                            if (v == 'delete') onDelete();
                          },
                          itemBuilder: (context) => [
                            if (canLeave)
                              PopupMenuItem(
                                value: 'leave',
                                child: Text(context.tr(AppStrings.leaveGroup)),
                              ),
                            if (canDelete)
                              PopupMenuItem(
                                value: 'delete',
                                child: AdminOnlyBadge(
                                  showBadge: showAdminDeleteBadge,
                                  style: BadgeStyle.premium,
                                  fontSize: 6.sp,
                                  badgePadding: EdgeInsets.symmetric(
                                    horizontal: 3.w,
                                    vertical: 0.5.h,
                                  ),
                                  showIcon: false,
                                  glowEffect: true,
                                  pulseAnimation: true,
                                  badgeText: 'A',
                                  top: -5,
                                  right: -5,
                                  child:
                                      Text(context.tr(AppStrings.deleteGroup)),
                                ),
                              ),
                          ],
                          child: IgnorePointer(
                            child: _GlassIconButton(
                              isDark: isDark,
                              icon: Icons.more_horiz_rounded,
                              onTap: null,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 14.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: canOpenMedia && imageUrl.isNotEmpty
                            ? onOpenAvatar
                            : null,
                        child: Container(
                          width: 72.r,
                          height: 72.r,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isDark
                                  ? Colors.white.withOpacity(0.9)
                                  : Colors.white,
                              width: 3,
                            ),
                            boxShadow: isDark
                                ? null
                                : [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.12),
                                      blurRadius: 12,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                          ),
                          child: ClipOval(
                            child: imageUrl.trim().isEmpty
                                ? ColoredBox(
                                    color: isDark
                                        ? Colors.white.withOpacity(0.12)
                                        : Colors.white.withOpacity(0.55),
                                    child: Center(
                                      child: Text(
                                        initial,
                                        style: TextStyle(
                                          color: isDark
                                              ? Colors.white
                                              : const Color(0xFF5B21B6),
                                          fontSize: 26.sp,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ),
                                  )
                                : CustomCachedNetworkImage(
                                    imageUrl: imageUrl,
                                    width: 72.r,
                                    height: 72.r,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(width: 14.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 4.h),
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                color: (private
                                        ? const Color(0xFFF59E0B)
                                        : (isDark
                                            ? const Color(0xFF2DD4BF)
                                            : const Color(0xFF0D9488)))
                                    .withOpacity(isDark ? 0.18 : 0.14),
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(
                                  color: (private
                                          ? const Color(0xFFF59E0B)
                                          : (isDark
                                              ? const Color(0xFF2DD4BF)
                                              : const Color(0xFF0D9488)))
                                      .withOpacity(0.45),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    private
                                        ? Icons.lock_rounded
                                        : Icons.public_rounded,
                                    size: 13.sp,
                                    color: private
                                        ? (isDark
                                            ? const Color(0xFFFCD34D)
                                            : const Color(0xFFB45309))
                                        : (isDark
                                            ? const Color(0xFF5EEAD4)
                                            : const Color(0xFF0F766E)),
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(
                                    private
                                        ? context.tr(AppStrings.privateGroup)
                                        : context.tr(AppStrings.publicGroup),
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w700,
                                      color: private
                                          ? (isDark
                                              ? const Color(0xFFFDE68A)
                                              : const Color(0xFF92400E))
                                          : (isDark
                                              ? const Color(0xFF99F6E4)
                                              : const Color(0xFF115E59)),
                                      letterSpacing: 0.2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              group.name ?? '',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 18.sp,
                                height: 1.15,
                                fontWeight: FontWeight.w800,
                                color: isDark
                                    ? Colors.white
                                    : const Color(0xFF1F2937),
                                letterSpacing: -0.4,
                                shadows: isDark
                                    ? [
                                        Shadow(
                                          color: Colors.black.withOpacity(0.45),
                                          blurRadius: 10,
                                        ),
                                      ]
                                    : [
                                        Shadow(
                                          color: Colors.white.withOpacity(0.9),
                                          blurRadius: 12,
                                        ),
                                      ],
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              context.tr(AppStrings.clinicalCommunity),
                              style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.2,
                                color: isDark
                                    ? const Color(0xFFA5B4FC)
                                    : const Color(0xFF5B21B6),
                                shadows: isDark
                                    ? null
                                    : [
                                        Shadow(
                                          color: Colors.white.withOpacity(0.85),
                                          blurRadius: 10,
                                        ),
                                      ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // ── Overlapping frosted stats card ──
        Transform.translate(
          offset: Offset(0, -18.h),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                child: Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: (isDark ? const Color(0xFF1E1B2E) : Colors.white)
                        .withOpacity(isDark ? 0.92 : 0.95),
                    border: Border.all(
                      color: isDark
                          ? Colors.white.withOpacity(0.08)
                          : primary.withOpacity(0.12),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: _MiniStat(
                          isDark: isDark,
                          primary: primary,
                          value: '${group.memberCount ?? 0}',
                          label: context.tr(AppStrings.members),
                          showDot: showPendingDot,
                          onTap: canOpenMembers ? onMembers : null,
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 28.h,
                        color:
                            HomeDashboardColors.border(isDark).withOpacity(0.8),
                      ),
                      Expanded(
                        child: _MiniStat(
                          isDark: isDark,
                          primary: primary,
                          value: '$postsCount',
                          label: context.tr(AppStrings.posts),
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 28.h,
                        color:
                            HomeDashboardColors.border(isDark).withOpacity(0.8),
                      ),
                      Expanded(
                        child: _MiniStat(
                          isDark: isDark,
                          primary: primary,
                          value: private
                              ? context.tr(AppStrings.private)
                              : context.tr(AppStrings.public),
                          label: context.tr(AppStrings.access),
                          compact: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),

        // ── Actions ──
        Padding(
          padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 0),
          child: canPost
              ? Row(
                  children: [
                    Expanded(
                      child: _ActionBtn(
                        label: context.tr(AppStrings.invite),
                        icon: Icons.person_add_alt_1_rounded,
                        filled: false,
                        primary: primary,
                        isDark: isDark,
                        compact: true,
                        onTap: onInvite,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: _ActionBtn(
                        key: newPostKey,
                        label: context.tr(AppStrings.newPost),
                        icon: Icons.edit_rounded,
                        filled: true,
                        primary: primary,
                        isDark: isDark,
                        compact: true,
                        onTap: onCreatePost,
                      ),
                    ),
                  ],
                )
              : _JoinRow(
                  primary: primary,
                  isDark: isDark,
                  group: group,
                  isOwner: isOwner,
                  loading: isInvitationLoading,
                  onJoin: onJoin,
                  onAccept: onAccept,
                  onDecline: onDecline,
                ),
        ),

        SizedBox(height: 14.h),
        Container(
          decoration: BoxDecoration(
            color: scaffold,
            border: Border(
              bottom: BorderSide(
                color: HomeDashboardColors.border(isDark).withOpacity(0.75),
              ),
            ),
          ),
          child: Row(
            children: [
              _SimpleTab(
                label: context.tr(AppStrings.posts),
                selected: tab == 0,
                primary: primary,
                isDark: isDark,
                onTap: () => onTab(0),
              ),
              _SimpleTab(
                label: context.tr(AppStrings.about),
                selected: tab == 1,
                primary: primary,
                isDark: isDark,
                onTap: () => onTab(1),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _GlassIconButton extends StatelessWidget {
  final bool isDark;
  final IconData icon;
  final VoidCallback? onTap;

  const _GlassIconButton({
    required this.isDark,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final iconColor =
        isDark ? Colors.white : const Color(0xFF4C1D95);
    return Material(
      color: isDark
          ? Colors.white.withOpacity(0.1)
          : Colors.white.withOpacity(0.72),
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: 36.r,
          height: 36.r,
          child: Icon(icon, size: 17.sp, color: iconColor),
        ),
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final String value;
  final String label;
  final bool showDot;
  final bool compact;
  final VoidCallback? onTap;

  const _MiniStat({
    required this.isDark,
    required this.primary,
    required this.value,
    required this.label,
    this.showDot = false,
    this.compact = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final clickable = onTap != null;

    final child = Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: compact ? 13.sp : 16.sp,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.3,
                  color: HomeDashboardColors.title(isDark),
                ),
              ),
            ),
            if (showDot) ...[
              SizedBox(width: 4.w),
              Container(
                width: 6.r,
                height: 6.r,
                decoration: const BoxDecoration(
                  color: HomeDashboardColors.danger,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ],
        ),
        SizedBox(height: clickable ? 5.h : 2.h),
        if (clickable)
          Container(
            padding: EdgeInsets.fromLTRB(8.w, 3.h, 5.w, 3.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(99),
              border: Border.all(color: primary.withOpacity(0.35)),
              color: primary.withOpacity(isDark ? 0.12 : 0.06),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w700,
                    color: primary,
                  ),
                ),
                SizedBox(width: 1.w),
                Icon(
                  Icons.chevron_right_rounded,
                  size: 14.sp,
                  color: primary,
                ),
              ],
            ),
          )
        else
          Text(
            label,
            style: TextStyle(
              fontSize: 10.5.sp,
              fontWeight: FontWeight.w600,
              color: HomeDashboardColors.subtitle(isDark),
            ),
          ),
      ],
    );

    if (!clickable) return child;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14.r),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
          child: child,
        ),
      ),
    );
  }
}

class _SimpleTab extends StatelessWidget {
  final String label;
  final bool selected;
  final Color primary;
  final bool isDark;
  final VoidCallback onTap;

  const _SimpleTab({
    required this.label,
    required this.selected,
    required this.primary,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13.5.sp,
                  fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
                  color: selected
                      ? HomeDashboardColors.title(isDark)
                      : HomeDashboardColors.subtitle(isDark),
                ),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 2.5,
              margin: EdgeInsets.symmetric(horizontal: 36.w),
              decoration: BoxDecoration(
                color: selected ? primary : Colors.transparent,
                borderRadius: BorderRadius.circular(99),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionBtn extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool filled;
  final Color primary;
  final bool isDark;
  final VoidCallback onTap;
  final bool compact;

  const _ActionBtn({
    super.key,
    required this.label,
    required this.icon,
    required this.filled,
    required this.primary,
    required this.isDark,
    required this.onTap,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final height = compact ? 34.h : 42.h;
    final radius = compact ? 11.r : 13.r;
    final fontSize = compact ? 12.sp : 13.sp;
    final iconSize = compact ? 14.sp : 16.sp;

    return SizedBox(
      height: height,
      child: filled
          ? ElevatedButton.icon(
              onPressed: onTap,
              icon: Icon(icon, size: iconSize),
              label: Text(
                label,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w700,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: primary,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                minimumSize: Size(0, height),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius),
                ),
              ),
            )
          : OutlinedButton.icon(
              onPressed: onTap,
              icon: Icon(icon, size: iconSize),
              label: Text(
                label,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w700,
                ),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: HomeDashboardColors.title(isDark),
                backgroundColor: HomeDashboardColors.cardBg(isDark),
                side: BorderSide(color: HomeDashboardColors.border(isDark)),
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                minimumSize: Size(0, height),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius),
                ),
              ),
            ),
    );
  }
}

class _JoinRow extends StatelessWidget {
  final Color primary;
  final bool isDark;
  final GroupModel group;
  final bool isOwner;
  final bool loading;
  final VoidCallback onJoin;
  final VoidCallback onAccept;
  final VoidCallback onDecline;

  const _JoinRow({
    required this.primary,
    required this.isDark,
    required this.group,
    required this.isOwner,
    required this.loading,
    required this.onJoin,
    required this.onAccept,
    required this.onDecline,
  });

  @override
  Widget build(BuildContext context) {
    final invited = group.userStatus == GroupInviteStatus.invited.name;
    if (invited && !isOwner) {
      if (loading) {
        return SizedBox(
          height: 38.h,
          child: Center(
            child: CircularProgressIndicator(color: primary, strokeWidth: 2),
          ),
        );
      }
      return Row(
        children: [
          Expanded(
            child: _ActionBtn(
              label: context.tr(AppStrings.decline),
              icon: Icons.close_rounded,
              filled: false,
              primary: primary,
              isDark: isDark,
              onTap: onDecline,
              compact: true,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: _ActionBtn(
              label: context.tr(AppStrings.acceptInvitation),
              icon: Icons.check_rounded,
              filled: true,
              primary: primary,
              isDark: isDark,
              onTap: onAccept,
              compact: true,
            ),
          ),
        ],
      );
    }
    final pending = (invited && group.privacy == GroupStatus.private.name) ||
        group.userStatus == GroupInviteStatus.pending.name;
    return SizedBox(
      width: double.infinity,
      height: 38.h,
      child: ElevatedButton(
        onPressed: pending ? null : onJoin,
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          disabledBackgroundColor: primary.withOpacity(0.35),
          foregroundColor: Colors.white,
          elevation: 0,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          minimumSize: Size(0, 38.h),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Text(
          pending
              ? context.tr(AppStrings.pending)
              : context.tr(AppStrings.join),
          style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

class _AboutBody extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final GroupModel group;
  final String createdLabel;

  const _AboutBody({
    required this.isDark,
    required this.primary,
    required this.group,
    required this.createdLabel,
  });

  @override
  Widget build(BuildContext context) {
    final owner = [group.owner?.firstName, group.owner?.lastName]
        .where((e) => e != null && e.trim().isNotEmpty)
        .join(' ');

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: HomeDashboardDecor.card(isDark),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.tr(AppStrings.description),
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  color: HomeDashboardColors.title(isDark),
                ),
              ),
              SizedBox(height: 8.h),
              if ((group.description ?? '').trim().isNotEmpty)
                ReadMoreText(
                  group.description ?? '',
                  trimMode: TrimMode.Line,
                  trimLines: 5,
                  colorClickableText: primary,
                  trimCollapsedText: ' ${context.tr(AppStrings.seeMore)} ',
                  trimExpandedText: ' ${context.tr(AppStrings.seeLess)} ',
                  moreStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: primary,
                    fontSize: 11.sp,
                  ),
                  lessStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: primary,
                    fontSize: 11.sp,
                  ),
                  style: TextStyle(
                    fontSize: 13.sp,
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                    color: HomeDashboardColors.subtitle(isDark),
                  ),
                )
              else
                Text(
                  context.tr(AppStrings.noDescriptionYet),
                  style: TextStyle(
                    color: HomeDashboardColors.subtitle(isDark),
                    fontSize: 12.sp,
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: 10.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
          decoration: HomeDashboardDecor.card(isDark),
          child: Column(
            children: [
              _AboutRow(
                isDark: isDark,
                icon: Icons.shield_outlined,
                label: context.tr(AppStrings.adminOfGroup),
                value: owner.isEmpty ? '—' : owner,
              ),
              Divider(
                height: 18.h,
                color: HomeDashboardColors.border(isDark).withOpacity(0.8),
              ),
              _AboutRow(
                isDark: isDark,
                icon: Icons.calendar_today_outlined,
                label: context.tr(AppStrings.created),
                value: createdLabel,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AboutRow extends StatelessWidget {
  final bool isDark;
  final IconData icon;
  final String label;
  final String value;

  const _AboutRow({
    required this.isDark,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 34.r,
          height: 34.r,
          decoration: BoxDecoration(
            color: HomeDashboardColors.surfaceBg(isDark),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(
            icon,
            size: 16.sp,
            color: HomeDashboardColors.subtitle(isDark),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 11.sp,
                  color: HomeDashboardColors.subtitle(isDark),
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  color: HomeDashboardColors.title(isDark),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Loading extends StatelessWidget {
  final bool isDark;

  const _Loading({required this.isDark});

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.paddingOf(context).top;
    final scaffold = HomeDashboardColors.scaffold(isDark);
    final base = isDark ? const Color(0xFF2A2733) : const Color(0xFFE8E4F5);
    final highlight =
        isDark ? const Color(0xFF3A3645) : const Color(0xFFF5F2FF);
    final bone = isDark ? const Color(0xFF353142) : const Color(0xFFDDD7F0);

    return ColoredBox(
      color: scaffold,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(8.w, top + 2.h, 12.w, 36.h),
            color: const Color(0xFF0F172A),
            child: Column(
              children: [
                const Row(
                  children: [
                    _LoadDot(color: Colors.white24),
                    Spacer(),
                    _LoadDot(color: Colors.white24),
                  ],
                ),
                SizedBox(height: 14.h),
                Row(
                  children: [
                    Container(
                      width: 72.r,
                      height: 72.r,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white12,
                      ),
                    ),
                    SizedBox(width: 14.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 90.w,
                            height: 18.h,
                            decoration: BoxDecoration(
                              color: Colors.white12,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Container(
                            width: 140.w,
                            height: 16.h,
                            decoration: BoxDecoration(
                              color: Colors.white12,
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Container(
                            width: 110.w,
                            height: 10.h,
                            decoration: BoxDecoration(
                              color: Colors.white10,
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Transform.translate(
            offset: Offset(0, -18.h),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Shimmer.fromColors(
                baseColor: base,
                highlightColor: highlight,
                child: _LoadBar(height: 56.h, radius: 20, color: bone),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Shimmer.fromColors(
              baseColor: base,
              highlightColor: highlight,
              child: Row(
                children: [
                  Expanded(
                      child: _LoadBar(height: 46.h, radius: 14, color: bone)),
                  SizedBox(width: 10.w),
                  Expanded(
                      child: _LoadBar(height: 46.h, radius: 14, color: bone)),
                ],
              ),
            ),
          ),
          SizedBox(height: 14.h),
          Expanded(
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
              itemCount: 2,
              separatorBuilder: (_, __) => SizedBox(height: 12.h),
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                  baseColor: base,
                  highlightColor: highlight,
                  child: Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: HomeDashboardDecor.card(isDark),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 36.r,
                              height: 36.r,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: bone,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _LoadBar(
                                    width: 120.w,
                                    height: 12.h,
                                    color: bone,
                                  ),
                                  SizedBox(height: 6.h),
                                  _LoadBar(
                                    width: 72.w,
                                    height: 10.h,
                                    color: bone,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        _LoadBar(height: 10.h, color: bone),
                        SizedBox(height: 8.h),
                        _LoadBar(width: 200.w, height: 10.h, color: bone),
                        SizedBox(height: 12.h),
                        _LoadBar(height: 96.h, radius: 12, color: bone),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadDot extends StatelessWidget {
  final Color color;

  const _LoadDot({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34.r,
      height: 34.r,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class _LoadBar extends StatelessWidget {
  final double? width;
  final double height;
  final double radius;
  final Color color;

  const _LoadBar({
    this.width,
    required this.height,
    this.radius = 6,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius.r),
      ),
    );
  }
}
