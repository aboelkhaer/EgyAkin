import 'package:egy_akin/exports.dart';
import 'package:egy_akin/features/doctor_info_view/data/models/doctor_info_view_model_response.dart';
import 'package:timeago/timeago.dart' as timeago;

class AdminSide extends StatelessWidget {
  final HomeModelResponse homeDataModel;
  final DoctorInfoViewModelResponse doctorInfo;

  const AdminSide(
      {super.key, required this.homeDataModel, required this.doctorInfo});

  @override
  Widget build(BuildContext context) {
    return homeDataModel.role == 'Admin'
        ? Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                margin: EdgeInsets.only(top: 12.h),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.primary,
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Age:',
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
                          doctorInfo.data!.age.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    Row(
                      children: [
                        Text(
                          'ID:',
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
                          doctorInfo.data!.id.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    Row(
                      children: [
                        Text(
                          'Join us:',
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
                          timeago
                              .format(DateTime.parse(
                                  doctorInfo.data!.createdAt.toString()))
                              .toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    Row(
                      children: [
                        Text(
                          'Email verification:',
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
                          doctorInfo.data!.emailVerifiedAt == null
                              ? 'No data'
                              : timeago
                                  .format(DateTime.parse(doctorInfo
                                      .data!.emailVerifiedAt
                                      .toString()))
                                  .toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    Row(
                      children: [
                        Text(
                          'Blocked:',
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
                          doctorInfo.data!.blocked.toString() == 'false'
                              ? 'No'
                              : 'Yes',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    Row(
                      children: [
                        Text(
                          'Registration number:',
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
                          doctorInfo.data!.registrationNumber ?? 'No Data',
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
                          'Syndicate card status:',
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
                          doctorInfo.data!.isSyndicateCardRequired.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    Row(
                      children: [
                        Text(
                          'Syndicate Card:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 8.h),
                    doctorInfo.data!.syndicateCard == null
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 60.w),
                              SelectableText(
                                'No syndicate card yet.',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FullScreenImage(
                                        imageUrl: doctorInfo.data!.syndicateCard
                                            .toString()
                                            .toString(),
                                      ),
                                    ),
                                  );
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: CustomCachedNetworkImage(
                                    imageUrl: doctorInfo.data!.syndicateCard
                                        .toString(),
                                    height: 100.h,
                                    width: 260.w,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              )
                            ],
                          ),
                    SizedBox(height: 15.h),
                  ],
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.grey.shade100,
                    child: Text(
                      'Admin side',
                      style: TextStyle(
                          fontSize: 12.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          )
        : const SizedBox.shrink();
  }
}
