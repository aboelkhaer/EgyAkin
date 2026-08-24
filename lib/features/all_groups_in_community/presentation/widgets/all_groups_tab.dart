import 'package:egy_akin/features/all_groups_in_community/presentation/cubit/all_groups_in_community_state.dart';
import 'package:egy_akin/features/all_groups_in_community/presentation/widgets/groups_list_card.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';
import '../../../../exports.dart';

class AllGroupsTab extends StatefulWidget {
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;
  const AllGroupsTab({
    super.key,
    required this.currentDoctorModel,
    required this.homeDataModel,
  });

  @override
  State<AllGroupsTab> createState() => _AllGroupsTabState();
}

class _AllGroupsTabState extends State<AllGroupsTab> {
  static const _accents = <Color>[
    Color(0xFF22C55E),
    Color(0xFFF59E0B),
    Color(0xFF8B5CF6),
    Color(0xFF3B82F6),
    Color(0xFFEF4444),
    Color(0xFF14B8A6),
  ];

  @override
  void initState() {
    if (context.read<AllGroupsInCommunityCubit>().callAllGroups == 0) {
      context.read<AllGroupsInCommunityCubit>().getAllGroups();
      context.read<AllGroupsInCommunityCubit>().callAllGroups++;
    }
    super.initState();
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

  bool _canJoin(GroupModel group) {
    final status = group.userStatus;
    return status != GroupInviteStatus.invited.name &&
        status != GroupInviteStatus.joined.name &&
        status != GroupInviteStatus.accepted.name &&
        status != GroupInviteStatus.pending.name;
  }

  @override
  Widget build(BuildContext context) {
    final cubit = AllGroupsInCommunityCubit.get(context);
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final primary = HomeDashboardColors.primary(isDark);

        return RefreshIndicator(
          color: primary,
          onRefresh: () => cubit.getAllGroups(),
          child: BlocBuilder<AllGroupsInCommunityCubit,
              AllGroupsInCommunityState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () => GroupsListLoading(isDark: isDark),
                loaded: (
                  response,
                  snackBarMessage,
                  dialogMessage,
                  isSeeMore,
                ) {
                  final groups = response.data?.data ?? [];
                  if (groups.isEmpty) {
                    return ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        SizedBox(height: 80.h),
                        DashboardEmptyState(
                          isDark: isDark,
                          icon: Icons.travel_explore_rounded,
                          title: context.tr(AppStrings.noGroupsFound),
                          subtitle: context.tr(
                            AppStrings.whenNewGroupsCreatedShowHere,
                          ),
                          hint: context.tr(AppStrings.pullToRefresh),
                          hintIcon: Icons.sync_rounded,
                        ),
                      ],
                    );
                  }
                  return ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    controller: cubit.scrollControllerForAllGroups,
                    padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
                    itemCount: groups.length + (isSeeMore ? 1 : 0),
                    separatorBuilder: (_, __) => SizedBox(height: 10.h),
                    itemBuilder: (context, index) {
                      if (index >= groups.length) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 12.h, top: 4.h),
                          child: Center(
                            child: SizedBox(
                              height: 18,
                              width: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.4,
                                color: primary,
                              ),
                            ),
                          ),
                        );
                      }
                      final group = groups[index];
                      return FadeInUp(
                        from: 10,
                        duration: const Duration(milliseconds: 380),
                        delay: Duration(
                          milliseconds: (index.clamp(0, 8) * 40),
                        ),
                        child: GroupsListCard(
                          group: group,
                          isDark: isDark,
                          primary: primary,
                          accent: _accents[
                              (group.id ?? 0).abs() % _accents.length],
                          onTap: () => _openGroup(group),
                          trailing: GroupsJoinChip(
                            isDark: isDark,
                            primary: primary,
                            label: translateGroupStatus(
                              group.userStatus.toString(),
                              context,
                            ),
                            enabled: _canJoin(group),
                            onTap: () => cubit.joinGroup(group.id.toString()),
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
