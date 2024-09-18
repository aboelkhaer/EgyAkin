import '../../../../exports.dart';

class AllPatientSection extends StatelessWidget {
  const AllPatientSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () {
                return HomePatientTitleHeader(
                  title: AppStrings.allPatients,
                  patientCount: '',
                  leftArrow: '',
                  rightArrow: '',
                  onTap: () {},
                );
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
              ) {
                return HomePatientTitleHeader(
                  title: AppStrings.allPatients,
                  patientCount: homeData.allPatientCount.toString(),
                  leftArrow: ' ( ',
                  rightArrow: ' ) ',
                  onTap: () {
                    navigatorKey.currentState?.pushNamed(AppRoutes.allPatients,
                        arguments: AppRoutesArgs.allDoctorsPatientsRouteArgs(
                          accountVerification: homeData.verified!,
                          currentDoctorModel: currentDoctorModel,
                          isSyndicateCardRequired:
                              homeData.isSyndicateCardRequired!,
                          currentDoctorRole: homeData.role.toString(),
                          currentDoctorPoints: int.parse(homeData.scoreValue!),
                          homeDataModel: homeData,
                        ));
                  },
                );
              },
            );
          },
        ),
        SizedBox(height: 10.h),
        BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return const ShimmerLoadingPatientsCards(ishorizontal: true);
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
            ) {
              return FadeIn(
                child: SizedBox(
                  height: homeData.data!.allPatients!.isEmpty ? 100.h : 160.h,
                  child: homeData.data!.allPatients!.isEmpty
                      // ? Lottie.asset(AppImages.imageLoader, width: 150.w)
                      ? Image.asset(
                          AppImages.notFound,
                          width: 90.w,
                        )
                      : ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.zero,
                          itemCount: homeData.data!.allPatients!.length < 5
                              ? homeData.data!.allPatients!.length
                              : 5,
                          itemBuilder: (BuildContext context, int index) {
                            var patient = homeData.data!.allPatients![index];

                            return PatientCard(
                              patientName: patient.name ?? AppStrings.empty,
                              drFirstName:
                                  patient.doctor!.firstName ?? AppStrings.empty,
                              isAllDataOpen: false,
                              doctorId: patient.doctor!.id.toString(),
                              homeDataModel: homeData,
                              drLastName:
                                  patient.doctor!.lastName ?? AppStrings.empty,
                              updatedAt: patient.updatedAt ?? AppStrings.empty,
                              accountVerification:
                                  patient.doctor!.emailVerifiedAt == null
                                      ? false
                                      : true,
                              hospital: patient.hospital ?? AppStrings.empty,
                              currentDoctorModel: currentDoctorModel,
                              currentDoctorPoints:
                                  int.parse(homeData.scoreValue!),
                              currentDoctorRole: homeData.role.toString(),
                              isSyndicateCardRequired:
                                  patient.doctor!.isSyndicateCardRequired!,
                              doctorImage: patient.doctor!.image,
                              submitStatus: patient.sections == null
                                  ? false
                                  : patient.sections!.submitStatus ?? false,
                              isOutcomeStatus: patient.sections!.outcomeStatus!,
                              onOutcomeTap: () {
                                navigatorKey.currentState?.pushNamed(
                                  AppRoutes.outcome,
                                  arguments: AppRoutesArgs.outcomeRouteArgs(
                                    verified: homeData.verified!,
                                    outcomeStatus:
                                        patient.sections!.outcomeStatus!,
                                    patientName: patient.name.toString(),
                                    patientId: patient.id.toString(),
                                    currentDoctorModel: currentDoctorModel,
                                    doctorId: patient.doctor!.id.toString(),
                                    isSyndicateCardRequired:
                                        homeData.isSyndicateCardRequired!,
                                    currentDoctorRole: homeData.role.toString(),
                                    currentDoctorPoints:
                                        int.parse(homeData.scoreValue!),
                                    homeDataModel: homeData,
                                  ),
                                );
                              },
                              onAddCommentTap: () {
                                navigatorKey.currentState?.pushNamed(
                                  AppRoutes.comments,
                                  arguments: AppRoutesArgs
                                      .patientCommentsRouteArgs(
                                          patientId: patient.id.toString(),
                                          currentDoctorModel:
                                              currentDoctorModel,
                                          verified: homeData.verified!,
                                          patientName: patient.name.toString(),
                                          currentDoctorPoints:
                                              int.parse(homeData.scoreValue!),
                                          currentDoctorRole:
                                              homeData.role.toString(),
                                          homeDataModel: homeData,
                                          isSyndicateCardRequired: homeData
                                              .isSyndicateCardRequired!),
                                );
                              },
                              onTap: () {
                                navigatorKey.currentState?.pushNamed(
                                  AppRoutes.patientSections,
                                  arguments: AppRoutesArgs
                                      .patientSectionsRouteArguments(
                                    patientId: patient.id.toString(),
                                    currentDoctorRole: homeData.role.toString(),
                                    currentDoctorPoints:
                                        int.parse(homeData.scoreValue!),
                                    currentDoctorModel: currentDoctorModel,
                                    homeDataModel: homeData,
                                    isAllDataOpen: false,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                ),
              );
            },
          );
        }),
      ],
    );
  }
}
