import 'package:egy_akin/app/shared/functions/convert_timestamp_in_community.dart';
import 'package:egy_akin/app/shared/functions/hash_tags.dart';
import 'package:egy_akin/app/shared/widgets/hash_tag_text.dart';
import 'package:egy_akin/features/community/data/models/get_posts_community_model_response.dart';

import '../../../../exports.dart';

class ShowSingleFeedScreen extends StatelessWidget {
  final HomeModelResponse homeDataModel;
  final DoctorModel currentDoctorModel;
  final PostCommunityModel feed;
  const ShowSingleFeedScreen({
    super.key,
    required this.homeDataModel,
    required this.currentDoctorModel,
    required this.feed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    navigatorKey.currentState?.pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                  ),
                ),
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
                      const Icon(Icons.more_vert),
                      const SizedBox(width: 20),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    feed.content == null || feed.content == ''
                        ? const SizedBox.shrink()
                        : Column(
                            children: [
                              const SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, bottom: 20, top: 10),
                                child: RichText(
                                  text:
                                      buildHashtagText(feed.content.toString()),
                                ),
                              ),
                            ],
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
                                  // Handle like functionality here
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
                              GestureDetector(
                                onTap: () {
                                  navigatorKey.currentState?.pushNamed(
                                    AppRoutes.showSingleFeed,
                                    arguments:
                                        AppRoutesArgs.showSingleFeedRouteArgs(
                                      homeDataModel: homeDataModel,
                                      currentDoctorModel: currentDoctorModel,
                                      feed: feed,
                                    ),
                                  );
                                },
                                child: Row(
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
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              // Handle save functionality here
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
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Comments:',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13.sp),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
