import 'package:animate_do/animate_do.dart';

import '../../../../exports.dart';

class TopDoctors extends StatelessWidget {
  const TopDoctors({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomePatientTitleHeader(
            title: 'Top Doctors',
            patientCount: '',
            leftArrow: '',
            isWithIcon: false,
            rightArrow: '',
            onTap: () {}),
        Container(
          // color: Colors.red,
          margin: EdgeInsets.only(bottom: 10.h),
          height: 110.h,
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return const ShimmerLoadingPatientsCards(
                    ishorizontal: true,
                    isTopDoctor: true,
                  );
                },
                loaded:
                    (homeData, currentDoctorModel, dotsPosition, homeIndex) {
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
                                currentDoctorId:
                                    currentDoctorModel.id.toString(),
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
                                Text(
                                  'Dr.${capitalizeFirstText(doctor.firstName!)}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500),
                                ),
                                // SizedBox(height: 2.h),
                                // Text(
                                //   doctor.score.toString(),
                                //   style: const TextStyle(
                                //       fontWeight: FontWeight.w500),
                                // ),
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
