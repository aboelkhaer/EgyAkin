import '../../../../../../exports.dart';

class LoadingForGroupRow extends StatelessWidget {
  final int count;
  const LoadingForGroupRow({
    super.key,
    this.count = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...List.generate(
          count,
          (index) => Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            enabled: true,
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(80.r),
                            child: GestureDetector(
                              onTap: () {
                                // Handle user profile navigation here
                              },
                              child: GestureDetector(
                                onTap: () {},
                                child: CircleAvatar(
                                  radius: 18.r,
                                  backgroundColor:
                                      AppColors.primary.withOpacity(0.8),
                                  child: CustomCachedNetworkImage(
                                    imageUrl:
                                        'https://img.freepik.com/free-photo/abstract-yellow-concrete-textures_74190-6993.jpg',
                                    height: 100.h,
                                    width: 100.w,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 150,
                                height: 10,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(40)),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                width: 200,
                                height: 10,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(40)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Row(
                        children: [
                          Icon(
                            Icons.group_add,
                            color: AppColors.primary,
                          ),
                          SizedBox(width: 5),
                          Text(
                            'Join',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
