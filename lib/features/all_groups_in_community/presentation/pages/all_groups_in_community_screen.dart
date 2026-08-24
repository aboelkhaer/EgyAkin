import 'package:egy_akin/features/all_groups_in_community/presentation/widgets/all_groups_tab.dart';
import 'package:egy_akin/features/all_groups_in_community/presentation/widgets/groups_invitation_screen.dart';
import 'package:egy_akin/features/all_groups_in_community/presentation/widgets/my_groups_tab.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';

import '../../../../exports.dart';

class AllGroupsInCommunityScreen extends StatefulWidget {
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;
  final int initialTab;
  const AllGroupsInCommunityScreen({
    super.key,
    required this.currentDoctorModel,
    required this.homeDataModel,
    this.initialTab = 0,
  });

  @override
  State<AllGroupsInCommunityScreen> createState() =>
      _AllGroupsInCommunityScreenState();
}

class _AllGroupsInCommunityScreenState extends State<AllGroupsInCommunityScreen>
    with TickerProviderStateMixin {
  MyGroupsInCommunityCubit? _myGroupsCubit;
  AllGroupsInCommunityCubit? _allGroupsCubit;
  late final AnimationController _intro;
  late final Animation<double> _headerFade;
  late final Animation<Offset> _headerSlide;

  @override
  void initState() {
    super.initState();
    _intro = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 640),
    );
    _headerFade = CurvedAnimation(
      parent: _intro,
      curve: const Interval(0.0, 0.55, curve: Curves.easeOut),
    );
    _headerSlide = Tween<Offset>(
      begin: const Offset(0, -0.08),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _intro,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOutCubic),
      ),
    );
    _intro.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _myGroupsCubit = context.read<MyGroupsInCommunityCubit>();
      _allGroupsCubit = context.read<AllGroupsInCommunityCubit>();
      if (!_myGroupsCubit!.isClosed) {
        _myGroupsCubit!.scrollControllerForMyGroups = ScrollController();
        _myGroupsCubit!.scrollControllerForMyGroups!
            .addListener(_onScrollForMyGroups);
      }
      if (!_allGroupsCubit!.isClosed) {
        _allGroupsCubit!.scrollControllerForAllGroups = ScrollController();
        _allGroupsCubit!.scrollControllerForAllGroups!
            .addListener(_onScrollForAllGroups);
      }
    });
  }

  @override
  void dispose() {
    _intro.dispose();
    if (_myGroupsCubit != null && !_myGroupsCubit!.isClosed) {
      _myGroupsCubit!.scrollControllerForMyGroups!.dispose();
    }
    if (_allGroupsCubit != null && !_allGroupsCubit!.isClosed) {
      _allGroupsCubit!.scrollControllerForAllGroups!.dispose();
    }
    super.dispose();
  }

  void _onScrollForMyGroups() {
    if (context.read<MyGroupsInCommunityCubit>().isLastPageForMyGroups) {
      return;
    } else {
      final maxScroll = context
          .read<MyGroupsInCommunityCubit>()
          .scrollControllerForMyGroups!
          .position
          .maxScrollExtent;
      final currentScroll = context
          .read<MyGroupsInCommunityCubit>()
          .scrollControllerForMyGroups!
          .position
          .pixels;
      const threshold = 200.0;
      if (context
                  .read<MyGroupsInCommunityCubit>()
                  .isLoadingMoreForScrollForMyGroups ==
              false &&
          maxScroll - currentScroll <= threshold) {
        context
            .read<MyGroupsInCommunityCubit>()
            .isLoadingMoreForScrollForMyGroups = true;

        context.read<MyGroupsInCommunityCubit>().loadMoreGroups();
      }
    }
  }

  void _onScrollForAllGroups() {
    if (context.read<AllGroupsInCommunityCubit>().isLastPageForAllGroups) {
      return;
    } else {
      final maxScroll = context
          .read<AllGroupsInCommunityCubit>()
          .scrollControllerForAllGroups!
          .position
          .maxScrollExtent;
      final currentScroll = context
          .read<AllGroupsInCommunityCubit>()
          .scrollControllerForAllGroups!
          .position
          .pixels;
      const threshold = 200.0;
      if (context
                  .read<AllGroupsInCommunityCubit>()
                  .isLoadingMoreForScrollForAllGroups ==
              false &&
          maxScroll - currentScroll <= threshold) {
        context
            .read<AllGroupsInCommunityCubit>()
            .isLoadingMoreForScrollForAllGroups = true;

        context.read<AllGroupsInCommunityCubit>().loadMoreGroups();
      }
    }
  }

  void _openCreateGroup() {
    navigatorKey.currentState?.pushNamed(
      AppRoutes.createGroupInCommunity,
      arguments: AppRoutesArgs.createGroupInCommunityRouteArgs(
        currentDoctorModel: widget.currentDoctorModel,
        homeDataModel: widget.homeDataModel,
        isCreateNewGroup: true,
        groupModel: null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final primary = HomeDashboardColors.primary(isDark);
        final scaffold = HomeDashboardColors.scaffold(isDark);
        final top = MediaQuery.paddingOf(context).top;

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness:
                isDark ? Brightness.light : Brightness.dark,
            statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
          ),
          child: Scaffold(
            backgroundColor: scaffold,
            body: DefaultTabController(
              length: 3,
              initialIndex: widget.initialTab.clamp(0, 2).toInt(),
              child: Column(
                children: [
                  FadeTransition(
                    opacity: _headerFade,
                    child: SlideTransition(
                      position: _headerSlide,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(8.w, top + 6.h, 12.w, 8.h),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(
                                Icons.arrow_back_ios_new_rounded,
                                size: 18.sp,
                                color: HomeDashboardColors.title(isDark),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                context.tr(AppStrings.groups),
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: -0.4,
                                  color: HomeDashboardColors.title(isDark),
                                ),
                              ),
                            ),
                            Hero(
                              tag: 'add_icon',
                              child: Material(
                                color: primary,
                                shape: const CircleBorder(),
                                child: InkWell(
                                  customBorder: const CircleBorder(),
                                  onTap: _openCreateGroup,
                                  child: SizedBox(
                                    width: 38.r,
                                    height: 38.r,
                                    child: Icon(
                                      Icons.add_rounded,
                                      size: 22.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  FadeIn(
                    duration: const Duration(milliseconds: 420),
                    delay: const Duration(milliseconds: 80),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: HomeDashboardColors.border(isDark)
                                .withOpacity(0.8),
                          ),
                        ),
                      ),
                      child: TabBar(
                        indicatorColor: primary,
                        indicatorWeight: 2.4,
                        indicatorSize: TabBarIndicatorSize.label,
                        labelColor: HomeDashboardColors.title(isDark),
                        unselectedLabelColor:
                            HomeDashboardColors.subtitle(isDark),
                        labelStyle: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        unselectedLabelStyle: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        dividerColor: Colors.transparent,
                        tabs: [
                          Tab(text: context.tr(AppStrings.myGroups)),
                          Tab(
                            text: context
                                .tr(AppStrings.groupInvitationsWithNewLine)
                                .replaceAll('\n', ' '),
                          ),
                          Tab(text: context.tr(AppStrings.allGroups)),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: FadeInUp(
                      from: 12,
                      duration: const Duration(milliseconds: 480),
                      delay: const Duration(milliseconds: 90),
                      child: TabBarView(
                        children: [
                          MyGroupsTab(
                            currentDoctorModel: widget.currentDoctorModel,
                            homeDataModel: widget.homeDataModel,
                          ),
                          GroupsInvitationScreen(
                            currentDoctorModel: widget.currentDoctorModel,
                            homeDataModel: widget.homeDataModel,
                          ),
                          AllGroupsTab(
                            currentDoctorModel: widget.currentDoctorModel,
                            homeDataModel: widget.homeDataModel,
                          ),
                        ],
                      ),
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
