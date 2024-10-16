import 'dart:developer';

import 'package:egy_akin/app/shared/functions/convert_timestamp_in_community.dart';
import 'package:egy_akin/app/shared/widgets/hash_tag_text.dart';
import 'package:egy_akin/exports.dart';
import 'package:egy_akin/features/community/presentation/cubit/community_state.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'dart:ui' as ui;

class PostsTab extends StatelessWidget {
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;
  const PostsTab(
      {super.key,
      required this.currentDoctorModel,
      required this.homeDataModel});

  @override
  Widget build(BuildContext context) {
    CommunityCubit cubit = CommunityCubit.get(context);

    return Container(
      color: Colors.grey.shade200,
      child: BlocBuilder<CommunityCubit, CommunityState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return const SizedBox.shrink();
            },
            loaded: (feedsResponse) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await cubit.getAllFeeds();
                      },
                      child: ListView.builder(
                        itemCount: feedsResponse.data!.data!.length,
                        // physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(20) +
                            EdgeInsets.only(bottom: 60.h),
                        itemBuilder: (context, index) {
                          var feed = feedsResponse.data!.data![index];
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
                                                  color: Colors.grey
                                                      .withOpacity(0.4),
                                                  spreadRadius: 2,
                                                  blurRadius: 9,
                                                  offset: const Offset(0, 3),
                                                ),
                                              ],
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(80.r),
                                              child: GestureDetector(
                                                onTap: () {
                                                  // Handle user profile navigation here
                                                },
                                                child: CircleAvatar(
                                                  radius: 20.r,
                                                  backgroundColor: AppColors
                                                      .primary
                                                      .withOpacity(0.8),
                                                  child:
                                                      CustomCachedNetworkImage(
                                                    imageUrl: feed.doctor!.image
                                                        .toString(),
                                                    height: 100.h,
                                                    width: 100.w,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(width: 12.w),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Flexible(
                                                            child: Text(
                                                              doctorName(
                                                                firstName: feed
                                                                    .doctor!
                                                                    .firstName,
                                                                lastName: feed
                                                                    .doctor!
                                                                    .lastName,
                                                                role: '',
                                                              ),
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: AppColors
                                                                    .title,
                                                                fontSize: 12.sp,
                                                              ),
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                          'Verified' ==
                                                                  'Verified'
                                                              ? const VerificationIcon(
                                                                  isPatientCard:
                                                                      false,
                                                                )
                                                              : const SizedBox
                                                                  .shrink(),
                                                        ],
                                                      ),
                                                      Text(
                                                        formatDateTimeForCommunity(
                                                            feed.createdAt
                                                                .toString()),
                                                        style: TextStyle(
                                                          color: AppColors
                                                              .description,
                                                          fontSize: 11.sp,
                                                        ),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const Icon(Icons.more_vert),
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
                                              builder: (context) =>
                                                  FullScreenImage(
                                                imageUrl:
                                                    feed.mediaPath.toString(),
                                              ),
                                            ),
                                          );
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              cubit.addLikeOrUnlikeOnPost(
                                                  feed.id.toString());
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
                                          cubit.addSaveOrUnsaveOnPost(
                                              feed.id.toString());
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
                        },
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
