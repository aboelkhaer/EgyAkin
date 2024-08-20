import '../../../../exports.dart';

class AchievementsTab extends StatefulWidget {
  final String currentDoctorId;

  final bool isProfileFeature;
  const AchievementsTab(
      {super.key,
      required this.isProfileFeature,
      required this.currentDoctorId});

  @override
  State<AchievementsTab> createState() => _AchievementsTabState();
}

class _AchievementsTabState extends State<AchievementsTab> {
  @override
  void initState() {
    super.initState();
    if (widget.isProfileFeature) {
      context
          .read<DoctorInfoViewCubit>()
          .getAchievementsV2(widget.currentDoctorId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.isProfileFeature
            ? Column(
                children: [
                  SizedBox(height: 5.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 5.h,
                        width: 60.w,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : const SizedBox.shrink(),
        BlocConsumer<DoctorInfoViewCubit, DoctorInfoViewState>(
          listener: (context, state) {},
          builder: (context, state) {
            return state.maybeWhen(orElse: () {
              return const Expanded(
                child: Center(
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                    ],
                  ),
                ),
              );
            }, loaded: (doctorInfo, isLoadingAchievements, isLoadedAchievements,
                message, achievements) {
              if (isLoadedAchievements) {
                return achievements!.isEmpty
                    ? Center(
                        child: Image.asset(
                          AppImages.notFound,
                          width: 150.w,
                          height: 150.h,
                        ),
                      )
                    : Expanded(
                        child: GridView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(20),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4, // Number of columns in the grid
                            crossAxisSpacing:
                                10, // Horizontal space between grid items
                            mainAxisSpacing:
                                10, // Vertical space between grid items
                            childAspectRatio:
                                1, // Aspect ratio of each grid item
                          ),
                          itemCount: achievements.length,
                          itemBuilder: (context, index) {
                            var achievement = achievements[index];
                            return FadeIn(
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomCachedNetworkImage(
                                          imageUrl:
                                              achievement.image.toString(),
                                          width: 70.w,
                                          height: 80,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: IconButton(
                                      onPressed: () {
                                        showCustomDialog(
                                          context: context,
                                          title: achievement.name.toString(),
                                          description: achievement.description
                                              .toString(),
                                          coloredButtonText: 'Cancel',
                                          coloredButtonOnTap: () {
                                            navigatorKey.currentState?.pop();
                                          },
                                          isNoColorShow: false,
                                        );
                                      },
                                      icon: Icon(
                                        Icons.info,
                                        color: AppColors.primary,
                                        size: 20.r,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
              }
              return const Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                    ],
                  ),
                ),
              );
            });
          },
        ),
      ],
    );
  }
}
