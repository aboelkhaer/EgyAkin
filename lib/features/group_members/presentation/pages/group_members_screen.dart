import 'package:egy_akin/features/group_members/presentation/cubit/group_members_cubit.dart';
import 'package:egy_akin/features/group_members/presentation/cubit/group_members_state.dart';

import '../../../../exports.dart';

class GroupMembersScreen extends StatefulWidget {
  final String groupId;
  final String postId;
  final String ownerId;
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;
  final bool isPostLikes;
  const GroupMembersScreen({
    super.key,
    required this.groupId,
    required this.currentDoctorModel,
    required this.homeDataModel,
    required this.postId,
    this.isPostLikes = false,
    required this.ownerId,
  });

  @override
  State<GroupMembersScreen> createState() => _GroupMembersScreenState();
}

class _GroupMembersScreenState extends State<GroupMembersScreen> {
  GroupMembersCubit? _cubit;

  @override
  void initState() {
    super.initState();
    if (widget.isPostLikes) {
      context.read<GroupMembersCubit>().getPostLikes(widget.postId);
    } else {
      context.read<GroupMembersCubit>().getGroupMembers(widget.groupId);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cubit = context.read<GroupMembersCubit>();
      if (!_cubit!.isClosed) {
        _cubit!.scrollController = ScrollController();
        _cubit!.scrollController!.addListener(_onScroll);
      }
    });
  }

  @override
  void dispose() {
    if (_cubit != null && !_cubit!.isClosed) {
      _cubit!.scrollController!.dispose();
    }
    super.dispose();
  }

  void _onScroll() {
    if (context.read<GroupMembersCubit>().isLastPage) {
      return;
    } else {
      final maxScroll = context
          .read<GroupMembersCubit>()
          .scrollController!
          .position
          .maxScrollExtent;
      final currentScroll =
          context.read<GroupMembersCubit>().scrollController!.position.pixels;
      const threshold = 200.0;
      if (context.read<GroupMembersCubit>().isLoadingMoreForScroll == false &&
          maxScroll - currentScroll <= threshold) {
        context.read<GroupMembersCubit>().isLoadingMoreForScroll = true;

        if (widget.isPostLikes) {
          // context.read<GroupMembersCubit>().loadMorePostLikes(widget.postId);
        } else {
          context.read<GroupMembersCubit>().loadMoreMembers(widget.groupId);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final GroupMembersCubit cubit = GroupMembersCubit.get(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 5.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 5.h,
                width: 60.w,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            ],
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
            child: Row(
              children: [
                Text(
                  widget.isPostLikes ? context.tr(AppStrings.postLikes) : context.tr(AppStrings.groupMembers),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                    color: Colors.grey.shade800,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<GroupMembersCubit, GroupMembersState>(
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () =>
                      const Center(child: CircularProgressIndicator()),
                  loaded: (
                    snackBarMessage,
                    dialogMessage,
                    response,
                    isSeeMore,
                    isRemoveMemberFromGroupLoading,
                    isRemoveMemberFromGroupLoaded,
                    isAcceptLoading,
                    isDeclineLoading,
                    postLikesResponse,
                  ) {
                    if (widget.isPostLikes) {
                      // Handle post likes case
                      if (postLikesResponse.data!.data!.isEmpty) {
                        return Center(
                          child: Image.asset(
                            AppImages.notFound,
                            width: 100.h,
                            height: 150.h,
                          ),
                        );
                      }

                      return ListView.builder(
                        controller: cubit.scrollController,
                        itemCount: postLikesResponse.data!.data!.length,
                        itemBuilder: (context, index) {
                          DoctorModel doctorModel =
                              postLikesResponse.data!.data![index];
                          return _buildPostLikeMemberCard(
                            context,
                            doctorModel,
                            cubit,
                          );
                        },
                      );
                    } else {
                      // Handle group members case
                      if (response.data!.pendingInvitations!.isEmpty &&
                          response.data!.members!.data!.isEmpty) {
                        return Center(
                          child: Image.asset(
                            AppImages.notFound,
                            width: 100.h,
                            height: 150.h,
                          ),
                        );
                      }

                      return ListView(
                        controller: cubit.scrollController,
                        children: [
                          // Pending Invitations List
                          if (response.data!.pendingInvitations!.isNotEmpty)
                            ...response.data!.pendingInvitations!
                                .map((doctorModel) {
                              return Column(
                                children: [
                                  _buildMemberCard(
                                    context,
                                    doctorModel,
                                    cubit,
                                    isRemoveMemberFromGroupLoading:
                                        isRemoveMemberFromGroupLoading,
                                    isPending: true,
                                    isAcceptLoading: isAcceptLoading,
                                    isDeclineLoading: isDeclineLoading,
                                  ),
                                ],
                              );
                            }),
                          response.data!.pendingInvitations!.isEmpty
                              ? const SizedBox.shrink()
                              : Column(
                                  children: [
                                    const Divider(
                                      color: AppColors.primary,
                                      thickness: 0.5,
                                    ),
                                    SizedBox(height: 10.h),
                                  ],
                                ),

                          // Members List
                          if (response.data!.members!.data!.isNotEmpty)
                            ...response.data!.members!.data!.map((doctorModel) {
                              return _buildMemberCard(
                                context,
                                doctorModel,
                                cubit,
                                isRemoveMemberFromGroupLoading:
                                    isRemoveMemberFromGroupLoading,
                                isPending: false,
                                isAcceptLoading: isAcceptLoading,
                                isDeclineLoading: isDeclineLoading,
                              );
                            }),

                          // Loading indicator for "See More"
                          if (isSeeMore)
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: Center(
                                child: SizedBox(
                                  height: 15,
                                  width: 15,
                                  child:
                                      CircularProgressIndicator(strokeWidth: 3),
                                ),
                              ),
                            ),
                        ],
                      );
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostLikeMemberCard(
    BuildContext context,
    DoctorModel doctorModel,
    GroupMembersCubit cubit,
  ) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 8),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          splashColor: AppColors.subBG,
          onTap: () {
            navigatorKey.currentState?.pushNamed(
              AppRoutes.doctorInfoView,
              arguments: AppRoutesArgs.doctorInfoViewRouteArgs(
                doctorId: doctorModel.id.toString(),
                currentDoctorModel: widget.currentDoctorModel,
                isSyndicateCardRequired:
                    widget.homeDataModel.isSyndicateCardRequired.toString(),
                initialIndex: 0,
                accountVerification: widget.homeDataModel.verified!,
                currentDoctorRole: widget.homeDataModel.role.toString(),
                currentDoctorPoints:
                    int.parse(widget.homeDataModel.scoreValue!),
                homeDataModel: widget.homeDataModel,
                isNavigateToTheButtonOfInformationTab: false,
              ),
            );
          },
          child: Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: Row(
              children: [
                // Avatar and Name Section
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              spreadRadius: 2,
                              blurRadius: 9,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(80.r),
                          child: GestureDetector(
                            onTap: () {
                              navigatorKey.currentState?.pushNamed(
                                AppRoutes.doctorInfoView,
                                arguments:
                                    AppRoutesArgs.doctorInfoViewRouteArgs(
                                  doctorId: doctorModel.id.toString(),
                                  initialIndex: 0,
                                  currentDoctorModel: widget.currentDoctorModel,
                                  isSyndicateCardRequired: widget
                                      .homeDataModel.isSyndicateCardRequired!,
                                  homeDataModel: widget.homeDataModel,
                                  accountVerification:
                                      widget.homeDataModel.verified ?? true,
                                  currentDoctorRole: widget.homeDataModel.role!,
                                  isNavigateToTheButtonOfInformationTab: false,
                                  currentDoctorPoints: int.parse(
                                      widget.homeDataModel.scoreValue!),
                                ),
                              );
                            },
                            child: CircleAvatar(
                              radius: 20.r,
                              backgroundColor:
                                  AppColors.primary.withOpacity(0.8),
                              child: doctorModel.image == null
                                  ? Text(
                                      doctorModel.firstName![0].toUpperCase(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.sp,
                                      ),
                                    )
                                  : CustomCachedNetworkImage(
                                      imageUrl: doctorModel.image.toString(),
                                      height: 100.h,
                                      width: 100.w,
                                    ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    doctorName(
                                      firstName: doctorModel.firstName,
                                      lastName: doctorModel.lastName,
                                      role: doctorModel.isSyndicateCardRequired
                                          .toString(),
                                    ),
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                                doctorModel.isSyndicateCardRequired
                                            .toString() ==
                                        'Verified'
                                    ? const VerificationIcon()
                                    : const SizedBox.shrink(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMemberCard(
    BuildContext context,
    DoctorModel doctorModel,
    GroupMembersCubit cubit, {
    required bool isRemoveMemberFromGroupLoading,
    required bool isPending,
    required bool isAcceptLoading,
    required bool isDeclineLoading,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 8),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          splashColor: AppColors.subBG,
          onTap: () {
            navigatorKey.currentState?.pushNamed(
              AppRoutes.doctorInfoView,
              arguments: AppRoutesArgs.doctorInfoViewRouteArgs(
                doctorId: doctorModel.id.toString(),
                currentDoctorModel: widget.currentDoctorModel,
                isSyndicateCardRequired:
                    widget.homeDataModel.isSyndicateCardRequired.toString(),
                initialIndex: 0,
                accountVerification: widget.homeDataModel.verified!,
                currentDoctorRole: widget.homeDataModel.role.toString(),
                currentDoctorPoints:
                    int.parse(widget.homeDataModel.scoreValue!),
                homeDataModel: widget.homeDataModel,
                isNavigateToTheButtonOfInformationTab: false,
              ),
            );
          },
          child: Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: Row(
              children: [
                // Avatar and Name Section - Now wrapped in Expanded to prevent overflow
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              spreadRadius: 2,
                              blurRadius: 9,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(80.r),
                          child: GestureDetector(
                            onTap: () {
                              navigatorKey.currentState?.pushNamed(
                                AppRoutes.doctorInfoView,
                                arguments:
                                    AppRoutesArgs.doctorInfoViewRouteArgs(
                                  doctorId: doctorModel.id.toString(),
                                  initialIndex: 0,
                                  currentDoctorModel: widget.currentDoctorModel,
                                  isSyndicateCardRequired: widget
                                      .homeDataModel.isSyndicateCardRequired!,
                                  homeDataModel: widget.homeDataModel,
                                  accountVerification:
                                      widget.homeDataModel.verified ?? true,
                                  currentDoctorRole: widget.homeDataModel.role!,
                                  isNavigateToTheButtonOfInformationTab: false,
                                  currentDoctorPoints: int.parse(
                                      widget.homeDataModel.scoreValue!),
                                ),
                              );
                            },
                            child: CircleAvatar(
                              radius: 20.r,
                              backgroundColor:
                                  AppColors.primary.withOpacity(0.8),
                              child: doctorModel.image == null
                                  ? Text(
                                      doctorModel.firstName![0].toUpperCase(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.sp,
                                      ),
                                    )
                                  : CustomCachedNetworkImage(
                                      imageUrl: doctorModel.image.toString(),
                                      height: 100.h,
                                      width: 100.w,
                                    ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        // Added this Expanded to contain the text
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  // Added Flexible to prevent overflow
                                  child: Text(
                                    doctorName(
                                      firstName: doctorModel.firstName,
                                      lastName: doctorModel.lastName,
                                      role: doctorModel.isSyndicateCardRequired
                                          .toString(),
                                    ),
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                                doctorModel.isSyndicateCardRequired
                                            .toString() ==
                                        'Verified'
                                    ? const VerificationIcon()
                                    : const SizedBox.shrink(),
                              ],
                            ),
                            Text(
                              doctorModel.id.toString() == widget.ownerId
                                  ? context.tr(AppStrings.adminOfGroup)
                                  : isPending
                                      ? context.tr(AppStrings.pending)
                                      : context.tr(AppStrings.memberOfGroup),
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Action Buttons - Now properly aligned to end
                if (isPending)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      isDeclineLoading &&
                              doctorModel.id.toString() ==
                                  cubit.doctorIdForAcceptOrDeclineMember
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
                                  groupId: widget.groupId,
                                  invitationId: doctorModel.invitationId ?? 0,
                                  status: AcceptOrDeclineMemberInGroup
                                      .declined.name,
                                  doctorId: doctorModel.id.toString(),
                                );
                              },
                              icon: Icon(
                                Icons.clear,
                                color: Colors.red.shade700,
                              ),
                            ),
                      isAcceptLoading &&
                              doctorModel.id.toString() ==
                                  cubit.doctorIdForAcceptOrDeclineMember
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
                                  groupId: widget.groupId,
                                  invitationId: doctorModel.invitationId ?? 0,
                                  status: AcceptOrDeclineMemberInGroup
                                      .accepted.name,
                                  doctorId: doctorModel.id.toString(),
                                );
                              },
                              icon: Icon(Icons.check,
                                  color: Colors.green.shade700),
                            ),
                    ],
                  ),

                // Remove member button (for non-pending members)
                if (!isPending &&
                    (widget.homeDataModel.role == AppStrings.roleAdmin ||
                        widget.currentDoctorModel.id.toString() ==
                            widget.ownerId) &&
                    doctorModel.id.toString() !=
                        widget.currentDoctorModel.id.toString() &&
                    doctorModel.id.toString() != widget.ownerId)
                  isRemoveMemberFromGroupLoading &&
                          cubit.doctorIdForLoading == doctorModel.id.toString()
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
                            cubit.doctorIdForLoading =
                                doctorModel.id.toString();
                            cubit.removeMemberFromGroup(
                              widget.groupId,
                              doctorModel.id.toString(),
                            );
                          },
                          icon: Icon(Icons.clear, color: Colors.red.shade700),
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                        ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
