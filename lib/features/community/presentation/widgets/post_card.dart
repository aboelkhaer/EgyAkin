import 'package:egy_akin/app/shared/functions/convert_timestamp_in_community.dart';
import 'package:egy_akin/app/shared/functions/hint_dialog.dart';
import 'package:egy_akin/app/shared/widgets/hash_tag_text.dart';
import 'package:egy_akin/features/community/data/models/get_posts_community_model_response.dart';
import 'package:egy_akin/features/community/presentation/cubit/community_state.dart';

import '../../../../exports.dart';

class PostCard extends StatelessWidget {
  final PostCommunityModel feed;
  final HomeModelResponse homeDataModel;
  final DoctorModel currentDoctorModel;
  const PostCard({
    super.key,
    required this.feed,
    required this.homeDataModel,
    required this.currentDoctorModel,
  });

  @override
  Widget build(BuildContext context) {
    CommunityCubit cubit = CommunityCubit.get(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      // padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
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
                            // Handle user profile navigation here
                          },
                          child: CircleAvatar(
                            radius: 20.r,
                            backgroundColor: AppColors.primary.withOpacity(0.8),
                            child: CustomCachedNetworkImage(
                              imageUrl: feed.doctor!.image.toString(),
                              height: 100.h,
                              width: 100.w,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        doctorName(
                                          firstName: feed.doctor!.firstName,
                                          lastName: feed.doctor!.lastName,
                                          role: '',
                                        ),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.title,
                                          fontSize: 12.sp,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    'Verified' == 'Verified'
                                        ? const VerificationIcon(
                                            isPatientCard: false,
                                          )
                                        : const SizedBox.shrink(),
                                  ],
                                ),
                                Text(
                                  formatDateTimeForCommunity(
                                      feed.createdAt.toString()),
                                  style: TextStyle(
                                    color: AppColors.description,
                                    fontSize: 11.sp,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          BlocConsumer<CommunityCubit, CommunityState>(
                            listener: (context, state) {
                              state.maybeWhen(
                                orElse: () {},
                                error: (message) {
                                  showHintDialog(
                                      context: context,
                                      dialogType: DialogType.error,
                                      message: message);
                                },
                                loaded: (feedsResponse, isDeletePostLoading,
                                    isDeletePostLoaded, message) {
                                  if (message != '') {
                                    showHintDialog(
                                        context: context,
                                        dialogType: DialogType.information,
                                        message: message);
                                  }
                                },
                              );
                            },
                            builder: (context, state) {
                              return state.maybeWhen(
                                orElse: () {
                                  return const SizedBox.shrink();
                                },
                                loaded: (feedsResponse, isDeletePostLoading,
                                    isDeletePostLoaded, message) {
                                  if (isDeletePostLoading &&
                                      (feed.id.toString() ==
                                          cubit.postIdDeleted)) {
                                    return const Row(
                                      children: [
                                        SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 3,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                      ],
                                    );
                                  }

                                  return PopupMenuButton<String>(
                                    icon: const Icon(Icons.more_vert),
                                    onSelected: (String value) {
                                      switch (value) {
                                        case 'Report':
                                          // Handle report action
                                          print('Report clicked');
                                          break;
                                        case 'Delete':
                                          // Handle delete action
                                          cubit.deletePost(feed.id.toString());
                                          break;
                                      }
                                    },
                                    itemBuilder: (BuildContext context) {
                                      final items = <PopupMenuEntry<String>>[
                                        PopupMenuItem(
                                          value: 'Report',
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

                                      if (feed.doctor!.id.toString() ==
                                              currentDoctorModel.id
                                                  .toString() ||
                                          homeDataModel.role ==
                                              AppStrings.roleAdmin) {
                                        items.add(
                                          PopupMenuItem(
                                            value: 'Delete',
                                            child: Row(
                                              children: [
                                                const Icon(Icons.delete,
                                                    color:
                                                        AppColors.description),
                                                SizedBox(width: 8.w),
                                                const Text('Delete'),
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
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Flexible(
                      child: HashtagText(
                        content: feed.content.toString(),
                        trimLines: 6,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          feed.mediaPath == null
              ? const SizedBox.shrink()
              : GestureDetector(
                  onTap: () {
                    navigatorKey.currentState?.push(
                      MaterialPageRoute(
                        builder: (context) => FullScreenImage(
                          imageUrl: feed.mediaPath.toString(),
                        ),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: CustomCachedNetworkImage(
                      imageUrl: feed.mediaPath.toString(),
                      width: double.infinity,
                      height: 150.h,
                    ),
                  ),
                ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        cubit.addLikeOrUnlikeOnPost(feed.id.toString());
                      },
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      child: Row(
                        children: [
                          Icon(
                            Icons.favorite,
                            color: feed.isLiked == true
                                ? Colors.red.shade600
                                : Colors.grey.shade400,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            feed.likesCount.toString(),
                            style: TextStyle(
                              color: Colors.grey.shade400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Row(
                      children: [
                        Icon(
                          Icons.comment,
                          color: Colors.grey.shade400,
                          size: 23,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          feed.commentsCount.toString(),
                          style: TextStyle(
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    cubit.addSaveOrUnsaveOnPost(feed.id.toString());
                  },
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  child: Row(
                    children: [
                      Icon(
                        feed.isSaved == true
                            ? Icons.bookmark
                            : Icons.bookmark_outline,
                        color: feed.isSaved == true
                            ? Colors.amber
                            : Colors.grey.shade400,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
