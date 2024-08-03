import '../../../../exports.dart';

class YourPatientSection extends StatelessWidget {
  const YourPatientSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () {
                return HomePatientTitleHeader(
                    title: AppStrings.yourPatients,
                    patientCount: '',
                    leftArrow: '',
                    rightArrow: '',
                    onTap: () {});
              },
              loaded: (homeData, currentDoctorModel, dotsPosition, homeIndex,
                  isUploadingSyndicateCard, isUploadedSyndicateCard, message) {
                return HomePatientTitleHeader(
                  title: AppStrings.yourPatients,
                  patientCount: homeData.doctorPatientCount.toString(),
                  leftArrow: ' ( ',
                  rightArrow: ' ) ',
                  onTap: () {
                    navigatorKey.currentState?.pushNamed(
                        AppRoutes.currentPatients,
                        arguments: AppRoutesArgs.currentDoctorPatientsRouteArgs(
                          accountVerification: homeData.verified!,
                          currentDoctorModel: currentDoctorModel,
                          isSyndicateCardRequired:
                              homeData.isSyndicateCardRequired!,
                          currentDoctorPoints: int.parse(homeData.scoreValue!),
                          currentDoctorRole: homeData.role.toString(),
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
            loaded: (homeData, currentDoctorModel, dotsPosition, homeIndex,
                isUploadingSyndicateCard, isUploadedSyndicateCard, message) {
              return FadeIn(
                duration: const Duration(seconds: 2),
                child: SizedBox(
                  height:
                      homeData.data!.currentPatients!.isEmpty ? 100.h : 160.h,
                  child: homeData.data!.currentPatients!.isEmpty
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
                          itemCount: homeData.data!.currentPatients!.length < 5
                              ? homeData.data!.currentPatients!.length
                              : 5,
                          itemBuilder: (BuildContext context, int index) {
                            var patient =
                                homeData.data!.currentPatients![index];

                            return PatientCard(
                              patientName: patient.name ?? AppStrings.empty,
                              drFirstName:
                                  patient.doctor!.firstName ?? AppStrings.empty,
                              homeDataModel: homeData,
                              drLastName:
                                  patient.doctor!.lastName ?? AppStrings.empty,
                              accountVerification: homeData.verified!,
                              updatedAt: patient.updatedAt ?? AppStrings.empty,
                              hospital: patient.hospital ?? AppStrings.empty,
                              currentDoctorModel: currentDoctorModel,
                              isSyndicateCardRequired:
                                  patient.doctor!.isSyndicateCardRequired!,
                              currentDoctorPoints:
                                  int.parse(homeData.scoreValue!),
                              currentDoctorRole: homeData.role.toString(),
                              doctorId: patient.doctor!.id.toString(),
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
                                      homeDataModel: homeData,
                                      currentDoctorPoints:
                                          int.parse(homeData.scoreValue!),
                                      currentDoctorRole:
                                          homeData.role.toString()),
                                );
                              },
                              onAddCommentTap: () {
                                navigatorKey.currentState?.pushNamed(
                                  AppRoutes.comments,
                                  arguments:
                                      AppRoutesArgs.patientCommentsRouteArgs(
                                    patientId: patient.id.toString(),
                                    currentDoctorModel: currentDoctorModel,
                                    verified: homeData.verified!,
                                    patientName: patient.name.toString(),
                                    currentDoctorPoints:
                                        int.parse(homeData.scoreValue!),
                                    isSyndicateCardRequired:
                                        homeData.isSyndicateCardRequired!,
                                    currentDoctorRole: homeData.role.toString(),
                                  ),
                                );
                              },
                              onTap: () {
                                navigatorKey.currentState?.pushNamed(
                                  AppRoutes.patientSections,
                                  arguments: AppRoutesArgs
                                      .patientSectionsRouteArguments(
                                    patientId: patient.id.toString(),
                                    currentDoctorPoints:
                                        int.parse(homeData.scoreValue!),
                                    currentDoctorModel: currentDoctorModel,
                                    currentDoctorRole: homeData.role.toString(),
                                    homeDataModel: homeData,
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
