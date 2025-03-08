import 'dart:developer';

import 'package:egy_akin/app/shared/functions/date_formate_for_group.dart';
import 'package:egy_akin/app/shared/widgets/custom_network_image.dart';
import 'package:egy_akin/exports.dart';
import 'package:egy_akin/features/group_details_in_community/presentation/cubit/group_details_in_community_cubit.dart';
import 'package:egy_akin/features/group_details_in_community/presentation/cubit/group_details_in_community_state.dart';
import 'package:egy_akin/features/group_members/presentation/cubit/group_members_cubit.dart';
import 'package:egy_akin/features/group_members/presentation/pages/group_members_screen.dart';
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
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    context
        .read<GroupDetailsInCommunityCubit>()
        .getGroupDetails(widget.groupId);
  }

  Future<void> _onRefresh() async {
    final double scrollPosition = _scrollController.position.pixels;
    await context
        .read<GroupDetailsInCommunityCubit>()
        .getGroupDetails(widget.groupId);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(scrollPosition);
    });
  }

  @override
  Widget build(BuildContext context) {
    final GroupDetailsInCommunityCubit cubit =
        GroupDetailsInCommunityCubit.get(context);
    return Scaffold(
      floatingActionButton: BlocBuilder<GroupDetailsInCommunityCubit,
          GroupDetailsInCommunityState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return const SizedBox.shrink();
            },
            loaded: (
              groupDetails,
              snackBarMessage,
              dialogMessage,
              isDeleteGroupLoading,
              isDeleteGroupLoaded,
            ) {
              return (groupDetails.data!.group!.userStatus ==
                          GroupInviteStatus.accepted.name ||
                      groupDetails.data!.group!.userStatus ==
                          GroupInviteStatus.joined.name ||
                      (groupDetails.data!.group!.userStatus ==
                              GroupInviteStatus.invited.name &&
                          groupDetails.data!.group!.privacy ==
                              GroupStatus.public.name))
                  ? FadeIn(
                      child: FloatingActionButton(
                        onPressed: () {
                          navigatorKey.currentState?.pushNamed(
                            AppRoutes.createPostInCommunity,
                            arguments:
                                AppRoutesArgs.createPostInCommunityRouteArgs(
                              currentDoctorModel: widget.currentDoctorModel,
                              homeDataModel: widget.homeDataModel,
                              groupId: widget.groupId,
                              onPostUploaded: () {
                                cubit.getGroupDetails(widget.groupId);
                              },
                            ),
                          );
                        },
                        shape: const CircleBorder(),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    )
                  : const SizedBox.shrink();
            },
          );
        },
      ),
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 250.0,
              pinned: true,
              floating: false,
              flexibleSpace: LayoutBuilder(
                builder: (context, constraints) {
                  return Stack(
                    children: [
                      FlexibleSpaceBar(
                        titlePadding:
                            const EdgeInsets.only(left: 16, bottom: 16),
                        title: const Text(
                          'Community',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        background: BlocConsumer<GroupDetailsInCommunityCubit,
                            GroupDetailsInCommunityState>(
                          listener: (context, state) {
                            state.maybeWhen(
                              orElse: () {},
                              error: (message) {
                                customSnackBar(
                                    context: context, message: message);
                              },
                              loaded: (
                                groupDetails,
                                snackBarMessage,
                                dialogMessage,
                                isDeleteGroupLoading,
                                isDeleteGroupLoaded,
                              ) {
                                if (snackBarMessage != '') {
                                  customSnackBar(
                                      context: context,
                                      message: snackBarMessage);
                                }
                                if (isDeleteGroupLoaded) {
                                  navigatorKey.currentState
                                      ?.pushReplacementNamed(
                                    AppRoutes.home,
                                    arguments: 0,
                                  );
                                  Future.delayed(Duration.zero, () {
                                    navigatorKey.currentState?.pushNamed(
                                      AppRoutes.community,
                                      arguments:
                                          AppRoutesArgs.communityRouteArgs(
                                        homeDataModel: widget.homeDataModel,
                                        currentDoctorModel:
                                            widget.currentDoctorModel,
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
                              orElse: () {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Lottie.asset(
                                      AppImages.imageLoader,
                                      width: 150,
                                      height: 150,
                                    ),
                                  ],
                                );
                              },
                              loaded: (
                                groupDetails,
                                snackBarMessage,
                                dialogMessage,
                                isDeleteGroupLoading,
                                isDeleteGroupLoaded,
                              ) {
                                return GestureDetector(
                                  onTap: groupDetails.data!.group!.userStatus ==
                                              GroupInviteStatus.accepted.name ||
                                          groupDetails
                                                  .data!.group!.userStatus ==
                                              GroupInviteStatus.joined.name
                                      ? () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  FullScreenImage(
                                                imageUrl: groupDetails
                                                    .data!.group!.headerPicture
                                                    .toString(),
                                                isLocal: false,
                                              ),
                                            ),
                                          );
                                        }
                                      : null,
                                  child: FadeIn(
                                    duration: const Duration(milliseconds: 600),
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        NetworkImageWithErrorHandler(
                                          imageUrl: groupDetails
                                              .data!.group!.headerPicture
                                              .toString(),
                                          fit: BoxFit.cover,
                                        ),
                                        Container(
                                          color: Colors.black.withOpacity(
                                              0.2), // Overlay for readability
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      // Add a shadow at the bottom of the SliverAppBar
                      if (constraints.maxHeight ==
                          250.0) // Only show shadow when expanded
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 10,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              actions: [
                BlocBuilder<GroupDetailsInCommunityCubit,
                    GroupDetailsInCommunityState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () {
                        return PopupMenuButton<String>(
                          icon: const Icon(Icons.more_vert),
                          onSelected: (String value) {
                            if (value == 'report') {}
                          },
                          itemBuilder: (BuildContext context) {
                            return <PopupMenuEntry<String>>[
                              PopupMenuItem(
                                value: 'report',
                                child: Row(
                                  children: [
                                    const Icon(Icons.report,
                                        color: AppColors.description),
                                    SizedBox(width: 8.w),
                                    const Text('Report'),
                                  ],
                                ),
                              ),
                            ];
                          },
                        );
                      },
                      loaded: (
                        groupDetails,
                        snackBarMessage,
                        dialogMessage,
                        isDeleteGroupLoading,
                        isDeleteGroupLoaded,
                      ) {
                        return isDeleteGroupLoading
                            ? const IconButton(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onPressed: null,
                                icon: SizedBox(
                                  height: 15,
                                  width: 15,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                  ),
                                ),
                              )
                            : PopupMenuButton<String>(
                                icon: const Icon(Icons.more_vert),
                                onSelected: (String value) {
                                  if (value == 'report') {
                                    debugPrint('Report clicked');
                                  }
                                  if (value == 'leave_group') {
                                    cubit.leaveGroup(groupDetails
                                        .data!.group!.id
                                        .toString());
                                  }
                                  if (value == 'delete_group') {
                                    log('hello');
                                    cubit.deleteGroup(groupDetails
                                        .data!.group!.id
                                        .toString());
                                  }
                                },
                                itemBuilder: (BuildContext context) {
                                  final items = <PopupMenuEntry<String>>[
                                    PopupMenuItem(
                                      value: 'report',
                                      child: Row(
                                        children: [
                                          const Icon(Icons.report,
                                              color: AppColors.description),
                                          SizedBox(width: 8.w),
                                          const Text('Report'),
                                        ],
                                      ),
                                    ),
                                  ];

                                  if (groupDetails.data!.group!.userStatus ==
                                          GroupInviteStatus.accepted.name ||
                                      groupDetails.data!.group!.userStatus ==
                                          GroupInviteStatus.joined.name ||
                                      (groupDetails.data!.group!.userStatus ==
                                              GroupInviteStatus.invited.name &&
                                          groupDetails.data!.group!.privacy ==
                                              GroupStatus.public.name)) {
                                    items.add(
                                      PopupMenuItem(
                                        value: 'leave_group',
                                        child: Row(
                                          children: [
                                            const Icon(Icons.exit_to_app,
                                                color: AppColors.description),
                                            SizedBox(width: 8.w),
                                            const Text('Leave Group'),
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                                  if (widget.currentDoctorModel.id.toString() ==
                                      groupDetails.data!.group!.owner!.id
                                          .toString()) {
                                    items.add(
                                      PopupMenuItem(
                                        value: 'delete_group',
                                        child: Row(
                                          children: [
                                            const Icon(Icons.delete,
                                                color: AppColors.description),
                                            SizedBox(width: 8.w),
                                            const Text('Delete Group'),
                                          ],
                                        ),
                                      ),
                                    );
                                  }

                                  return items;
                                },
                              );
                      },
                    );
                  },
                ),
              ],
            ),
          ];
        },
        body: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: _onRefresh,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 20),
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
                                  // Handle user profile navigation here
                                },
                                child: CircleAvatar(
                                  radius: 20.r,
                                  backgroundColor:
                                      AppColors.primary.withOpacity(0.8),
                                  child: BlocBuilder<
                                      GroupDetailsInCommunityCubit,
                                      GroupDetailsInCommunityState>(
                                    builder: (context, state) {
                                      return state.maybeWhen(
                                        orElse: () {
                                          return Lottie.asset(
                                            AppImages.imageLoader,
                                            width: 50,
                                            height: 50,
                                          );
                                        },
                                        loaded: (
                                          groupDetails,
                                          snackBarMessage,
                                          dialogMessage,
                                          isDeleteGroupLoading,
                                          isDeleteGroupLoaded,
                                        ) {
                                          return FadeIn(
                                            duration: const Duration(
                                                milliseconds: 600),
                                            child: GestureDetector(
                                              onTap: groupDetails.data!.group!
                                                              .userStatus ==
                                                          GroupInviteStatus
                                                              .accepted.name ||
                                                      groupDetails.data!.group!
                                                              .userStatus ==
                                                          GroupInviteStatus
                                                              .joined.name
                                                  ? () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              FullScreenImage(
                                                            imageUrl:
                                                                groupDetails
                                                                    .data!
                                                                    .group!
                                                                    .groupImage
                                                                    .toString(),
                                                            isLocal: false,
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                  : null,
                                              child: SizedBox(
                                                width: 40
                                                    .r, // Match the size of the CircleAvatar
                                                height: 40
                                                    .r, // Match the size of the CircleAvatar
                                                child: ClipOval(
                                                  child:
                                                      NetworkImageWithErrorHandler(
                                                    imageUrl: groupDetails
                                                        .data!.group!.groupImage
                                                        .toString(),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          BlocBuilder<GroupDetailsInCommunityCubit,
                              GroupDetailsInCommunityState>(
                            builder: (context, state) {
                              return state.maybeWhen(
                                orElse: () {
                                  return const SizedBox.shrink();
                                },
                                loaded: (
                                  groupDetails,
                                  snackBarMessage,
                                  dialogMessage,
                                  isDeleteGroupLoading,
                                  isDeleteGroupLoaded,
                                ) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            groupDetails.data!.group!.name
                                                .toString(),
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(width: 8),
                                          InkWell(
                                            onTap: () {
                                              navigatorKey.currentState
                                                  ?.pushNamed(
                                                AppRoutes
                                                    .createGroupInCommunity,
                                                arguments: AppRoutesArgs
                                                    .createGroupInCommunityRouteArgs(
                                                  currentDoctorModel:
                                                      widget.currentDoctorModel,
                                                  homeDataModel:
                                                      widget.homeDataModel,
                                                  isCreateNewGroup: false,
                                                  groupModel:
                                                      groupDetails.data!.group,
                                                ),
                                              );
                                            },
                                            splashColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            child: Icon(
                                              Icons.edit,
                                              color: AppColors.description,
                                              size: 18.r,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          groupDetails.data!.group!
                                                          .userStatus ==
                                                      GroupInviteStatus
                                                          .accepted.name ||
                                                  groupDetails.data!.group!
                                                          .userStatus ==
                                                      GroupInviteStatus
                                                          .joined.name ||
                                                  (groupDetails.data!.group!
                                                              .userStatus ==
                                                          GroupInviteStatus
                                                              .invited.name &&
                                                      groupDetails.data!.group!
                                                              .privacy
                                                              .toString() ==
                                                          GroupStatus
                                                              .public.name)
                                              ? InkWell(
                                                  onTap: () {
                                                    showCustomBottomSheet(
                                                      context: context,
                                                      builder: (context) {
                                                        return BlocProvider(
                                                          create: (context) =>
                                                              GroupMembersCubit(
                                                                  sl(),
                                                                  sl(),
                                                                  sl()),
                                                          child:
                                                              GroupMembersScreen(
                                                            groupId:
                                                                widget.groupId,
                                                            currentDoctorModel:
                                                                widget
                                                                    .currentDoctorModel,
                                                            homeDataModel: widget
                                                                .homeDataModel,
                                                            postId: '',
                                                            ownerId:
                                                                groupDetails
                                                                    .data!
                                                                    .group!
                                                                    .owner!
                                                                    .id
                                                                    .toString(),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                  splashColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  child: Text(
                                                    '${groupDetails.data!.group!.memberCount} Members',
                                                    style: const TextStyle(
                                                        color:
                                                            AppColors.primary),
                                                  ),
                                                )
                                              : Text(
                                                  '${groupDetails.data!.group!.memberCount} Members',
                                                  style: TextStyle(
                                                      color: Colors.grey[600]),
                                                ),
                                          const SizedBox(width: 5),
                                          Text(
                                            '•',
                                            style: TextStyle(
                                                color: Colors.grey[600]),
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            'Created ${formatDateForGroup(groupDetails.data!.group!.createdAt.toString())}',
                                            style: TextStyle(
                                                color: Colors.grey[600]),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      BlocBuilder<GroupDetailsInCommunityCubit,
                          GroupDetailsInCommunityState>(
                        builder: (context, state) {
                          return state.maybeWhen(
                            orElse: () {
                              return const SizedBox.shrink();
                            },
                            loaded: (
                              groupDetails,
                              snackBarMessage,
                              dialogMessage,
                              isDeleteGroupLoading,
                              isDeleteGroupLoaded,
                            ) {
                              return ReadMoreText(
                                groupDetails.data!.group!.description
                                    .toString(),
                                trimMode: TrimMode.Line,
                                trimLines: 2,
                                colorClickableText: Colors.blue,
                                trimCollapsedText: ' See more',
                                trimExpandedText: '',
                                moreStyle: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue,
                                  fontSize: 11.sp,
                                ),
                                lessStyle: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue,
                                  fontSize: 11.sp,
                                ),
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 12.sp,
                                ),
                              );
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      BlocBuilder<GroupDetailsInCommunityCubit,
                          GroupDetailsInCommunityState>(
                        builder: (context, state) {
                          return state.maybeWhen(
                            orElse: () {
                              return Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                enabled: true,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 8,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius:
                                              BorderRadius.circular(40)),
                                    ),
                                    const SizedBox(height: 5),
                                    Container(
                                      width: 200,
                                      height: 8,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius:
                                              BorderRadius.circular(40)),
                                    ),
                                    const SizedBox(height: 20),
                                  ],
                                ),
                              );
                            },
                            loaded: (
                              groupDetails,
                              snackBarMessage,
                              dialogMessage,
                              isDeleteGroupLoading,
                              isDeleteGroupLoaded,
                            ) {
                              if (groupDetails.data!.group!.userStatus ==
                                          GroupInviteStatus.invited.name &&
                                      groupDetails.data!.group!.privacy ==
                                          GroupStatus.public.name ||
                                  groupDetails.data!.group!.userStatus ==
                                      GroupInviteStatus.joined.name ||
                                  groupDetails.data!.group!.userStatus ==
                                      GroupInviteStatus.accepted.name) {
                                return FadeIn(
                                  child: Column(
                                    children: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.primary,
                                          foregroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                          minimumSize:
                                              const Size(double.infinity, 48),
                                        ),
                                        onPressed: () {
                                          navigatorKey.currentState?.pushNamed(
                                            AppRoutes.sendConsultation,
                                            arguments: AppRoutesArgs
                                                .sendConsultationRouteArgs(
                                              homeDataModel:
                                                  widget.homeDataModel,
                                              currentDoctorModel:
                                                  widget.currentDoctorModel,
                                              patientId: '',
                                              isSendConsultation: false,
                                              groupId: groupDetails
                                                  .data!.group!.id
                                                  .toString(),
                                            ),
                                          );
                                        },
                                        child: const Text(
                                          'Invite',
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                  ),
                                );
                              }
                              return FadeIn(
                                child: Column(
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.primary,
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        minimumSize:
                                            const Size(double.infinity, 48),
                                      ),
                                      onPressed: groupDetails.data!.group!
                                                      .userStatus ==
                                                  GroupInviteStatus
                                                      .invited.name &&
                                              groupDetails
                                                      .data!.group!.privacy ==
                                                  GroupStatus.private.name
                                          ? null // Disable the button if the user is already invited or joined
                                          : () {
                                              cubit.joinGroup(groupDetails
                                                  .data!.group!.id
                                                  .toString());
                                            },
                                      child: Text(
                                        groupDetails.data!.group!
                                                        .userStatus ==
                                                    GroupInviteStatus
                                                        .invited.name &&
                                                groupDetails
                                                        .data!.group!.privacy ==
                                                    GroupStatus.private.name
                                            ? 'Pending'
                                            : groupDetails.data!
                                                            .group!.userStatus ==
                                                        GroupInviteStatus
                                                            .accepted.name ||
                                                    groupDetails.data!.group!
                                                            .userStatus ==
                                                        GroupInviteStatus
                                                            .joined.name ||
                                                    groupDetails.data!.group!
                                                            .userStatus ==
                                                        GroupInviteStatus
                                                            .invited.name
                                                ? 'Joined'
                                                : 'Join',
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                      Divider(
                        color: Colors.grey.shade300,
                      ),
                      // const SizedBox(height: 10),
                    ],
                  ),
                ),
                BlocBuilder<GroupDetailsInCommunityCubit,
                    GroupDetailsInCommunityState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () {
                        return const ShimmerLoadingFeeds(
                          numberOfShimmer: 3,
                        );
                      },
                      loaded: (
                        groupDetails,
                        snackBarMessage,
                        dialogMessage,
                        isDeleteGroupLoading,
                        isDeleteGroupLoaded,
                      ) {
                        return groupDetails.data!.posts!.data!.isEmpty
                            ? Column(
                                children: [
                                  SizedBox(height: 50.h),
                                  Text(
                                    'No posts yet',
                                    style: TextStyle(
                                      color: Colors.grey.shade500,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              )
                            : ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount:
                                    groupDetails.data!.posts!.data!.length,
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                itemBuilder: (context, index) {
                                  PostCommunityModel postModel =
                                      groupDetails.data!.posts!.data![index];
                                  return Container(
                                    margin: const EdgeInsets.only(bottom: 20),
                                    child: PostCard(
                                      feed: postModel,
                                      homeDataModel: widget.homeDataModel,
                                      currentDoctorModel:
                                          widget.currentDoctorModel,
                                      isGroupPosts: true,
                                      onLikeAndUnlikeAdditional: () {
                                        cubit.addLikeOrUnlikeOnPost(
                                            postModel.id.toString());
                                      },
                                      onSaveAndUnSaveAdditional: () {
                                        cubit.addSaveOrUnsaveOnPost(
                                            postModel.id.toString());
                                      },
                                      onDeleteAdditional: () {
                                        cubit.deletePost(
                                            postModel.id.toString());
                                      },
                                    ),
                                  );
                                },
                              );
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
  }
}
