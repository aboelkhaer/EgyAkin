import 'package:egy_akin/features/all_groups_in_community/presentation/cubit/groups_invitations_cubit/groups_invitations_cubit.dart';
import 'package:egy_akin/features/all_groups_in_community/presentation/cubit/groups_invitations_cubit/groups_invitations_state.dart';

import '../../../../exports.dart';

class GroupsInvitationScreen extends StatefulWidget {
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;
  const GroupsInvitationScreen(
      {super.key,
      required this.currentDoctorModel,
      required this.homeDataModel});

  @override
  State<GroupsInvitationScreen> createState() => _GroupsInvitationScreenState();
}

class _GroupsInvitationScreenState extends State<GroupsInvitationScreen> {
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

  @override
  Widget build(BuildContext context) {
    GroupsInvitationsCubit cubit = GroupsInvitationsCubit.get(context);
    return RefreshIndicator(
      onRefresh: () {
        return cubit
            .getGroupsInvitations(widget.currentDoctorModel.id.toString());
      },
      child: BlocBuilder<GroupsInvitationsCubit, GroupsInvitationsState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return const SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: 10,
                    top: 20,
                  ),
                  child: LoadingForGroupRow(
                    count: 20,
                  ),
                ),
              );
            },
            loaded: (
              response,
              snackBarMessage,
              dialogMessage,
              isSeeMore,
              isAcceptLoading,
              isDeclineLoading,
            ) {
              if (response.data!.data!.isEmpty) {
                return SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 150.h,
                        ),
                        Image.asset(
                          AppImages.notFound,
                          width: 200,
                          height: 200,
                        ),
                        SizedBox(
                          height: 150.h,
                        ),
                      ],
                    ),
                  ),
                );
              }

              return ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                // controller: cubit.scrollControllerForMyGroups,
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                  bottom: 10,
                ),
                children: [
                  ...response.data!.data!.map(
                    (groupModel) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: GroupRow(
                        currentDoctorModel: widget.currentDoctorModel,
                        homeDataModel: widget.homeDataModel,
                        groupModel: groupModel,
                        groupPosition: GroupPosition.myGroups,
                        actionIcons: groupModel.userStatus ==
                                GroupInviteStatus.invited.name
                            ? Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isDeclineLoading &&
                                          groupModel.id.toString() ==
                                              cubit
                                                  .groupIdForAcceptOrDeclineMember
                                      ? IconButton(
                                          onPressed: () {},
                                          icon: const SizedBox(
                                            width: 15,
                                            height: 15,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                            ),
                                          ),
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                        )
                                      : IconButton(
                                          onPressed: () {
                                            cubit.acceptOrDeclineMemberInGroup(
                                              groupId: groupModel.id.toString(),
                                              invitationId:
                                                  groupModel.invitationId ?? 0,
                                              status:
                                                  AcceptOrDeclineMemberInGroup
                                                      .declined.name,
                                            );
                                          },
                                          icon: Icon(
                                            Icons.clear,
                                            color: Colors.red.shade700,
                                          ),
                                        ),
                                  isAcceptLoading &&
                                          groupModel.id.toString() ==
                                              cubit
                                                  .groupIdForAcceptOrDeclineMember
                                      ? IconButton(
                                          onPressed: () {},
                                          icon: const SizedBox(
                                            width: 15,
                                            height: 15,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                            ),
                                          ),
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                        )
                                      : IconButton(
                                          onPressed: () {
                                            cubit.acceptOrDeclineMemberInGroup(
                                              groupId: groupModel.id.toString(),
                                              invitationId:
                                                  groupModel.invitationId ?? 0,
                                              status:
                                                  AcceptOrDeclineMemberInGroup
                                                      .accepted.name,
                                            );
                                          },
                                          icon: Icon(Icons.check,
                                              color: Colors.green.shade700),
                                        ),
                                ],
                              )
                            : TextButton(
                                onPressed: groupModel.userStatus ==
                                            GroupInviteStatus.invited.name ||
                                        groupModel.userStatus ==
                                            GroupInviteStatus.joined.name ||
                                        groupModel.userStatus ==
                                            GroupInviteStatus.accepted.name ||
                                        (groupModel.userStatus ==
                                            GroupInviteStatus.pending.name)
                                    ? null // Disable the button if the user is already invited or joined
                                    : () {
                                        cubit.joinGroup(
                                            groupModel.id.toString());
                                      },
                                style: TextButton.styleFrom(
                                  foregroundColor:
                                      AppColors.primary, // Text and icon color
                                  disabledForegroundColor: Colors
                                      .grey, // Color when the button is disabled
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.group_add,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      (groupModel.userStatus ==
                                                      GroupInviteStatus
                                                          .invited.name &&
                                                  groupModel.privacy ==
                                                      GroupStatus
                                                          .private.name) ||
                                              (groupModel.userStatus ==
                                                  GroupInviteStatus
                                                      .pending.name)
                                          ? 'Pending'
                                          : groupModel.userStatus ==
                                                      GroupInviteStatus
                                                          .accepted.name ||
                                                  groupModel.userStatus ==
                                                      GroupInviteStatus
                                                          .joined.name ||
                                                  groupModel.userStatus ==
                                                      GroupInviteStatus
                                                          .invited.name
                                              ? 'Joined'
                                              : 'Join',
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ),
                  ),
                  // if (isSeeMore)
                  //   Padding(
                  //     padding: EdgeInsets.only(bottom: 20.h),
                  //     child: const Center(
                  //       child: SizedBox(
                  //         height: 15,
                  //         width: 15,
                  //         child: CircularProgressIndicator(
                  //           strokeWidth: 3,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
