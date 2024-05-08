import 'package:egy_akin/app/shared/functions/app_routes_args.dart';
import 'package:egy_akin/exports.dart';
import 'package:egy_akin/main.dart';
import 'package:html/parser.dart' show parse;
import 'package:timeago/timeago.dart' as timeago;

class PostsSliderAndDots extends StatelessWidget {
  final HomeCubit cubit;
  const PostsSliderAndDots({
    super.key,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(height: 13.h),
        BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () {
                return SizedBox(
                  height: size.height * 0.2,
                  child: Lottie.asset(AppImages.imageLoader),
                );
              },
              loaded: (homeData, dotsPosition, notificationData, homeIndex) {
                return CarouselSlider.builder(
                  itemCount: homeData.data!.posts!.length,
                  carouselController: cubit.carouselController,
                  itemBuilder:
                      (BuildContext context, int index, int pageViewIndex) {
                    return Card(
                      color: Colors.white, // Backgrond color
                      elevation: 0.8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        splashColor: AppColors.subBG, // Splash color
                        onTap: () {
                          navigatorKey.currentState?.pushNamed(
                            AppRoutes.postDetails,
                            arguments: AppRoutesArgs.postDetailsRouteArgs(
                              postModel: homeData.data!.posts![index],
                              doctorModel: cubit.currentDoctorModel,
                              verified: homeData.verified!,
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
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          bottomLeft: Radius.circular(8)),
                                      child: Hero(
                                        tag:
                                            'postImage${homeData.data!.posts![index].id}',
                                        child: CachedNetworkImage(
                                          imageUrl: homeData
                                              .data!.posts![index].image
                                              .toString(),
                                          fadeInDuration:
                                              const Duration(milliseconds: 300),
                                          width: size.width * 0.3,
                                          fadeInCurve: Curves.easeIn,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              Lottie.asset(
                                                  AppImages.imageLoader),
                                          errorWidget: (context, url, error) {
                                            return Container(
                                              color: Colors.transparent,
                                              child: const Center(
                                                child: Icon(
                                                  Icons.error_outline,
                                                  color: AppColors.primary,
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            // const SizedBox(height: 10),
                                            Row(
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    capitalizeFirstText(homeData
                                                        .data!
                                                        .posts![index]
                                                        .title
                                                        .toString()),
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: AppColors.title,
                                                        fontSize: 16),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                                height: size.height * 0.01),
                                            Row(
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    parse(
                                                      capitalizeFirstText(
                                                        homeData
                                                            .data!
                                                            .posts![index]
                                                            .content
                                                            .toString(),
                                                      ),
                                                    ).documentElement!.text,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: AppColors
                                                            .description,
                                                        fontSize: 13),
                                                    maxLines: 4,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Spacer(),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  timeago
                                                      .format(DateTime.parse(
                                                        homeData
                                                            .data!
                                                            .posts![index]
                                                            .updatedAt
                                                            .toString(),
                                                      ))
                                                      .toString(),
                                                  style: const TextStyle(
                                                    color:
                                                        AppColors.description,
                                                    fontSize: 10,
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
                  },
                  options: CarouselOptions(
                    height: 150.h,
                    aspectRatio: 16 / 9,
                    viewportFraction: 1,
                    initialPage: 0,
                    enableInfiniteScroll:
                        homeData.data!.posts!.length <= 1 ? false : true,
                    reverse: false,
                    onPageChanged: (index, reason) {
                      cubit.dotsPosition = index;
                      cubit.changeDotsPositions();
                    },
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: false,
                    enlargeFactor: 0.3,
                    scrollDirection: Axis.horizontal,
                  ),
                );
              },
            );
          },
        ),
        SizedBox(height: 7.h),
        BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () {
                return const SizedBox.shrink();
              },
              loaded: (homeData, dotsPosition, notificationData, homeIndex) {
                return homeData.data!.posts!.isEmpty
                    ? const SizedBox.shrink()
                    : DotsIndicator(
                        dotsCount: homeData.data!.posts!.length,
                        position: cubit.dotsPosition,
                        decorator: DotsDecorator(
                          activeColor: AppColors.primary.withOpacity(0.6),
                          color: Colors.grey.shade300,
                          size: const Size(5, 5),
                        ),
                      );
              },
            );
          },
        ),
      ],
    );
  }
}
