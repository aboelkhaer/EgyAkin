import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';
import 'package:egy_akin/features/notification/presentation/widgets/notification_loading_shimmer.dart';

import '../../../../exports.dart';

class NotificationScreen extends StatefulWidget {
  final DoctorModel currentDoctorModel;
  final bool accountVerification;
  final String isSyndicateCardRequired;
  final String currentDoctorRole;
  final int currentDoctorPoints;
  final HomeModelResponse homeDataModel;

  const NotificationScreen({
    super.key,
    required this.currentDoctorModel,
    required this.accountVerification,
    required this.isSyndicateCardRequired,
    required this.currentDoctorRole,
    required this.currentDoctorPoints,
    required this.homeDataModel,
  });

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with SingleTickerProviderStateMixin {
  late NotificationCubit _cubit;
  bool _showScrollTop = false;
  late final AnimationController _enterCtrl;
  late final Animation<double> _fadeIn;
  late final Animation<Offset> _slideIn;

  @override
  void initState() {
    super.initState();
    _cubit = NotificationCubit.get(context);
    _cubit.scrollController = ScrollController();
    _cubit.scrollController!.addListener(_onScroll);

    _enterCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 480),
    );
    _fadeIn = CurvedAnimation(parent: _enterCtrl, curve: Curves.easeOutCubic);
    _slideIn = Tween<Offset>(
      begin: const Offset(0, 0.03),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _enterCtrl, curve: Curves.easeOutCubic));
    _enterCtrl.forward();
  }

  @override
  void dispose() {
    _cubit.scrollController?.removeListener(_onScroll);
    _enterCtrl.dispose();
    super.dispose();
  }

  void _onScroll() {
    final controller = _cubit.scrollController;
    if (controller == null || !controller.hasClients) return;

    final shouldShow = controller.offset > 180;
    if (shouldShow != _showScrollTop) {
      setState(() => _showScrollTop = shouldShow);
    }

    if (_cubit.isLastPage) return;

    final maxScroll = controller.position.maxScrollExtent;
    final currentScroll = controller.position.pixels;
    const threshold = 200.0;

    if (!_cubit.isLoadingMoreForScroll &&
        maxScroll - currentScroll <= threshold) {
      _cubit.isLoadingMoreForScroll = true;
      _cubit.loadMoreNotifications();
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = NotificationCubit.get(context);

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final canvas = HomeDashboardColors.scaffold(isDark);
        final sheet = HomeDashboardColors.cardBg(isDark);
        final ink = HomeDashboardColors.title(isDark);
        final muted = HomeDashboardColors.subtitle(isDark);
        final accent = HomeDashboardColors.primary(isDark);
        final line = HomeDashboardColors.border(isDark).withOpacity(0.85);

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: isDark
              ? SystemUiOverlayStyle.light
                  .copyWith(statusBarColor: Colors.transparent)
              : SystemUiOverlayStyle.dark
                  .copyWith(statusBarColor: Colors.transparent),
          child: Scaffold(
            backgroundColor: canvas,
            body: Stack(
              children: [
                Positioned(
                  top: -90.h,
                  right: -50.w,
                  child: IgnorePointer(
                    child: Container(
                      width: 220.w,
                      height: 220.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            accent.withOpacity(isDark ? 0.28 : 0.16),
                            accent.withOpacity(0),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    FadeInDown(
                      duration: const Duration(milliseconds: 420),
                      from: 16,
                      child: _NotificationHeader(
                        isDark: isDark,
                        canvas: canvas,
                        accent: accent,
                        ink: ink,
                        muted: muted,
                        onBack: () => Navigator.of(context).maybePop(),
                        unreadBadge: BlocBuilder<NotificationCubit,
                            NotificationState>(
                          builder: (context, state) {
                            final unread = state.maybeWhen(
                              orElse: () => 0,
                              loaded: (data, _) {
                                final fromApi =
                                    int.tryParse(data.unreadCount ?? '') ?? 0;
                                if (fromApi > 0) return fromApi;
                                final today = data.todayRecords ?? [];
                                final recent = data.recentRecords?.data ?? [];
                                return [...today, ...recent]
                                    .where((n) => n.read == false)
                                    .length;
                              },
                            );
                            return AnimatedSwitcher(
                              duration: const Duration(milliseconds: 280),
                              transitionBuilder: (child, animation) {
                                return ScaleTransition(
                                  scale: animation,
                                  child: FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  ),
                                );
                              },
                              child: unread <= 0
                                  ? const SizedBox.shrink(key: ValueKey('none'))
                                  : Container(
                                      key: ValueKey('unread-$unread'),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 9.w,
                                        vertical: 5.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: accent,
                                        borderRadius:
                                            BorderRadius.circular(999),
                                        boxShadow: [
                                          BoxShadow(
                                            color: accent.withOpacity(0.35),
                                            blurRadius: 8,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Text(
                                        unread > 99
                                            ? context.tr(
                                                AppStrings.unreadOverflow,
                                              )
                                            : '$unread ${context.tr(AppStrings.unread)}',
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                            );
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: FadeTransition(
                        opacity: _fadeIn,
                        child: SlideTransition(
                          position: _slideIn,
                          child: RefreshIndicator(
                            onRefresh: () async {
                              animateToTopOfScreen(cubit.scrollController!);
                              await _cubit.getAllNotifications();
                            },
                            color: accent,
                            child: SingleChildScrollView(
                              controller: _cubit.scrollController,
                              physics: const AlwaysScrollableScrollPhysics(
                                parent: BouncingScrollPhysics(),
                              ),
                              padding:
                                  EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 28.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  BlocConsumer<NotificationCubit,
                                      NotificationState>(
                                    listener: (context, state) {
                                      state.maybeWhen(
                                        orElse: () {},
                                        error: (message) {
                                          customSnackBar(
                                            context: context,
                                            message: message,
                                          );
                                        },
                                        loaded: (notificationData, isSeeMore) {
                                          context
                                              .read<HomeCubit>()
                                              .removeNotificationCount();
                                        },
                                      );
                                    },
                                    builder: (context, state) {
                                      return AnimatedSwitcher(
                                        duration:
                                            const Duration(milliseconds: 380),
                                        switchInCurve: Curves.easeOutCubic,
                                        switchOutCurve: Curves.easeInCubic,
                                        child: state.maybeWhen(
                                          orElse: () => NotificationLoadingShimmer(
                                            key: const ValueKey('loading'),
                                            isDark: isDark,
                                          ),
                                          loaded:
                                              (notificationData, isSeeMore) {
                                            final today = notificationData
                                                    .todayRecords ??
                                                [];
                                            if (today.isEmpty) {
                                              return const SizedBox.shrink(
                                                key: ValueKey('today-empty'),
                                              );
                                            }
                                            return Column(
                                              key: const ValueKey('today'),
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                FadeInLeft(
                                                  duration: const Duration(
                                                      milliseconds: 360),
                                                  child: _SectionHeader(
                                                    title: context.tr(
                                                      AppStrings.todayUpper,
                                                    ),
                                                    muted: muted,
                                                    line: line,
                                                  ),
                                                ),
                                                SizedBox(height: 8.h),
                                                NotificationsView(
                                                  notificationsModel: today,
                                                  currentDoctorModel:
                                                      widget.currentDoctorModel,
                                                  currentDoctorRole:
                                                      widget.currentDoctorRole,
                                                  currentDoctorPoints: widget
                                                      .currentDoctorPoints,
                                                  accountVerification: widget
                                                      .accountVerification,
                                                  isSyndicateCardRequired: widget
                                                      .isSyndicateCardRequired,
                                                  homeDataModel:
                                                      widget.homeDataModel,
                                                  isDarkMode: isDark,
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(height: 14.h),
                                  BlocBuilder<NotificationCubit,
                                      NotificationState>(
                                    builder: (context, state) {
                                      return state.maybeWhen(
                                        orElse: () => const SizedBox.shrink(),
                                        loaded:
                                            (notificationData, isSeeMore) {
                                          final today =
                                              notificationData.todayRecords ??
                                                  [];
                                          final recent = notificationData
                                                  .recentRecords?.data ??
                                              [];
                                          final isEmpty = today.isEmpty &&
                                              recent.isEmpty;

                                          if (isEmpty) {
                                            return FadeInUp(
                                              from: 18,
                                              duration: const Duration(
                                                  milliseconds: 450),
                                              child: _EmptyNotifications(
                                                isDark: isDark,
                                                ink: ink,
                                                muted: muted,
                                                accent: accent,
                                                sheet: sheet,
                                                line: line,
                                              ),
                                            );
                                          }

                                          if (recent.isEmpty) {
                                            return const SizedBox.shrink();
                                          }

                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              FadeInLeft(
                                                duration: const Duration(
                                                    milliseconds: 360),
                                                delay: const Duration(
                                                    milliseconds: 80),
                                                child: _SectionHeader(
                                                  title: context.tr(
                                                    AppStrings.recentUpper,
                                                  ),
                                                  muted: muted,
                                                  line: line,
                                                ),
                                              ),
                                              SizedBox(height: 8.h),
                                              NotificationsView(
                                                notificationsModel: recent,
                                                currentDoctorModel:
                                                    widget.currentDoctorModel,
                                                currentDoctorRole:
                                                    widget.currentDoctorRole,
                                                currentDoctorPoints:
                                                    widget.currentDoctorPoints,
                                                accountVerification: widget
                                                    .accountVerification,
                                                isSyndicateCardRequired: widget
                                                    .isSyndicateCardRequired,
                                                homeDataModel:
                                                    widget.homeDataModel,
                                                isDarkMode: isDark,
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                  BlocBuilder<NotificationCubit,
                                      NotificationState>(
                                    builder: (context, state) {
                                      return state.maybeWhen(
                                        orElse: () => const SizedBox.shrink(),
                                        loaded:
                                            (notificationData, isSeeMore) {
                                          if (!isSeeMore) {
                                            return const SizedBox.shrink();
                                          }
                                          return Padding(
                                            padding:
                                                EdgeInsets.only(top: 16.h),
                                            child: Center(
                                              child: Pulse(
                                                infinite: true,
                                                duration: const Duration(
                                                    milliseconds: 900),
                                                child: SizedBox(
                                                  width: 18.w,
                                                  height: 18.w,
                                                  child:
                                                      CircularProgressIndicator(
                                                    strokeWidth: 2.2,
                                                    color: accent,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                  SizedBox(height: 24.h),
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
                  right: 16.w,
                  bottom: 20.h,
                  child: AnimatedScale(
                    scale: _showScrollTop ? 1 : 0,
                    duration: const Duration(milliseconds: 180),
                    child: AnimatedOpacity(
                      opacity: _showScrollTop ? 1 : 0,
                      duration: const Duration(milliseconds: 180),
                      child: Material(
                        color: accent,
                        elevation: 4,
                        shadowColor: accent.withOpacity(0.35),
                        shape: const CircleBorder(),
                        child: InkWell(
                          customBorder: const CircleBorder(),
                          onTap: () {
                            animateToTopOfScreen(_cubit.scrollController!);
                          },
                          child: SizedBox(
                            width: 42.w,
                            height: 42.w,
                            child: Icon(
                              Icons.keyboard_arrow_up_rounded,
                              color: Colors.white,
                              size: 22.sp,
                            ),
                          ),
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

class _NotificationHeader extends StatelessWidget {
  final bool isDark;
  final Color canvas;
  final Color accent;
  final Color ink;
  final Color muted;
  final VoidCallback onBack;
  final Widget unreadBadge;

  const _NotificationHeader({
    required this.isDark,
    required this.canvas,
    required this.accent,
    required this.ink,
    required this.muted,
    required this.onBack,
    required this.unreadBadge,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isDark
              ? [
                  const Color(0xFF4A2F7A),
                  const Color(0xFF2B1A52),
                  canvas,
                ]
              : [
                  accent.withOpacity(0.28),
                  accent.withOpacity(0.14),
                  canvas,
                ],
          stops: const [0.0, 0.55, 1.0],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(14.w, 4.h, 14.w, 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Material(
                    color: isDark ? const Color(0xFF2A2733) : Colors.white,
                    shape: const CircleBorder(),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: onBack,
                      child: Container(
                        width: 36.w,
                        height: 36.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isDark
                                ? const Color(0xFF3A3645)
                                : const Color(0xFFE6E2F0),
                          ),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 16.sp,
                          color:
                              isDark ? Colors.white : const Color(0xFF1F2937),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.tr(AppStrings.inboxUpper),
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.3,
                            color: accent,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          context.tr(AppStrings.notification),
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.3,
                            color: isDark ? Colors.white : ink,
                          ),
                        ),
                      ],
                    ),
                  ),
                  unreadBadge,
                ],
              ),
              SizedBox(height: 8.h),
              Text(
                context.tr(AppStrings.stayOnTopOfActivity),
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.white60 : muted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final Color muted;
  final Color line;

  const _SectionHeader({
    required this.title,
    required this.muted,
    required this.line,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
            color: muted,
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Container(height: 1, color: line),
        ),
      ],
    );
  }
}

class _EmptyNotifications extends StatelessWidget {
  final bool isDark;
  final Color ink;
  final Color muted;
  final Color accent;
  final Color sheet;
  final Color line;

  const _EmptyNotifications({
    required this.isDark,
    required this.ink,
    required this.muted,
    required this.accent,
    required this.sheet,
    required this.line,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 28.h),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 36.h),
      decoration: BoxDecoration(
        color: sheet,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: line),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 14,
                  offset: const Offset(0, 5),
                ),
              ],
      ),
      child: Column(
        children: [
          Container(
            width: 64.w,
            height: 64.w,
            decoration: BoxDecoration(
              color: accent.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.notifications_none_rounded,
              size: 30.sp,
              color: accent,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            context.tr(AppStrings.youreAllCaughtUp),
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w800,
              color: ink,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            context.tr(AppStrings.newActivityWillShowHere),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: muted,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
