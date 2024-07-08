import 'package:egy_akin/app/shared/functions/custom_bottom_sheet.dart';
import 'package:egy_akin/exports.dart';
import 'package:egy_akin/features/score_history/presentation/cubit/score_history_cubit.dart';
import 'package:egy_akin/features/score_history/presentation/pages/score_history_screen.dart';

class ProfileNameAndJob extends StatelessWidget {
  final ProfileCubit cubit;
  final String isSyndicateCardRequired;
  final bool accountVerification;

  const ProfileNameAndJob({
    super.key,
    required this.cubit,
    required this.isSyndicateCardRequired,
    required this.accountVerification,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          error: (message) {
            customSnackBar(message: message, context: context);
          },
        );
      },
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () {
            if (cubit.currentDoctor.firstName == null ||
                cubit.currentDoctor.lastName == null) {
              return const SizedBox.shrink();
            }
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Dr.${capitalizeFirstText(cubit.currentDoctor.firstName!)} ${capitalizeFirstText(cubit.currentDoctor.lastName!)}',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    isSyndicateCardRequired == 'Verified'
                        ? const VerificationIcon(
                            duration: 300,
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
                SizedBox(height: 3.h),
                Text(
                  capitalizeFirstText(
                      cubit.currentDoctor.specialty ?? AppStrings.empty),
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade700,
                  ),
                ),
                SizedBox(height: 3.h),
                BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // navigatorKey.currentState?.pushNamed(
                            //   AppRoutes.profilePatients,
                            //   arguments: AppRoutesArgs.profilePatientsRouteArgs(
                            //     doctorId: cubit.currentDoctor.id.toString(),
                            //     currentDoctorModel: cubit.currentDoctor,
                            //     accountVerification: accountVerification,
                            //     isSyndicateCardRequired:
                            //         isSyndicateCardRequired,
                            //     doctorFirstName:
                            //         cubit.currentDoctor.firstName.toString(),
                            //   ),
                            // );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                context
                                    .read<HomeCubit>()
                                    .doctorPatientCount
                                    .toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade600,
                                  fontSize: 12.sp,
                                ),
                              ),
                              SizedBox(width: 3.w),
                              Text(
                                'Patient',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade600,
                                  fontSize: 12.sp,
                                ),
                              ),
                              SizedBox(width: 10.w),
                            ],
                          ),
                        ),
                        const Text('|'),
                        GestureDetector(
                          onTap: () {
                            showCustomBottomSheet(
                              context: context,
                              builder: (context) {
                                return BlocProvider(
                                  create: (context) => ScoreHistoryCubit(sl()),
                                  child: ScoreHistoryScreen(
                                    doctorId: cubit.currentDoctor.id.toString(),
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(width: 10.w),
                                Text(
                                  context
                                      .read<HomeCubit>()
                                      .doctorScore
                                      .toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey.shade600,
                                    fontSize: 12.sp,
                                  ),
                                ),
                                SizedBox(width: 3.w),
                                Text(
                                  'Score',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey.shade600,
                                    fontSize: 12.sp,
                                  ),
                                ),
                                // SizedBox(width: 5.w),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            );
          },
          loaded: (doctorModel, isLoadedImage) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Dr.${capitalizeFirstText(doctorModel.firstName!)} ${capitalizeFirstText(doctorModel.lastName!)}',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    isSyndicateCardRequired == 'Verified'
                        ? const VerificationIcon(
                            duration: 300,
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
                SizedBox(height: 3.h),
                Text(
                  capitalizeFirstText(
                      doctorModel.specialty ?? AppStrings.empty),
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade700,
                  ),
                ),
                SizedBox(height: 3.h),
                BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            navigatorKey.currentState?.pushNamed(
                              AppRoutes.profilePatients,
                              arguments: AppRoutesArgs.profilePatientsRouteArgs(
                                doctorId: cubit.currentDoctor.id.toString(),
                                currentDoctorModel: cubit.currentDoctor,
                                accountVerification: accountVerification,
                                isSyndicateCardRequired:
                                    isSyndicateCardRequired,
                                doctorFirstName:
                                    cubit.currentDoctor.firstName.toString(),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                context
                                    .read<HomeCubit>()
                                    .doctorPatientCount
                                    .toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade600,
                                  fontSize: 12.sp,
                                ),
                              ),
                              SizedBox(width: 3.w),
                              Text(
                                'Patient',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade600,
                                  fontSize: 12.sp,
                                ),
                              ),
                              SizedBox(width: 10.w),
                            ],
                          ),
                        ),
                        const Text('|'),
                        GestureDetector(
                          onTap: () {
                            showCustomBottomSheet(
                              context: context,
                              builder: (context) {
                                return BlocProvider(
                                  create: (context) => ScoreHistoryCubit(sl()),
                                  child: ScoreHistoryScreen(
                                    doctorId: cubit.currentDoctor.id.toString(),
                                  ),
                                );
                              },
                            );
                          },
                          child: GestureDetector(
                            onTap: () {
                              showCustomBottomSheet(
                                context: context,
                                builder: (context) {
                                  return BlocProvider(
                                    create: (context) =>
                                        ScoreHistoryCubit(sl()),
                                    child: ScoreHistoryScreen(
                                      doctorId:
                                          cubit.currentDoctor.id.toString(),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(width: 10.w),
                                  Text(
                                    context
                                        .read<HomeCubit>()
                                        .doctorScore
                                        .toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey.shade600,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                  SizedBox(width: 3.w),
                                  Text(
                                    'Score',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey.shade600,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                  // SizedBox(width: 5.w),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
