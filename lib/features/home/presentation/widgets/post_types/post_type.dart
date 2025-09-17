import 'package:html/parser.dart' show parse;

import '../../../../../exports.dart';

class PostType extends StatelessWidget {
  final HomeCubit cubit;
  final PostCommunityModel postModel;
  final bool isDarkMode;
  const PostType(
      {super.key,
      required this.cubit,
      required this.postModel,
      required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      color: isDarkMode ? AppColors.darkCardBG : Colors.white,
      elevation: 0.8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        splashColor:
            isDarkMode ? AppColors.darkSubBG : AppColors.subBG, // Splash color
        onTap: () {
          navigatorKey.currentState?.pushNamed(
            AppRoutes.showSingleFeed,
            arguments: AppRoutesArgs.showSingleFeedRouteArgs(
              homeDataModel: cubit.homeDataModel,
              currentDoctorModel: cubit.currentDoctorModel,
              feed: postModel,
              isComeFromNotification: false,
              feedId: '',
              showPostFrom: ShowPostFromEnum.homeSlider.name,
            ),
          );
        },

        child: SizedBox(
          width: size.width * 0.9,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    postModel.mediaPath!.isEmpty
                        ? const SizedBox.shrink()
                        : ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(8),
                                bottomLeft: Radius.circular(8)),
                            child: Hero(
                              tag: 'postImage${postModel.id}',
                              child: CachedNetworkImage(
                                imageUrl: postModel.mediaPath![0].toString(),
                                fadeInDuration:
                                    const Duration(milliseconds: 300),
                                width: size.width * 0.3,
                                fadeInCurve: Curves.easeIn,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    Lottie.asset(AppImages.imageLoader),
                                errorWidget: (context, url, error) {
                                  return Container(
                                    color: Colors.transparent,
                                    child: Center(
                                      child: Icon(
                                        Icons.error_outline,
                                        color: isDarkMode
                                            ? AppColors.darkPrimary
                                            : AppColors.primary,
                                        size: 40.0,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // const SizedBox(height: 10),
                            // Row(
                            //   children: [
                            //     Flexible(
                            //       child: Text(
                            //         capitalizeFirstText(
                            //             postModel.content.toString()),
                            //         style: TextStyle(
                            //             fontWeight: FontWeight.bold,
                            //             color: AppColors.title,
                            //             fontSize: 12.sp),
                            //         maxLines: 2,
                            //         overflow: TextOverflow.ellipsis,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            // SizedBox(height: size.height * 0.01),
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    parse(
                                      capitalizeFirstText(
                                        postModel.content.toString(),
                                      ),
                                    ).documentElement!.text,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: isDarkMode
                                            ? AppColors.darkDescription
                                            : AppColors.description,
                                        fontSize: 10.sp),
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  TimeAgoService.instance
                                      .formatTimeAgoFromString(
                                    postModel.updatedAt.toString(),
                                    context,
                                  ),
                                  style: TextStyle(
                                    color: isDarkMode
                                        ? AppColors.darkDescription
                                        : AppColors.description,
                                    fontSize: 9.sp,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
