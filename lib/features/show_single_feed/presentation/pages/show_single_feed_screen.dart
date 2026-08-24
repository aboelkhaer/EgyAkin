import 'dart:developer';
import 'dart:ui';

import 'package:egy_akin/app/shared/widgets/admin_only_badge.dart';
import 'package:egy_akin/app/shared/functions/permissions_helper.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';

import '../../../../exports.dart';

class ShowSingleFeedScreen extends StatefulWidget {
  final HomeModelResponse homeDataModel;
  final DoctorModel currentDoctorModel;
  final PostCommunityModel feed;
  final bool isComeFromNotification;
  final String? feedId;
  final String showPostFrom;

  const ShowSingleFeedScreen({
    super.key,
    required this.homeDataModel,
    required this.currentDoctorModel,
    required this.feed,
    this.isComeFromNotification = false,
    this.feedId,
    required this.showPostFrom,
  });

  @override
  State<ShowSingleFeedScreen> createState() => _ShowSingleFeedScreenState();
}

class _ShowSingleFeedScreenState extends State<ShowSingleFeedScreen>
    with SingleTickerProviderStateMixin {
  late final ShowSingleFeedCubit _cubit;
  late final ScrollController _scrollController;
  late final AnimationController _contentController;
  late final Animation<double> _headerFade;
  late final Animation<Offset> _headerSlide;
  late final Animation<double> _bodyFade;
  late final Animation<Offset> _bodySlide;
  late final Animation<Offset> _composerSlide;

  PostCommunityModel? _currentFeed;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<ShowSingleFeedCubit>();
    _currentFeed = widget.feed;
    _cubit.showPostFrom = widget.showPostFrom;
    log(_cubit.showPostFrom);

    _scrollController = ScrollController()..addListener(_onScroll);
    _cubit.feedScrollController = _scrollController;

    // Soft content motion (starts nearly visible to avoid flash with route fade).
    _contentController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 520),
    );
    _headerFade = Tween<double>(begin: 0.88, end: 1.0).animate(
      CurvedAnimation(
        parent: _contentController,
        curve: const Interval(0.0, 0.55, curve: Curves.easeOut),
      ),
    );
    _headerSlide = Tween<Offset>(
      begin: const Offset(0, -0.03),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _contentController,
        curve: const Interval(0.0, 0.55, curve: Curves.easeOutCubic),
      ),
    );
    _bodyFade = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(
        parent: _contentController,
        curve: const Interval(0.15, 0.85, curve: Curves.easeOut),
      ),
    );
    _bodySlide = Tween<Offset>(
      begin: const Offset(0, 0.035),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _contentController,
        curve: const Interval(0.15, 0.9, curve: Curves.easeOutCubic),
      ),
    );
    _composerSlide = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _contentController,
        curve: const Interval(0.35, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _contentController.forward();
    });

    if (widget.isComeFromNotification) {
      _loadFeedFromNotification();
    } else {
      if (_currentFeed != null) {
        _cubit.getCommentsInCommunity(
          _currentFeed!.id.toString(),
          _currentFeed!,
          widget.isComeFromNotification,
        );
      }
    }
  }

  Future<void> _loadFeedFromNotification() async {
    try {
      final newFeed =
          await _cubit.getPostByIdWhenComeFromNotification(widget.feedId!);
      if (!mounted) return;
      setState(() => _currentFeed = newFeed);
      if (_currentFeed != null) {
        _cubit.getCommentsInCommunity(
          _currentFeed!.id.toString(),
          _currentFeed!,
          widget.isComeFromNotification,
        );
      }
    } catch (e) {
      debugPrint('Error loading feed from notification: $e');
    }
  }

  void _onScroll() {
    if (!_scrollController.hasClients ||
        _cubit.isLastPage ||
        _cubit.isLoadingMoreForScroll) {
      return;
    }

    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 200) {
      final feed = _currentFeed;
      if (feed?.id != null) {
        _cubit.loadMoreComments(feed!.id.toString());
      }
    }
  }

  @override
  void dispose() {
    if (identical(_cubit.feedScrollController, _scrollController)) {
      _cubit.feedScrollController = null;
    }
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _openDoctorProfile(PostCommunityModel feed) {
    final doctor = feed.doctor;
    if (doctor?.id == null) return;

    navigatorKey.currentState?.pushNamed(
      AppRoutes.doctorInfoView,
      arguments: AppRoutesArgs.doctorInfoViewRouteArgs(
        doctorId: doctor!.id.toString(),
        currentDoctorModel: widget.currentDoctorModel,
        currentDoctorPoints: int.parse(widget.homeDataModel.scoreValue!),
        accountVerification: widget.homeDataModel.verified!,
        initialIndex: 0,
        isSyndicateCardRequired:
            widget.homeDataModel.isSyndicateCardRequired.toString(),
        currentDoctorRole: widget.homeDataModel.role.toString(),
        homeDataModel: widget.homeDataModel,
        isNavigateToTheButtonOfInformationTab: false,
      ),
    );
  }

  bool _canManagePost(PostCommunityModel feed) {
    final isOwner =
        feed.doctor?.id?.toString() == widget.currentDoctorModel.id.toString();
    final isAdmin = PermissionHelper.canPermission(
      AppPermissions.viewEditAndDeletePostForAdmin,
    );
    return isOwner || isAdmin;
  }

  void _onMenuSelected(String value, PostCommunityModel feed, bool isDark) {
    switch (value) {
      case 'Report':
        debugPrint('Report clicked');
        break;
      case 'Edit':
        navigatorKey.currentState?.pushNamed(
          AppRoutes.createPostInCommunity,
          arguments: AppRoutesArgs.createPostInCommunityRouteArgs(
            currentDoctorModel: widget.currentDoctorModel,
            homeDataModel: widget.homeDataModel,
            feed: feed,
          ),
        );
        break;
      case 'Delete':
        _showDeleteDialog(feed, isDark);
        break;
    }
  }

  void _showDeleteDialog(PostCommunityModel feed, bool isDark) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: HomeDashboardColors.cardBg(isDark),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          title: Text(
            context.tr(AppStrings.deletePost),
            style: TextStyle(
              color: HomeDashboardColors.title(isDark),
              fontWeight: FontWeight.w800,
              fontSize: 16.sp,
            ),
          ),
          content: Text(
            context.tr(AppStrings.areYouSureYouWantToDeleteThisPost),
            style: TextStyle(
              color: HomeDashboardColors.subtitle(isDark),
              fontSize: 13.sp,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                context.tr(AppStrings.cancel),
                style: TextStyle(
                  color: HomeDashboardColors.subtitle(isDark),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                sl<CommunityCubit>().deletePost(feed.id.toString());
                Navigator.pop(context);
                navigatorKey.currentState?.pop();
              },
              child: Text(
                context.tr(AppStrings.delete),
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  List<PopupMenuEntry<String>> _buildMenuItems(PostCommunityModel feed) {
    final items = <PopupMenuEntry<String>>[];
    if (!_canManagePost(feed)) return items;

    final showAdminBadge = PermissionHelper.canPermission(
          AppPermissions.viewEditAndDeletePostForAdmin,
        ) &&
        widget.currentDoctorModel.id.toString() != feed.doctor!.id.toString();

    items.add(
      PopupMenuItem(
        value: 'Edit',
        child: AdminOnlyBadge(
          showBadge: showAdminBadge,
          style: BadgeStyle.premium,
          fontSize: 6.sp,
          badgePadding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
          showIcon: false,
          glowEffect: true,
          pulseAnimation: true,
          badgeText: 'A',
          top: -5,
          right: -5,
          child: Row(
            children: [
              Icon(Icons.edit_outlined,
                  size: 18.sp, color: AppColors.description),
              SizedBox(width: 8.w),
              Text(context.tr(AppStrings.edit)),
            ],
          ),
        ),
      ),
    );
    items.add(
      PopupMenuItem(
        value: 'Delete',
        child: AdminOnlyBadge(
          showBadge: showAdminBadge,
          style: BadgeStyle.premium,
          fontSize: 6.sp,
          badgePadding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
          showIcon: false,
          glowEffect: true,
          pulseAnimation: true,
          badgeText: 'A',
          top: -5,
          right: -5,
          child: Row(
            children: [
              Icon(Icons.delete_outline,
                  size: 18.sp, color: AppColors.description),
              SizedBox(width: 8.w),
              Text(context.tr(AppStrings.delete)),
            ],
          ),
        ),
      ),
    );
    return items;
  }

  @override
  Widget build(BuildContext context) {
    final feedToUse = _currentFeed ?? widget.feed;

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final primary = HomeDashboardColors.primary(isDark);
        final scaffold = HomeDashboardColors.scaffold(isDark);

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value:
              isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
          child: Scaffold(
            backgroundColor: scaffold,
            resizeToAvoidBottomInset: false,
            body: Stack(
              children: [
                Positioned(
                  top: -50.h,
                  right: -40.w,
                  child: IgnorePointer(
                    child: ImageFiltered(
                      imageFilter: ImageFilter.blur(sigmaX: 36, sigmaY: 36),
                      child: Container(
                        width: 160.r,
                        height: 160.r,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: primary.withOpacity(isDark ? 0.16 : 0.1),
                        ),
                      ),
                    ),
                  ),
                ),
                if (widget.isComeFromNotification)
                  BlocBuilder<ShowSingleFeedCubit, ShowSingleFeedState>(
                    builder: (context, state) {
                      // Once the post is resolved, keep the feed UI mounted so
                      // comment loading doesn't flash a full-screen spinner.
                      final resolvedFeed = _currentFeed;
                      if (resolvedFeed != null) {
                        return _FeedScaffold(
                          isDark: isDark,
                          primary: primary,
                          scrollController: _scrollController,
                          headerFade: _headerFade,
                          headerSlide: _headerSlide,
                          bodyFade: _bodyFade,
                          bodySlide: _bodySlide,
                          composerSlide: _composerSlide,
                          feed: resolvedFeed,
                          homeDataModel: widget.homeDataModel,
                          currentDoctorModel: widget.currentDoctorModel,
                          canManage: _canManagePost(resolvedFeed),
                          menuItems: _buildMenuItems(resolvedFeed),
                          onBack: () => navigatorKey.currentState?.pop(),
                          onOpenDoctor: () => _openDoctorProfile(resolvedFeed),
                          onMenuSelected: (value) =>
                              _onMenuSelected(value, resolvedFeed, isDark),
                        );
                      }

                      return state.maybeWhen(
                        orElse: () => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        error: (_) => _UnavailableBody(
                          isDark: isDark,
                          onBack: () => Navigator.pop(context),
                        ),
                      );
                    },
                  )
                else
                  _FeedScaffold(
                    isDark: isDark,
                    primary: primary,
                    scrollController: _scrollController,
                    headerFade: _headerFade,
                    headerSlide: _headerSlide,
                    bodyFade: _bodyFade,
                    bodySlide: _bodySlide,
                    composerSlide: _composerSlide,
                    feed: feedToUse,
                    homeDataModel: widget.homeDataModel,
                    currentDoctorModel: widget.currentDoctorModel,
                    canManage: _canManagePost(feedToUse),
                    menuItems: _buildMenuItems(feedToUse),
                    onBack: () => navigatorKey.currentState?.pop(),
                    onOpenDoctor: () => _openDoctorProfile(feedToUse),
                    onMenuSelected: (value) =>
                        _onMenuSelected(value, feedToUse, isDark),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _UnavailableBody extends StatelessWidget {
  final bool isDark;
  final VoidCallback onBack;

  const _UnavailableBody({required this.isDark, required this.onBack});

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.paddingOf(context).top;
    return Column(
      children: [
        SizedBox(height: top + 8.h),
        Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
            onPressed: onBack,
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 18.sp,
              color: HomeDashboardColors.title(isDark),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 64.r,
                    height: 64.r,
                    decoration: BoxDecoration(
                      color: HomeDashboardColors.surfaceBg(isDark),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.hide_source_rounded,
                      size: 28.sp,
                      color: HomeDashboardColors.subtitle(isDark),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    context.tr(AppStrings.thisContentIsNoLongerAvailable),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: HomeDashboardColors.subtitle(isDark),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _FeedScaffold extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final ScrollController scrollController;
  final Animation<double> headerFade;
  final Animation<Offset> headerSlide;
  final Animation<double> bodyFade;
  final Animation<Offset> bodySlide;
  final Animation<Offset> composerSlide;
  final PostCommunityModel feed;
  final HomeModelResponse homeDataModel;
  final DoctorModel currentDoctorModel;
  final bool canManage;
  final List<PopupMenuEntry<String>> menuItems;
  final VoidCallback onBack;
  final VoidCallback onOpenDoctor;
  final ValueChanged<String> onMenuSelected;

  const _FeedScaffold({
    required this.isDark,
    required this.primary,
    required this.scrollController,
    required this.headerFade,
    required this.headerSlide,
    required this.bodyFade,
    required this.bodySlide,
    required this.composerSlide,
    required this.feed,
    required this.homeDataModel,
    required this.currentDoctorModel,
    required this.canManage,
    required this.menuItems,
    required this.onBack,
    required this.onOpenDoctor,
    required this.onMenuSelected,
  });

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.paddingOf(context).top;
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    final keyboard = MediaQuery.viewInsetsOf(context).bottom;
    final cubit = context.watch<ShowSingleFeedCubit>();
    final replyBannerExtra = cubit.commentToReply != null ? 48.h : 0.0;
    final composerReserve = 120.h + replyBannerExtra;

    return Stack(
      fit: StackFit.expand,
      children: [
        Column(
          children: [
            FadeTransition(
              opacity: headerFade,
              child: SlideTransition(
                position: headerSlide,
                child: _FeedHeader(
                  isDark: isDark,
                  primary: primary,
                  topInset: top,
                  feed: feed,
                  canManage: canManage,
                  menuItems: menuItems,
                  onBack: onBack,
                  onOpenDoctor: onOpenDoctor,
                  onMenuSelected: onMenuSelected,
                ),
              ),
            ),
            Expanded(
              child: FadeTransition(
                opacity: bodyFade,
                child: SlideTransition(
                  position: bodySlide,
                  // onTap (not pointer-down) so Reply/Like still win the gesture.
                  child: GestureDetector(
                    onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                    behavior: HitTestBehavior.opaque,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      controller: scrollController,
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      padding: EdgeInsets.only(
                        top: cubit.replyAnchorTopPadding,
                        bottom: composerReserve + bottomInset + keyboard,
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 8.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: Container(
                              width: double.infinity,
                              decoration:
                                  HomeDashboardDecor.card(isDark).copyWith(
                                borderRadius: BorderRadius.circular(18.r),
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: FeedContentInCommunity(
                                homeDataModel: homeDataModel,
                                currentDoctorModel: currentDoctorModel,
                                feed: feed,
                              ),
                            ),
                          ),
                          SizedBox(height: 12.h),
                          CommentsInCommunity(
                            homeDataModel: homeDataModel,
                            currentDoctorModel: currentDoctorModel,
                            feed: feed,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: SlideTransition(
            position: composerSlide,
            child: KeyedSubtree(
              key: cubit.composerKey,
              child: WriteCommentInCommunity(
                accountVerification: homeDataModel.verified ?? false,
                isSyndicateCardRequired:
                    homeDataModel.isSyndicateCardRequired ?? 'Required',
                feed: feed,
                currentDoctorModel: currentDoctorModel,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _FeedHeader extends StatelessWidget {
  final bool isDark;
  final Color primary;
  final double topInset;
  final PostCommunityModel feed;
  final bool canManage;
  final List<PopupMenuEntry<String>> menuItems;
  final VoidCallback onBack;
  final VoidCallback onOpenDoctor;
  final ValueChanged<String> onMenuSelected;

  const _FeedHeader({
    required this.isDark,
    required this.primary,
    required this.topInset,
    required this.feed,
    required this.canManage,
    required this.menuItems,
    required this.onBack,
    required this.onOpenDoctor,
    required this.onMenuSelected,
  });

  @override
  Widget build(BuildContext context) {
    final doctor = feed.doctor;
    final name = doctor == null
        ? 'Unknown User'
        : doctorName(
            firstName: doctor.firstName,
            lastName: doctor.lastName,
            role: doctor.isSyndicateCardRequired.toString(),
          );
    final image = doctor?.image?.toString() ?? '';
    final time = feed.createdAt == null
        ? ''
        : TimeAgoService.instance.formatTimeAgoFromString(
            feed.createdAt.toString(),
            context,
          );
    final verified =
        doctor != null && isVerifiedUser(doctor.isSyndicateCardRequired);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(4.w, topInset + 4.h, 8.w, 12.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isDark
              ? [
                  HomeDashboardColors.headerDark,
                  HomeDashboardColors.scaffold(isDark)
                ]
              : [
                  HomeDashboardColors.headerLight,
                  HomeDashboardColors.scaffold(isDark)
                ],
        ),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 18.sp,
              color: HomeDashboardColors.title(isDark),
            ),
          ),
          GestureDetector(
            onTap: onOpenDoctor,
            child: Container(
              width: 42.r,
              height: 42.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: primary.withOpacity(0.35),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: primary.withOpacity(isDark ? 0.2 : 0.12),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipOval(
                child: image.isEmpty
                    ? ColoredBox(
                        color: primary.withOpacity(0.15),
                        child: Center(
                          child: Text(
                            '@',
                            style: TextStyle(
                              color: primary,
                              fontWeight: FontWeight.w800,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      )
                    : CustomCachedNetworkImage(
                        imageUrl: image,
                        height: 42.r,
                        width: 42.r,
                      ),
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: GestureDetector(
              onTap: onOpenDoctor,
              behavior: HitTestBehavior.opaque,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13.5.sp,
                            fontWeight: FontWeight.w800,
                            color: HomeDashboardColors.title(isDark),
                          ),
                        ),
                      ),
                      if (verified) ...[
                        SizedBox(width: 4.w),
                        const VerificationIcon(isPatientCard: false),
                      ],
                    ],
                  ),
                  if (time.isNotEmpty)
                    Text(
                      time,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 10.5.sp,
                        fontWeight: FontWeight.w500,
                        color: HomeDashboardColors.subtitle(isDark),
                      ),
                    ),
                ],
              ),
            ),
          ),
          if (canManage && menuItems.isNotEmpty)
            PopupMenuButton<String>(
              icon: Icon(
                Icons.more_horiz_rounded,
                color: HomeDashboardColors.title(isDark),
              ),
              color: HomeDashboardColors.cardBg(isDark),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              onSelected: onMenuSelected,
              itemBuilder: (_) => menuItems,
            ),
        ],
      ),
    );
  }
}
