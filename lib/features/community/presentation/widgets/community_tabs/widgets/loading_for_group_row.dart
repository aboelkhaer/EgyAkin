import '../../../../../../exports.dart';
import '../../../../../../app/services/theme_bloc.dart';

class LoadingForGroupRow extends StatelessWidget {
  final int count;
  final bool isTrends;
  const LoadingForGroupRow({
    super.key,
    this.count = 3,
    this.isTrends = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;

        return Column(
          children: [
            ...List.generate(
              count,
              (index) => Shimmer.fromColors(
                baseColor:
                    isDarkMode ? AppColors.darkSurface : Colors.grey[300]!,
                highlightColor:
                    isDarkMode ? AppColors.darkBorder : Colors.grey[100]!,
                enabled: true,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            isTrends
                                ? const SizedBox.shrink()
                                : Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(80.r),
                                      child: GestureDetector(
                                        onTap: () {},
                                        child: CircleAvatar(
                                          radius: 18.r,
                                          backgroundColor: isDarkMode
                                              ? AppColors.darkPrimary
                                                  .withOpacity(0.8)
                                              : AppColors.primary
                                                  .withOpacity(0.8),
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
                            Padding(
                              padding: EdgeInsets.only(left: isTrends ? 0 : 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 150,
                                    height: 10,
                                    decoration: BoxDecoration(
                                        color: isDarkMode
                                            ? AppColors.darkBorder
                                            : Colors.grey.shade200,
                                        borderRadius:
                                            BorderRadius.circular(40)),
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    width: 200,
                                    height: 10,
                                    decoration: BoxDecoration(
                                        color: isDarkMode
                                            ? AppColors.darkBorder
                                            : Colors.grey.shade200,
                                        borderRadius:
                                            BorderRadius.circular(40)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        isTrends
                            ? const SizedBox.shrink()
                            : TextButton(
                                onPressed: () {},
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.group_add,
                                      color: isDarkMode
                                          ? AppColors.darkPrimary
                                          : AppColors.primary,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      context.tr(AppStrings.join),
                                      style: TextStyle(
                                        color: isDarkMode
                                            ? AppColors.darkPrimary
                                            : AppColors.primary,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ],
                    ),
                    SizedBox(height: isTrends ? 30 : 10),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
