import 'package:egy_akin/features/all_groups_in_community/presentation/cubit/groups_invitations_cubit/groups_invitations_state.dart';
import 'package:egy_akin/features/all_groups_in_community/presentation/widgets/groups_list_card.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';

import '../../../../exports.dart';

class GroupsInvitationScreen extends StatefulWidget {
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;
  const GroupsInvitationScreen({
    super.key,
    required this.currentDoctorModel,
    required this.homeDataModel,
  });

  @override
  State<GroupsInvitationScreen> createState() => _GroupsInvitationScreenState();
}

class _GroupsInvitationScreenState extends State<GroupsInvitationScreen> {
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
    if (context.read<GroupsInvitationsCubit>().callGroupsInvitations == 0) {
      context.read<GroupsInvitationsCubit>().getGroupsInvitations(
            widget.currentDoctorModel.id.toString(),
          );
      context.read<GroupsInvitationsCubit>().callGroupsInvitations++;
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

  Widget _inviteActions({
    required GroupModel group,
    required GroupsInvitationsCubit cubit,
    required bool isDark,
    required Color primary,
    required bool isAcceptLoading,
    required bool isDeclineLoading,
  }) {
    final invited = group.userStatus == GroupInviteStatus.invited.name;
    final isThisGroup =
        group.id.toString() == cubit.groupIdForAcceptOrDeclineMember;

    if (invited) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _CircleAction(
            isDark: isDark,
            loading: isDeclineLoading && isThisGroup,
            icon: Icons.close_rounded,
            color: HomeDashboardColors.danger,
            onTap: () {
              cubit.acceptOrDeclineMemberInGroup(
                groupId: group.id.toString(),
                invitationId: group.invitationId ?? 0,
                status: AcceptOrDeclineMemberInGroup.declined.name,
              );
            },
          ),
          SizedBox(width: 6.w),
          _CircleAction(
            isDark: isDark,
            loading: isAcceptLoading && isThisGroup,
            icon: Icons.check_rounded,
            color: HomeDashboardColors.success,
            onTap: () {
              cubit.acceptOrDeclineMemberInGroup(
                groupId: group.id.toString(),
                invitationId: group.invitationId ?? 0,
                status: AcceptOrDeclineMemberInGroup.accepted.name,
              );
            },
          ),
        ],
      );
    }

    return GroupsJoinChip(
      isDark: isDark,
      primary: primary,
      label: translateGroupStatus(group.userStatus.toString(), context),
      enabled: _canJoin(group),
      onTap: () => cubit.joinGroup(group.id.toString()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = GroupsInvitationsCubit.get(context);
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final primary = HomeDashboardColors.primary(isDark);

        return RefreshIndicator(
          color: primary,
          onRefresh: () => cubit
              .getGroupsInvitations(widget.currentDoctorModel.id.toString()),
          child: BlocBuilder<GroupsInvitationsCubit, GroupsInvitationsState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () => GroupsListLoading(isDark: isDark),
                loaded: (
                  response,
                  snackBarMessage,
                  dialogMessage,
                  isSeeMore,
                  isAcceptLoading,
                  isDeclineLoading,
                ) {
                  final groups = response.data?.data ?? [];
                  if (groups.isEmpty) {
                    return ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        SizedBox(height: 80.h),
                        DashboardEmptyState(
                          isDark: isDark,
                          icon: Icons.mail_outline_rounded,
                          title: context.tr(AppStrings.noInvitations),
                          subtitle: context.tr(
                              AppStrings.whenSomeoneInvitesYouToGroup),
                          hint: context.tr(AppStrings.pullToRefresh),
                          hintIcon: Icons.sync_rounded,
                        ),
                      ],
                    );
                  }

                  return ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
                    itemCount: groups.length,
                    separatorBuilder: (_, __) => SizedBox(height: 10.h),
                    itemBuilder: (context, index) {
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
                          trailing: _inviteActions(
                            group: group,
                            cubit: cubit,
                            isDark: isDark,
                            primary: primary,
                            isAcceptLoading: isAcceptLoading,
                            isDeclineLoading: isDeclineLoading,
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

class _CircleAction extends StatelessWidget {
  final bool isDark;
  final bool loading;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _CircleAction({
    required this.isDark,
    required this.loading,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color.withOpacity(isDark ? 0.18 : 0.12),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: loading ? null : onTap,
        child: SizedBox(
          width: 34.r,
          height: 34.r,
          child: loading
              ? Padding(
                  padding: EdgeInsets.all(8.r),
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: color,
                  ),
                )
              : Icon(icon, size: 16.sp, color: color),
        ),
      ),
    );
  }
}
