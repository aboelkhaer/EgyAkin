import '../../../../exports.dart';

class InformationTab extends StatelessWidget {
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;
  const InformationTab(
      {super.key,
      required this.currentDoctorModel,
      required this.homeDataModel});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorInfoViewCubit, DoctorInfoViewState>(
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () {
            return const SizedBox.shrink();
          },
          loaded: (doctorInfo, isLoadingScoreHistory, isLoadedScoreHistory,
              message, scoreHistory, changesCounter) {
            return SingleChildScrollView(
              controller: context
                  .read<DoctorInfoViewCubit>()
                  .doctorInfoViewScrollController,
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding:
                    const EdgeInsets.all(20.0) + EdgeInsets.only(bottom: 50.h),
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
                          doctorInfo!.data!.job ?? 'no data',
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
                        Flexible(
                          child: SelectableText(
                            doctorInfo.data!.workingplace ?? 'no data',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade600),
                          ),
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
                          doctorInfo.data!.specialty ?? 'no data',
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
                          doctorInfo.data!.highestdegree ?? 'no data',
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
                          doctorInfo.data!.email ?? 'no data',
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
                          doctorInfo.data!.phone ?? 'no data',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    AdminSide(
                      homeDataModel: homeDataModel,
                      doctorInfo: doctorInfo,
                    ),
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
