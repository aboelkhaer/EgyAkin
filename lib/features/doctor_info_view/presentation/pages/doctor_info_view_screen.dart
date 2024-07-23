import 'package:egy_akin/app/shared/functions/custom_bottom_sheet.dart';
import 'package:egy_akin/features/doctor_info_view/presentation/cubit/doctor_info_view_state.dart';
import 'package:egy_akin/features/doctor_info_view/presentation/widgets/achievements_tab.dart';
import 'package:egy_akin/features/doctor_info_view/presentation/widgets/full_screen_image.dart';
import 'package:egy_akin/features/doctor_info_view/presentation/widgets/information_tab.dart';
import 'package:egy_akin/features/score_history/presentation/cubit/score_history_cubit.dart';
import 'package:egy_akin/features/score_history/presentation/pages/score_history_screen.dart';

import '../../../../exports.dart';

class DoctorInfoViewScreen extends StatefulWidget {
  final String doctorId;
  final DoctorModel currentDoctorModel;
  final String isSyndicateCardRequired;
  final bool accountVerification;
  final String currentDoctorRole;
  final int currentDoctorPoints;
  const DoctorInfoViewScreen({
    super.key,
    required this.doctorId,
    required this.currentDoctorModel,
    required this.isSyndicateCardRequired,
    required this.accountVerification,
    required this.currentDoctorRole,
    required this.currentDoctorPoints,
  });

  @override
  State<DoctorInfoViewScreen> createState() => _DoctorInfoViewScreenState();
}

class _DoctorInfoViewScreenState extends State<DoctorInfoViewScreen> {
  @override
  void initState() {
    context
        .read<DoctorInfoViewCubit>()
        .getCurrentDoctorPatients(widget.doctorId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DoctorInfoViewCubit cubit = DoctorInfoViewCubit.get(context);

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 60.h),
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
                        navigatorKey.currentState?.pushReplacementNamed(
                            AppRoutes.home,
                            arguments: 2);
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
                    BlocBuilder<DoctorInfoViewCubit, DoctorInfoViewState>(
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
                          loaded: (doctorInfo, isLoadingScoreHistory,
                              isLoadedScoreHistory, message, scoreHistory) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(80.r),
                              child: GestureDetector(
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
                                child: FadeIn(
                                  duration: const Duration(milliseconds: 300),
                                  child: CircleAvatar(
                                    radius: 45.r,
                                    backgroundColor:
                                        AppColors.primary.withOpacity(0.8),
                                    child: doctorInfo.data!.image == null
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
                      loaded: (doctorInfo, isLoadingScoreHistory,
                          isLoadedScoreHistory, message, scoreHistory) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Dr.${capitalizeFirstText(doctorInfo.data!.firstName!)} ${capitalizeFirstText(doctorInfo.data!.lastName!)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            doctorInfo.data!.isSyndicateCardRequired ==
                                    'Verified'
                                ? Padding(
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
                          capitalizeFirstText(AppStrings.empty),
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 12.sp,
                              color: Colors.grey.shade600),
                        );
                      },
                      loaded: (doctorInfo, isLoadingScoreHistory,
                          isLoadedScoreHistory, message, scoreHistory) {
                        return Text(
                          capitalizeFirstText(
                              doctorInfo.data!.specialty ?? AppStrings.empty),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    BlocBuilder<DoctorInfoViewCubit, DoctorInfoViewState>(
                      builder: (context, state) {
                        return state.maybeWhen(
                          orElse: () {
                            return Text(
                              'Patient',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade600,
                              ),
                            );
                          },
                          loaded: (doctorInfo, isLoadingScoreHistory,
                              isLoadedScoreHistory, message, scoreHistory) {
                            return GestureDetector(
                              onTap: () {
                                navigatorKey.currentState?.pushNamed(
                                  AppRoutes.profilePatients,
                                  arguments:
                                      AppRoutesArgs.profilePatientsRouteArgs(
                                    doctorId: widget.doctorId,
                                    currentDoctorModel:
                                        widget.currentDoctorModel,
                                    accountVerification:
                                        widget.accountVerification,
                                    currentDoctorPoints:
                                        widget.currentDoctorPoints,
                                    isSyndicateCardRequired:
                                        widget.isSyndicateCardRequired,
                                    doctorFirstName:
                                        doctorInfo.data!.firstName.toString(),
                                    currentDoctorRole: widget.currentDoctorRole,
                                  ),
                                );
                              },
                              child: Column(
                                children: [
                                  BlocBuilder<DoctorInfoViewCubit,
                                      DoctorInfoViewState>(
                                    builder: (context, state) {
                                      return state.maybeWhen(
                                        orElse: () {
                                          return const SizedBox.shrink();
                                        },
                                        loaded: (doctorInfo,
                                            isLoadingScoreHistory,
                                            isLoadedScoreHistory,
                                            message,
                                            scoreHistory) {
                                          return Text(
                                              doctorInfo.patientCount
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14.sp));
                                        },
                                      );
                                    },
                                  ),
                                  Text(
                                    'Patient',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        showCustomBottomSheet(
                          context: context,
                          builder: (context) {
                            return BlocProvider(
                              create: (context) => ScoreHistoryCubit(sl()),
                              child: ScoreHistoryScreen(
                                doctorId: widget.doctorId,
                              ),
                            );
                          },
                        );
                      },
                      child: Column(
                        children: [
                          BlocBuilder<DoctorInfoViewCubit, DoctorInfoViewState>(
                            builder: (context, state) {
                              return state.maybeWhen(
                                orElse: () {
                                  return const SizedBox.shrink();
                                },
                                loaded: (doctorInfo,
                                    isLoadingScoreHistory,
                                    isLoadedScoreHistory,
                                    message,
                                    scoreHistory) {
                                  return Text(doctorInfo.scoreValue.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.sp));
                                },
                              );
                            },
                          ),
                          Text(
                            'Score',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: DefaultTabController(
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
                  const Expanded(
                    child: TabBarView(
                      children: [
                        InformationTab(),
                        AchievementsTab(),
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
}
