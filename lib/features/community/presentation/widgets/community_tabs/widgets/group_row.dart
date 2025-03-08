import 'package:egy_akin/features/all_groups_in_community/presentation/cubit/all_groups_in_community_cubit.dart';
import 'package:egy_akin/features/all_groups_in_community/presentation/cubit/cubit/my_groups_in_community_cubit.dart';
import 'package:egy_akin/features/community/data/models/get_groups_tab_model_response.dart';
import 'package:egy_akin/features/community/presentation/cubit/groups_cubit/groups_cubit.dart';
import 'package:egy_akin/features/community/presentation/cubit/groups_cubit/groups_state.dart';

import '../../../../../../exports.dart';

class GroupRow extends StatelessWidget {
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;
  final GroupPosition groupPosition;

  final GroupModel groupModel;

  const GroupRow({
    super.key,
    required this.currentDoctorModel,
    required this.homeDataModel,
    required this.groupModel,
    required this.groupPosition,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              onTap: () {
                navigatorKey.currentState?.pushNamed(
                  AppRoutes.groupDetailsInCommunity,
                  arguments: AppRoutesArgs.groupDetailsInCommunityRouteArgs(
                    currentDoctorModel: currentDoctorModel,
                    homeDataModel: homeDataModel,
                    groupId: groupModel.id.toString(),
                  ),
                );
              },
              child: Row(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(80.r),
                      child: GestureDetector(
                        onTap: () {
                          // Handle user profile navigation here
                        },
                        child: CircleAvatar(
                          radius: 18.r,
                          backgroundColor: AppColors.primary.withOpacity(0.8),
                          child: CustomCachedNetworkImage(
                            imageUrl: groupModel.groupImage.toString(),
                            height: 100.h,
                            width: 100.w,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          groupModel.name.toString(),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${groupModel.memberCount} People joined community',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            BlocConsumer<GroupsCubit, GroupsState>(
              listener: (context, state) {
                state.maybeWhen(
                  orElse: () {},
                  initial: () {},
                );
              },
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () {
                    return TextButton(
                      onPressed: groupModel.userStatus ==
                                  GroupInviteStatus.invited.name ||
                              groupModel.userStatus ==
                                  GroupInviteStatus.joined.name ||
                              groupModel.userStatus ==
                                  GroupInviteStatus.accepted.name
                          ? null // Disable the button if the user is already invited or joined
                          : () {
                              switch (groupPosition) {
                                case GroupPosition.groupTab:
                                  context
                                      .read<GroupsCubit>()
                                      .joinGroup(groupModel.id.toString());
                                  break;
                                case GroupPosition.myGroups:
                                  context
                                      .read<MyGroupsInCommunityCubit>()
                                      .joinGroup(groupModel.id.toString());

                                  break;
                                case GroupPosition.allGroups:
                                  context
                                      .read<AllGroupsInCommunityCubit>()
                                      .joinGroup(groupModel.id.toString());
                                  break;

                                default:
                              }
                            },
                      style: TextButton.styleFrom(
                        foregroundColor:
                            AppColors.primary, // Text and icon color
                        disabledForegroundColor:
                            Colors.grey, // Color when the button is disabled
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.group_add,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            groupModel.userStatus ==
                                        GroupInviteStatus.invited.name &&
                                    groupModel.privacy ==
                                        GroupStatus.private.name
                                ? 'Pending'
                                : groupModel.userStatus ==
                                            GroupInviteStatus.accepted.name ||
                                        groupModel.userStatus ==
                                            GroupInviteStatus.joined.name ||
                                        groupModel.userStatus ==
                                            GroupInviteStatus.invited.name
                                    ? 'Joined'
                                    : 'Join',
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
