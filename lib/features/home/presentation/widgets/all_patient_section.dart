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
              loaded: (homeData, currentDoctorModel, dotsPosition, homeIndex) {
                return HomePatientTitleHeader(
                  title: AppStrings.allPatients,
                  patientCount: homeData.allPatientCount.toString(),
                  leftArrow: ' ( ',
                  rightArrow: ' ) ',
                  onTap: () {},
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
            loaded: (homeData, currentDoctorModel, dotsPosition, homeIndex) {
              return SizedBox(
                height: 160.h,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.zero,
                  itemCount: homeData.data!.allPatients!.length < 5
                      ? homeData.data!.allPatients!.length
                      : 5,
                  itemBuilder: (BuildContext context, int index) {
                    var patient = homeData.data!.allPatients![index];

                    return VerticalPatientCard(
                      patientName: patient.name ?? AppStrings.empty,
                      drFirstName:
                          patient.doctor!.firstName ?? AppStrings.empty,
                      drLastName: patient.doctor!.lastName ?? AppStrings.empty,
                      updatedAt: patient.updatedAt ?? AppStrings.empty,
                      hospital: patient.hospital ?? AppStrings.empty,
                      submitStatus: patient.sections == null
                          ? false
                          : patient.sections!.submitStatus ?? false,
                      isOutcomeStatus: patient.sections!.outcomeStatus!,
                      onOutcomeTap: () {
                        //   Get.toNamed(
                        //   AppRoutes.outcome,
                        //   arguments: [
                        //     patient
                        //         .sections!.outcomeStatus,
                        //     patient.id,
                        //     patient.name
                        //   ],
                        // );
                      },
                      onAddCommentTap: () {
                        navigatorKey.currentState?.pushNamed(
                          AppRoutes.comments,
                          arguments: AppRoutesArgs.patientCommentsRouteArgs(
                            patientId: patient.id.toString(),
                            currentDoctorModel: currentDoctorModel,
                            verified: homeData.verified!,
                          ),
                        );
                      },
                      onTap: () {
                        navigatorKey.currentState?.pushNamed(
                          AppRoutes.patientSections,
                          arguments:
                              AppRoutesArgs.patientSectionsRouteArguments(
                            patientId: patient.id.toString(),
                            currentDoctorId: currentDoctorModel.id.toString(),
                          ),
                        );
                      },
                    );
                  },
                ),
              );
            },
          );
        }),
      ],
    );
  }
}
