import 'dart:developer';

import 'package:egy_akin/app/shared/functions/animate_to_index.dart';

import '../../../../exports.dart';

class DoctorInfoViewScreen extends StatefulWidget {
  final String doctorId;
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;
  final String isSyndicateCardRequired;
  final bool accountVerification;
  final String currentDoctorRole;
  final int currentDoctorPoints;
  final int initialIndex;
  final bool isNavigateToTheButtonOfInformationTab;

  const DoctorInfoViewScreen({
    super.key,
    required this.doctorId,
    required this.currentDoctorModel,
    required this.isSyndicateCardRequired,
    required this.accountVerification,
    required this.currentDoctorRole,
    required this.currentDoctorPoints,
    required this.homeDataModel,
    required this.initialIndex,
    required this.isNavigateToTheButtonOfInformationTab,
  });

  @override
  State<DoctorInfoViewScreen> createState() => _DoctorInfoViewScreenState();
}

class _DoctorInfoViewScreenState extends State<DoctorInfoViewScreen> {
  @override
  void initState() {
    context.read<DoctorInfoViewCubit>().getDoctorInfo(widget.doctorId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DoctorInfoViewCubit cubit = DoctorInfoViewCubit.get(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20.h),
          Row(
            children: [
              SizedBox(width: 20.w),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                ),
              ),
              const Spacer(),
              widget.doctorId == widget.currentDoctorModel.id.toString()
                  ? IconButton(
                      onPressed: () {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          navigatorKey.currentState?.pushReplacementNamed(
                              AppRoutes.home,
                              arguments: 2);
                        });
                      },
                      icon: const Icon(Icons.edit),
                    )
                  // : IconButton(
                  //     onPressed: () {},
                  //     icon: const Icon(
                  //       Icons.chat_bubble_outline,
                  //     ),
                  //   ),
                  : const SizedBox.shrink(),
              SizedBox(width: 20.w),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BlocConsumer<DoctorInfoViewCubit, DoctorInfoViewState>(
                      listener: (context, state) {
                        state.maybeWhen(
                          orElse: () {},
                          loaded: (doctorInfo,
                              isLoadingAchievements,
                              isLoadedAchievements,
                              message,
                              achievements,
                              changesCounter) {
                            if (widget.isNavigateToTheButtonOfInformationTab) {
                              animateToIndex(
                                  cubit.doctorInfoViewScrollController,
                                  7,
                                  100.h);
                            }
                          },
                        );
                      },
                      builder: (context, state) {
                        return state.maybeWhen(
                          orElse: () {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(80.r),
                              child: GestureDetector(
                                onTap: () {},
                                child: CircleAvatar(
                                  radius: 45.r,
                                  backgroundColor: Colors.grey.shade200,
                                  child: Center(
                                    child: Lottie.asset(AppImages.imageLoader),
                                  ),
                                ),
                              ),
                            );
                          },
                          loaded: (
                            doctorInfo,
                            isLoadingScoreHistory,
                            isLoadedScoreHistory,
                            message,
                            scoreHistory,
                            changesCounter,
                          ) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(80.r),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FullScreenImage(
                                        imageUrl:
                                            doctorInfo.data!.image.toString(),
                                      ),
                                    ),
                                  );
                                },
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                child: FadeIn(
                                  duration: const Duration(milliseconds: 300),
                                  child: CircleAvatar(
                                    radius: 45.r,
                                    backgroundColor:
                                        AppColors.primary.withOpacity(0.8),
                                    child: doctorInfo!.data!.image == null
                                        ? Text(
                                            doctorInfo.data!.firstName == null
                                                ? ''
                                                : doctorInfo.data!.firstName![0]
                                                    .toUpperCase(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.sp),
                                          )
                                        : CustomCachedNetworkImage(
                                            imageUrl: doctorInfo.data!.image
                                                .toString(),
                                            height: 100.h,
                                            width: 100.w,
                                          ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    )
                  ],
                ),
                SizedBox(height: 10.h),
                BlocBuilder<DoctorInfoViewCubit, DoctorInfoViewState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () {
                        return const Text(
                          AppStrings.empty,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        );
                      },
                      loaded: (
                        doctorInfo,
                        isLoadingAchievements,
                        isLoadedAchievements,
                        message,
                        achievements,
                        changesCounter,
                      ) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Dr.${capitalizeFirstText(doctorInfo!.data!.firstName!)} ${capitalizeFirstText(doctorInfo.data!.lastName!)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            doctorInfo.data!.isSyndicateCardRequired ==
                                    'Verified'
                                ? Tooltip(
                                    message: 'Verified',
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 3),
                                      child: FadeIn(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        child: Image.asset(
                                          AppImages.verified,
                                          height: 20,
                                          width: 20,
                                          color: Colors.green.shade600,
                                        ),
                                      ),
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ],
                        );
                      },
                    );
                  },
                ),
                SizedBox(height: 5.h),
                BlocBuilder<DoctorInfoViewCubit, DoctorInfoViewState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () {
                        return Text(
                          capitalizeFirstText(AppStrings.empty)!,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 12.sp,
                              color: Colors.grey.shade600),
                        );
                      },
                      loaded: (doctorInfo,
                          isLoadingScoreHistory,
                          isLoadedScoreHistory,
                          message,
                          scoreHistory,
                          changesCounter) {
                        return Text(
                          capitalizeFirstText(
                              doctorInfo!.data!.specialty ?? AppStrings.empty)!,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 12.sp,
                              color: Colors.grey.shade600),
                        );
                      },
                    );
                  },
                ),
                SizedBox(height: 10.h),
                BlocBuilder<DoctorInfoViewCubit, DoctorInfoViewState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildStatCard(
                              icon: Icons.group,
                              title: 'Patients',
                              value: '',
                              onTap: () {},
                            ),
                            _buildStatCard(
                              icon: Icons.star,
                              title: 'Score',
                              value: '',
                              onTap: () {},
                            ),
                            _buildStatCard(
                              icon: Icons.bookmark,
                              title: 'Saved Posts',
                              value: '',
                              onTap: () {
                                // Add action for Saved Posts
                              },
                            ),
                            _buildStatCard(
                              icon: Icons.post_add,
                              title: 'All Posts',
                              value: '',
                              onTap: () {
                                // Add action for All Posts
                              },
                            ),
                          ],
                        );
                      },
                      loaded: (doctorInfo,
                          isLoadingAchievements,
                          isLoadedAchievements,
                          message,
                          achievements,
                          changesCounter) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildStatCard(
                              icon: Icons.group,
                              title: 'Patients',
                              value: doctorInfo?.patientCount.toString() ?? '0',
                              onTap: isVerifiedUser(widget
                                      .homeDataModel.isSyndicateCardRequired)
                                  ? () {
                                      navigatorKey.currentState?.pushNamed(
                                        AppRoutes.profilePatients,
                                        arguments: AppRoutesArgs
                                            .profilePatientsRouteArgs(
                                          doctorId: widget.doctorId,
                                          currentDoctorModel:
                                              widget.currentDoctorModel,
                                          accountVerification:
                                              widget.accountVerification,
                                          currentDoctorPoints:
                                              widget.currentDoctorPoints,
                                          isSyndicateCardRequired:
                                              widget.isSyndicateCardRequired,
                                          doctorFirstName: doctorInfo!
                                              .data!.firstName
                                              .toString(),
                                          currentDoctorRole:
                                              widget.currentDoctorRole,
                                          homeDataModel: widget.homeDataModel,
                                        ),
                                      );
                                    }
                                  : () {
                                      customSnackBar(
                                          context: context,
                                          message:
                                              'You should verify your syndicate card at first.');
                                    },
                            ),
                            _buildStatCard(
                              icon: Icons.star,
                              title: 'Score',
                              value: doctorInfo?.scoreValue.toString() ?? '0',
                              onTap: () {
                                showCustomBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return BlocProvider(
                                      create: (context) =>
                                          ScoreHistoryCubit(sl()),
                                      child: ScoreHistoryScreen(
                                        doctorId: widget.doctorId,
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                            _buildStatCard(
                              icon: Icons.bookmark,
                              title: 'Saved Posts',
                              value:
                                  doctorInfo?.savedPostsCount.toString() ?? '0',
                              onTap: () {
                                navigatorKey.currentState?.pushNamed(
                                  AppRoutes.savedPosts,
                                  arguments: AppRoutesArgs.savedPostsRouteArgs(
                                    currentDoctorModel:
                                        widget.currentDoctorModel,
                                    homeDataModel: widget.homeDataModel,
                                    doctorId: widget.doctorId,
                                    doctorName: doctorName(
                                        firstName: doctorInfo!.data!.firstName
                                            .toString(),
                                        lastName: doctorInfo.data!.lastName
                                            .toString(),
                                        role: doctorInfo
                                            .data!.isSyndicateCardRequired
                                            .toString()),
                                  ),
                                );
                              },
                            ),
                            _buildStatCard(
                              icon: Icons.post_add,
                              title: 'All Posts',
                              value: doctorInfo?.postsCount.toString() ?? '0',
                              onTap: () {
                                navigatorKey.currentState?.pushNamed(
                                  AppRoutes.allDoctorPosts,
                                  arguments:
                                      AppRoutesArgs.allDoctorPostsRouteArgs(
                                    currentDoctorModel:
                                        widget.currentDoctorModel,
                                    homeDataModel: widget.homeDataModel,
                                    doctorId: widget.doctorId,
                                    doctorName: doctorName(
                                      firstName: doctorInfo!.data!.firstName,
                                      lastName: doctorInfo.data!.lastName,
                                      role: doctorInfo
                                          .data!.isSyndicateCardRequired
                                          .toString(),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: DefaultTabController(
              initialIndex: widget.initialIndex,
              length: 2,
              child: Column(
                children: [
                  ColoredBox(
                    color: Colors.grey.shade200,
                    child: TabBar(
                      labelColor: AppColors.primary,
                      // indicatorColor: Colors.white,
                      indicator: const UnderlineTabIndicator(
                        borderSide: BorderSide(
                          color: AppColors.primary,
                          width: 3,
                        ),
                      ),
                      isScrollable: false,
                      labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                      unselectedLabelColor: Colors.grey.shade500,
                      tabs: const [
                        Tab(
                          text: 'Information',
                        ),
                        Tab(
                          text: 'Achievements',
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        InformationTab(
                          homeDataModel: widget.homeDataModel,
                          currentDoctorModel: widget.currentDoctorModel,
                        ),
                        AchievementsTab(
                          isProfileFeature: false,
                          currentDoctorId:
                              widget.currentDoctorModel.id.toString(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
    required VoidCallback? onTap,
  }) {
    return Material(
      color: Colors.white, // Ensure proper ripple effect
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius:
            BorderRadius.circular(12), // Ensures ripple effect follows shape
        splashColor:
            Colors.blue.withOpacity(0.2), // Customize ripple effect color
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 28, color: AppColors.primary.withOpacity(0.5)),
                const SizedBox(height: 5),
                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
