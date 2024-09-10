import 'package:html/parser.dart' show parse;
import 'package:timeago/timeago.dart' as timeago;

import '../../../../../exports.dart';

class WebinarType extends StatelessWidget {
  final HomeCubit cubit;
  final PostModel postModel;
  const WebinarType({super.key, required this.cubit, required this.postModel});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      color: Colors.white,
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
                postModel: postModel,
                doctorModel: cubit.currentDoctorModel,
                verified: cubit.accountVerification!,
                currentDoctorRole: cubit.currentDoctorRole,
                homeDataModel: cubit.homeDataModel,
                isSyndicateCardRequired: cubit.isSyndicateCardRequired),
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
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8)),
                      child: Hero(
                        tag: 'postImage${postModel.id}',
                        child: CachedNetworkImage(
                          imageUrl: postModel.image.toString(),
                          fadeInDuration: const Duration(milliseconds: 300),
                          width: size.width * 0.3,
                          fadeInCurve: Curves.easeIn,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              Lottie.asset(AppImages.imageLoader),
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // const SizedBox(height: 10),
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    capitalizeFirstText(
                                        postModel.title.toString()),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.title,
                                        fontSize: 12.sp),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: size.height * 0.01),
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
                                        color: AppColors.description,
                                        fontSize: 8.sp),
                                    maxLines: 4,
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
                                  timeago
                                      .format(DateTime.parse(
                                        postModel.updatedAt.toString(),
                                      ))
                                      .toString(),
                                  style: TextStyle(
                                    color: AppColors.description,
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
