import 'package:egy_akin/exports.dart';

class ShimmerLoadingFeeds extends StatelessWidget {
  final int? numberOfShimmer;

  const ShimmerLoadingFeeds({
    super.key,
    this.numberOfShimmer,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: numberOfShimmer ?? 5, // Number of shimmer placeholders
      padding: const EdgeInsets.only(bottom: 30, top: 10),

      itemBuilder: (context, index) {
        return Container(
          margin:
              const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 200,
                                          height: 16,
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade200,
                                              borderRadius:
                                                  BorderRadius.circular(40)),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: 160,
                                      height: 16,
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
                          height: 10,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(40)),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          width: double.infinity,
                          height: 10,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(40)),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          height: 10,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(40)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Lottie.asset(AppImages.imageLoader, width: 120.w),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
