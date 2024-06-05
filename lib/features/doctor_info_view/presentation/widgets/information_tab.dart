import 'package:egy_akin/features/doctor_info_view/presentation/cubit/doctor_info_view_cubit.dart';
import 'package:egy_akin/features/doctor_info_view/presentation/cubit/doctor_info_view_state.dart';

import '../../../../exports.dart';

class InformationTab extends StatelessWidget {
  const InformationTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorInfoViewCubit, DoctorInfoViewState>(
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () {
            return const SizedBox.shrink();
          },
          loaded: (doctorInfo) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Job:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 60.w),
                        SelectableText(
                          doctorInfo.data!.job.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    Row(
                      children: [
                        Text(
                          'Work place:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 60.w),
                        SelectableText(
                          doctorInfo.data!.workingplace.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    Row(
                      children: [
                        Text(
                          'Specialty:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 60.w),
                        SelectableText(
                          doctorInfo.data!.specialty.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    Row(
                      children: [
                        Text(
                          'Highest degree:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 60.w),
                        SelectableText(
                          doctorInfo.data!.highestdegree.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    Row(
                      children: [
                        Text(
                          'Email:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 60.w),
                        SelectableText(
                          doctorInfo.data!.email.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    Row(
                      children: [
                        Text(
                          'Phone:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 60.w),
                        SelectableText(
                          doctorInfo.data!.phone.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.h),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
