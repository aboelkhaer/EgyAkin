import 'package:egy_akin/app/services/theme_bloc.dart';
import '../../exports.dart';

class ShimmerLoadingPatientsCards extends StatelessWidget {
  final bool ishorizontal;
  final int? numberOfShimmer;
  final bool isTopDoctor;
  final bool isFeedsComments;
  const ShimmerLoadingPatientsCards({
    super.key,
    required this.ishorizontal,
    this.numberOfShimmer,
    this.isTopDoctor = false,
    this.isFeedsComments = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;
        Size size = MediaQuery.of(context).size;

        return SizedBox(
          height: ishorizontal ? size.height * 0.22 : null,
          child: ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const BouncingScrollPhysics(),
            scrollDirection: ishorizontal ? Axis.horizontal : Axis.vertical,
            itemCount: numberOfShimmer ?? (ishorizontal ? 5 : 10),
            // padding: const EdgeInsets.only(left: 20),
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                baseColor: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
                highlightColor:
                    isDarkMode ? Colors.grey[600]! : Colors.grey[100]!,
                enabled: true,
                child: Container(
                  // margin: const EdgeInsets.only(left: 20),
                  padding: const EdgeInsets.all(20),
                  child: isTopDoctor
                      ? Column(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              // padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isDarkMode
                                    ? AppColors.darkCardBG
                                    : Colors.white,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Container(
                              color: isDarkMode
                                  ? AppColors.darkCardBG
                                  : Colors.white,
                              width: 40,
                              height: 10,
                            ),
                            SizedBox(height: 8.h),
                            Container(
                              color: isDarkMode
                                  ? AppColors.darkCardBG
                                  : Colors.white,
                              width: 70,
                              height: 10,
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isDarkMode
                                        ? AppColors.darkCardBG
                                        : Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: isDarkMode
                                                    ? AppColors.darkCardBG
                                                    : const Color.fromRGBO(
                                                        255, 255, 255, 1),
                                                borderRadius: isFeedsComments
                                                    ? BorderRadius.circular(40)
                                                    : null,
                                              ),
                                              width: 200,
                                              height: 20,
                                            ),
                                            const SizedBox(height: 4),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: isDarkMode
                                                    ? AppColors.darkCardBG
                                                    : const Color.fromRGBO(
                                                        255, 255, 255, 1),
                                                borderRadius: isFeedsComments
                                                    ? BorderRadius.circular(40)
                                                    : null,
                                              ),
                                              width: 180,
                                              height: 20,
                                            ),
                                            const SizedBox(height: 4),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: isDarkMode
                                                    ? AppColors.darkCardBG
                                                    : const Color.fromRGBO(
                                                        255, 255, 255, 1),
                                                borderRadius: isFeedsComments
                                                    ? BorderRadius.circular(40)
                                                    : null,
                                              ),
                                              width: 120,
                                              height: 20,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
