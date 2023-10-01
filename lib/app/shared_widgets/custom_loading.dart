import 'package:shimmer/shimmer.dart';

import '../../exports.dart';

class ShimmerLoadingPatientsCards extends StatelessWidget {
  const ShimmerLoadingPatientsCards({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.26,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 20),
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            enabled: true,
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: size.width * 0.2,
                      height: size.height * .08,
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  color: const Color.fromRGBO(255, 255, 255, 1),
                                  width: 200,
                                  height: 20,
                                ),
                                const SizedBox(height: 5),
                                Container(
                                  color: Colors.white,
                                  width: 180,
                                  height: 20,
                                ),
                                const SizedBox(height: 5),
                                Container(
                                  color: Colors.white,
                                  width: 120,
                                  height: 20,
                                ),
                              ],
                            ),
                            // Container(
                            //   color: const Color.fromRGBO(255, 255, 255, 1),
                            //   width: 100,
                            //   height: 20,
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}
