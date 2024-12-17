import '../../../../exports.dart';

class TopDoctors extends StatelessWidget {
  final HomeCubit cubit;
  const TopDoctors({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        cubit.currentDoctorModel.email == 'aboelkhaer@yandex.com'
            ? const SizedBox.shrink()
            : HomePatientTitleHeader(
                title: 'Top Doctors',
                patientCount: '',
                leftArrow: '',
                isWithIcon: false,
                rightArrow: '',
                onTap: () {}),
        Container(
          // color: Colors.red,
          margin: EdgeInsets.only(bottom: 10.h),
          height: 105.h,
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return const ShimmerLoadingPatientsCards(
                    ishorizontal: true,
                    isTopDoctor: true,
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
                  isUserBlocked,
                ) {
                  if (currentDoctorModel.email == 'aboelkhaer@yandex.com') {
                    return const SizedBox.shrink();
                  }
                  return FadeIn(
                    duration: const Duration(seconds: 2),
                    child: ListView.builder(
                      itemCount: homeData.data!.topDoctors!.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        DoctorModel doctor = homeData.data!.topDoctors![index];
                        return GestureDetector(
                          onTap: () {
                            navigatorKey.currentState?.pushNamed(
                              AppRoutes.doctorInfoView,
                              arguments: AppRoutesArgs.doctorInfoViewRouteArgs(
                                doctorId: doctor.id.toString(),
                                currentDoctorModel: currentDoctorModel,
                                currentDoctorPoints:
                                    int.parse(homeData.scoreValue!),
                                accountVerification: homeData.verified!,
                                initialIndex: 0,
                                isSyndicateCardRequired:
                                    homeData.isSyndicateCardRequired.toString(),
                                currentDoctorRole: homeData.role.toString(),
                                homeDataModel: homeData,
                                isNavigateToTheButtonOfInformationTab: false,
                              ),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 10.w),
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 3),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.4),
                                        spreadRadius: 5,
                                        blurRadius: 9,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(80.r),
                                    child: CircleAvatar(
                                      radius: 20.r,
                                      backgroundColor:
                                          AppColors.primary.withOpacity(0.8),
                                      child: doctor.image == null
                                          ? Text(
                                              doctor.firstName == null
                                                  ? ''
                                                  : doctor.firstName![0]
                                                      .toUpperCase(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.sp),
                                            )
                                          : CustomCachedNetworkImage(
                                              imageUrl: doctor.image.toString(),
                                              height: 100.h,
                                              width: 100.w,
                                            ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 9.h),
                                Text(
                                  '#${index + 1}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13.sp),
                                ),
                                SizedBox(height: 2.h),
                                Row(
                                  children: [
                                    Text(
                                      'Dr.${capitalizeFirstText(doctor.firstName!)}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    doctor.isSyndicateCardRequired == 'Verified'
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
        ),
      ],
    );
  }
}
