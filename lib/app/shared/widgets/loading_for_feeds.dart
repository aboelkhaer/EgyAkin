import 'package:egy_akin/exports.dart';

class ShimmerLoadingFeeds extends StatelessWidget {
  final int? numberOfShimmer;

  const ShimmerLoadingFeeds({
    super.key,
    this.numberOfShimmer,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(
          numberOfShimmer ?? 5,
          (index) => Container(
            margin:
                const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  spreadRadius: 2,
                  blurRadius: 9,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              enabled: true,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                    backgroundColor: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(height: 7.h),
                                        Container(
                                          width: 200,
                                          height: 10,
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade200,
                                              borderRadius:
                                                  BorderRadius.circular(40)),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          width: 160,
                                          height: 10,
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade200,
                                              borderRadius:
                                                  BorderRadius.circular(40)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        // Content Section
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 8,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(40)),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              width: double.infinity,
                              height: 8,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(40)),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              height: 8,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(40)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Lottie.asset(AppImages.imageLoader,
                            width: 120.w, height: 180.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
