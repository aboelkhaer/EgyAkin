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
          // context.read<GroupMembersCubit>().loadMoreMembers(widget.groupId);
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
                  widget.isPostLikes ? 'Post Likes:' : 'Group Members:',
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
            child: BlocConsumer<GroupMembersCubit, GroupMembersState>(
              listener: (context, state) {},
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () {
                    return const Center(child: CircularProgressIndicator());
                  },
                  loaded: (
                    snackBarMessage,
                    dialogMessage,
                    response,
                    isSeeMore,
                    isRemoveMemberFromGroupLoading,
                    isRemoveMemberFromGroupLoaded,
                  ) {
                    return response.data!.data!.isEmpty
                        ? Center(
                            child: Image.asset(
                              AppImages.notFound,
                              width: 100.h,
                              height: 150.h,
                            ),
                          )
                        : ListView.builder(
                            itemCount: response.data!.data!.length,
                            controller: cubit.scrollController,
                            itemBuilder: (context, index) {
                              DoctorModel doctorModel =
                                  response.data!.data![index];
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, bottom: 8),
                                child: Card(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(10),
                                    splashColor: AppColors.subBG,
                                    onTap: () {
                                      navigatorKey.currentState?.pushNamed(
                                        AppRoutes.doctorInfoView,
                                        arguments: AppRoutesArgs
                                            .doctorInfoViewRouteArgs(
                                          doctorId: doctorModel.id.toString(),
                                          currentDoctorModel:
                                              widget.currentDoctorModel,
                                          isSyndicateCardRequired: widget
                                              .homeDataModel
                                              .isSyndicateCardRequired
                                              .toString(),
                                          initialIndex: 0,
                                          accountVerification:
                                              widget.homeDataModel.verified!,
                                          currentDoctorRole: widget
                                              .homeDataModel.role
                                              .toString(),
                                          currentDoctorPoints: int.parse(
                                              widget.homeDataModel.scoreValue!),
                                          homeDataModel: widget.homeDataModel,
                                          isNavigateToTheButtonOfInformationTab:
                                              false,
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                        top: 10,
                                        bottom: 10,
                                      ),
                                      child: Row(
                                        children: [
                                          Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.4),
                                                          spreadRadius: 2,
                                                          blurRadius: 9,
                                                          offset: const Offset(
                                                              0, 3),
                                                        ),
                                                      ],
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              80.r),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          navigatorKey
                                                              .currentState
                                                              ?.pushNamed(
                                                            AppRoutes
                                                                .doctorInfoView,
                                                            arguments: AppRoutesArgs
                                                                .doctorInfoViewRouteArgs(
                                                              doctorId:
                                                                  doctorModel.id
                                                                      .toString(),
                                                              initialIndex: 0,
                                                              currentDoctorModel:
                                                                  widget
                                                                      .currentDoctorModel,
                                                              isSyndicateCardRequired: widget
                                                                  .homeDataModel
                                                                  .isSyndicateCardRequired!,
                                                              homeDataModel: widget
                                                                  .homeDataModel,
                                                              accountVerification:
                                                                  widget.homeDataModel
                                                                          .verified ??
                                                                      true,
                                                              currentDoctorRole:
                                                                  widget
                                                                      .homeDataModel
                                                                      .role!,
                                                              isNavigateToTheButtonOfInformationTab:
                                                                  false,
                                                              currentDoctorPoints:
                                                                  int.parse(widget
                                                                      .homeDataModel
                                                                      .scoreValue!),
                                                            ),
                                                          );
                                                        },
                                                        child: CircleAvatar(
                                                          radius: 20.r,
                                                          backgroundColor:
                                                              AppColors
                                                                  .primary
                                                                  .withOpacity(
                                                                      0.8),
                                                          child: doctorModel
                                                                      .image ==
                                                                  null
                                                              ? Text(
                                                                  doctorModel
                                                                      .firstName![
                                                                          0]
                                                                      .toUpperCase(),
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          16.sp),
                                                                )
                                                              : CustomCachedNetworkImage(
                                                                  imageUrl:
                                                                      doctorModel
                                                                          .image
                                                                          .toString(),
                                                                  height: 100.h,
                                                                  width: 100.w,
                                                                ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 8.w),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            doctorName(
                                                              firstName:
                                                                  doctorModel
                                                                      .firstName,
                                                              lastName:
                                                                  doctorModel
                                                                      .lastName,
                                                              role: '',
                                                            ),
                                                            style: TextStyle(
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          doctorModel.isSyndicateCardRequired
                                                                      .toString() ==
                                                                  'Verified'
                                                              ? const VerificationIcon()
                                                              : const SizedBox
                                                                  .shrink()
                                                        ],
                                                      ),
                                                      // Row(
                                                      //   children: [
                                                      //     Text(
                                                      //       doctorModel.email ??
                                                      //           '',
                                                      //       style: TextStyle(
                                                      //         color: Colors.grey
                                                      //             .shade700,
                                                      //         fontSize: 10.sp,
                                                      //       ),
                                                      //     ),
                                                      //   ],
                                                      // ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          BlocBuilder<GroupMembersCubit,
                                              GroupMembersState>(
                                            builder: (context, state) {
                                              return state.maybeWhen(
                                                orElse: () {
                                                  return const SizedBox
                                                      .shrink();
                                                },
                                                loaded: (
                                                  snackBarMessage,
                                                  dialogMessage,
                                                  response,
                                                  isSeeMore,
                                                  isRemoveMemberFromGroupLoading,
                                                  isRemoveMemberFromGroupLoaded,
                                                ) {
                                                  if (widget.isPostLikes) {
                                                    return const SizedBox
                                                        .shrink();
                                                  }
                                                  if (widget.homeDataModel
                                                              .role ==
                                                          AppStrings
                                                              .roleAdmin ||
                                                      (widget.currentDoctorModel
                                                              .id
                                                              .toString() ==
                                                          widget.ownerId)) {
                                                    return Expanded(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          (isRemoveMemberFromGroupLoading &&
                                                                  (cubit.doctorIdForLoading ==
                                                                      doctorModel
                                                                          .id
                                                                          .toString()))
                                                              ? const IconButton(
                                                                  onPressed:
                                                                      null,
                                                                  icon:
                                                                      SizedBox(
                                                                    height: 18,
                                                                    width: 18,
                                                                    child:
                                                                        CircularProgressIndicator(
                                                                      strokeWidth:
                                                                          2,
                                                                    ),
                                                                  ))
                                                              : widget.currentDoctorModel
                                                                          .id
                                                                          .toString() ==
                                                                      doctorModel
                                                                          .id
                                                                          .toString()
                                                                  ? const SizedBox
                                                                      .shrink()
                                                                  : IconButton(
                                                                      onPressed:
                                                                          () {
                                                                        cubit.doctorIdForLoading = doctorModel
                                                                            .id
                                                                            .toString();
                                                                        cubit
                                                                            .removeMemberFromGroup(
                                                                          widget
                                                                              .groupId,
                                                                          doctorModel
                                                                              .id
                                                                              .toString(),
                                                                        );
                                                                      },
                                                                      icon:
                                                                          Icon(
                                                                        Icons
                                                                            .clear,
                                                                        color: Colors
                                                                            .red
                                                                            .shade700,
                                                                      ),
                                                                      splashColor:
                                                                          Colors
                                                                              .transparent, // Disables the splash effect
                                                                      highlightColor:
                                                                          Colors
                                                                              .transparent, // Disables the highlight effect
                                                                    ),
                                                        ],
                                                      ),
                                                    );
                                                  }
                                                  return const SizedBox
                                                      .shrink();
                                                },
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                  },
                );
              },
            ),
          ),
          SizedBox(height: 10.h),
          BlocBuilder<GroupMembersCubit, GroupMembersState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return const SizedBox.shrink();
                },
                loaded: (
                  snackBarMessage,
                  dialogMessage,
                  response,
                  isSeeMore,
                  isRemoveMemberFromGroupLoading,
                  isRemoveMemberFromGroupLoaded,
                ) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      isSeeMore
                          ? Column(
                              children: [
                                const SizedBox(
                                  height: 15,
                                  width: 15,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                  ),
                                ),
                                SizedBox(height: 20.h),
                              ],
                            )
                          : GestureDetector(
                              onTap: () {
                                cubit.loadMoreMembers(widget.groupId);
                              },
                              child: const Text(
                                '',
                              ),
                            ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
