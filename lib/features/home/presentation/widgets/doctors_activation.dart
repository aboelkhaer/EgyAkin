import 'package:egy_akin/app/shared/functions/permissions_helper.dart';

import '../../../../exports.dart';

class DoctorsActivation extends StatefulWidget {
  const DoctorsActivation({super.key});

  @override
  State<DoctorsActivation> createState() => _DoctorsActivationState();
}

class _DoctorsActivationState extends State<DoctorsActivation> {
  @override
  void initState() {
    super.initState();
    PermissionHelper.refreshPermissions().then((_) {
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    HomeCubit cubit = HomeCubit.get(context);

    if (!PermissionHelper.canPermission(
        AppPermissions.viewDoctorActivationForAdmin)) {
      return const SizedBox.shrink();
    }

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () {
            return const SizedBox.shrink();
          },
          loaded: (
            homeData,
            currentDoctorModel,
            dotsPosition,
            homeIndex,
            isUploadingSyndicateCard,
            isUploadedSyndicateCard,
            message,
            checkUpdateMessageCounter,
            isUserBlocked,
            changesCounter,
          ) {
            // if (!isAdmin(homeData.role)) {
            //   return const SizedBox.shrink();
            // }
            if (cubit.homeDataModel.data!.pendingSyndicateCard!.isEmpty) {
              return const SizedBox.shrink();
            }
            return Column(
              children: [
                SizedBox(height: 10.h),
                HomePatientTitleHeader(
                    title: 'Doctors activation',
                    patientCount: '',
                    leftArrow: '',
                    isWithIcon: false,
                    rightArrow: '',
                    onTap: () {}),
                SizedBox(
                  // margin: EdgeInsets.only(bottom: 10.h),
                  height: 90.h,
                  child: BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        orElse: () {
                          return const SizedBox.shrink();
                        },
                        loaded: (
                          homeData,
                          currentDoctorModel,
                          dotsPosition,
                          homeIndex,
                          isUploadingSyndicateCard,
                          isUploadedSyndicateCard,
                          message,
                          checkUpdateMessageCounter,
                          isUserBlocked,
                          changesCounter,
                        ) {
                          // if (!isAdmin(homeData.role)) {
                          //   return const SizedBox.shrink();
                          // }
                          return FadeIn(
                            duration: const Duration(seconds: 2),
                            child: ListView.builder(
                              itemCount: cubit.homeDataModel.data!
                                  .pendingSyndicateCard!.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                DoctorModel doctor = cubit.homeDataModel.data!
                                    .pendingSyndicateCard![index];
                                return GestureDetector(
                                  onTap: () {
                                    navigatorKey.currentState?.pushNamed(
                                      AppRoutes.doctorInfoView,
                                      arguments:
                                          AppRoutesArgs.doctorInfoViewRouteArgs(
                                        doctorId: doctor.id.toString(),
                                        currentDoctorModel: currentDoctorModel,
                                        currentDoctorPoints: int.parse(
                                            cubit.homeDataModel.scoreValue!),
                                        accountVerification:
                                            cubit.homeDataModel.verified!,
                                        initialIndex: 0,
                                        isSyndicateCardRequired: cubit
                                            .homeDataModel
                                            .isSyndicateCardRequired
                                            .toString(),
                                        currentDoctorRole:
                                            cubit.homeDataModel.role.toString(),
                                        homeDataModel: cubit.homeDataModel,
                                        isNavigateToTheButtonOfInformationTab:
                                            true,
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(right: 10.w),
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(top: 3),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.4),
                                                spreadRadius: 5,
                                                blurRadius: 9,
                                                offset: const Offset(0, 3),
                                              ),
                                            ],
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(80.r),
                                            child: CircleAvatar(
                                              radius: 20.r,
                                              backgroundColor: AppColors.primary
                                                  .withOpacity(0.8),
                                              child: doctor.image == null
                                                  ? Text(
                                                      doctor.firstName == null
                                                          ? ''
                                                          : doctor.firstName![0]
                                                              .toUpperCase(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16.sp),
                                                    )
                                                  : CustomCachedNetworkImage(
                                                      imageUrl: doctor.image
                                                          .toString(),
                                                      height: 100.h,
                                                      width: 100.w,
                                                    ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 9.h),
                                        Row(
                                          children: [
                                            Text(
                                              'Dr.${capitalizeFirstText(doctor.firstName!)}',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            doctor.isSyndicateCardRequired ==
                                                    'Verified'
                                                ? const VerificationIcon(
                                                    isSmaller: true,
                                                  )
                                                : const SizedBox.shrink(),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                )
              ],
            );
          },
        );
      },
    );
  }
}
