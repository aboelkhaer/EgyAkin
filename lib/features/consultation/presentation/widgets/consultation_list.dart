import '../../../../exports.dart';

class ConsultationList extends StatelessWidget {
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;
  final bool isReceivedConsultation;
  final bool isDarkMode;

  final List<GetCurrentDoctorConsultationModelResponse> consultations;
  const ConsultationList(
      {super.key,
      required this.consultations,
      required this.currentDoctorModel,
      required this.homeDataModel,
      required this.isReceivedConsultation,
      this.isDarkMode = false});

  @override
  Widget build(BuildContext context) {
    return consultations.isEmpty
        ? Center(
            child: Image.asset(
              AppImages.notFound,
              width: 150.h,
              height: 150.h,
            ),
          )
        : ListView.builder(
            itemCount: consultations.length,
            shrinkWrap: true,
            padding: EdgeInsets.only(bottom: 50.h, top: 12.h),
            itemBuilder: (context, index) {
              var consult = consultations[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Card(
                  color: isDarkMode ? AppColors.darkCardBG : Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    splashColor:
                        isDarkMode ? AppColors.darkBorder : AppColors.subBG,
                    onTap: () {
                      navigatorKey.currentState?.pushNamed(
                        AppRoutes.consultationDetails,
                        arguments: AppRoutesArgs.consultationDetailsRouteArgs(
                          homeDataModel: homeDataModel,
                          currentDoctorModel: currentDoctorModel,
                          patientName: consult.patientName.toString(),
                          consultationId: consult.id.toString(),
                          isReceivedConsultation: isReceivedConsultation,
                          isOpen: consult.isOpen ?? false,
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.4),
                                              spreadRadius: 2,
                                              blurRadius: 9,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(80.r),
                                          child: GestureDetector(
                                            onTap: () {
                                              navigatorKey.currentState
                                                  ?.pushNamed(
                                                AppRoutes.doctorInfoView,
                                                arguments: AppRoutesArgs
                                                    .doctorInfoViewRouteArgs(
                                                  initialIndex: 0,
                                                  doctorId: consult.doctorId
                                                      .toString(),
                                                  currentDoctorModel:
                                                      currentDoctorModel,
                                                  isSyndicateCardRequired:
                                                      homeDataModel
                                                          .isSyndicateCardRequired
                                                          .toString(),
                                                  accountVerification:
                                                      homeDataModel.verified!,
                                                  currentDoctorRole:
                                                      homeDataModel.role!,
                                                  currentDoctorPoints:
                                                      int.parse(homeDataModel
                                                          .scoreValue
                                                          .toString()),
                                                  homeDataModel: homeDataModel,
                                                  isNavigateToTheButtonOfInformationTab:
                                                      false,
                                                ),
                                              );
                                            },
                                            child: CircleAvatar(
                                              radius: 20.r,
                                              backgroundColor: AppColors.primary
                                                  .withOpacity(0.8),
                                              child: CustomCachedNetworkImage(
                                                imageUrl:
                                                    consult.image.toString(),
                                                height: 40.h,
                                                width: 40.w,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 8.w),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 190.w,
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      doctorName(
                                                        firstName: consult
                                                            .doctorFirstName,
                                                        lastName: consult
                                                            .doctorLastName,
                                                        role: consult
                                                            .isSyndicateCard
                                                            .toString(),
                                                      ),
                                                      style: TextStyle(
                                                        color: currentDoctorModel
                                                                    .id
                                                                    .toString() ==
                                                                consult.doctorId
                                                                    .toString()
                                                            ? Colors.green
                                                            : isDarkMode
                                                                ? AppColors
                                                                    .darkTitle
                                                                : Colors.grey
                                                                    .shade700,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12.sp,
                                                      ),
                                                    ),
                                                    if (consult
                                                            .isSyndicateCard ==
                                                        'Verified')
                                                      const VerificationIcon(
                                                        duration: 300,
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 3.h),
                                          SizedBox(
                                            width: 190.w,
                                            child: Text(
                                              '${consult.consultMessage}',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12.sp,
                                                color: isDarkMode
                                                    ? AppColors.darkDescription
                                                    : Colors.grey.shade500,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          SizedBox(height: 8.h),
                                          Container(
                                            width: 200.w,
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: isDarkMode
                                                  ? AppColors.darkBorder
                                                  : AppColors.primary
                                                      .withOpacity(0.05),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              '${context.tr(AppStrings.thePatient)}: ${consult.patientName}',
                                              style: TextStyle(
                                                color: isDarkMode
                                                    ? AppColors.darkDescription
                                                    : Colors.grey.shade700,
                                                fontSize: 10.sp,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              // Expanded(
                              //   child: Tooltip(
                              //     message: consult.status == 'pending'
                              //         ? context.tr(AppStrings.pending)
                              //         : context.tr(AppStrings.completed),

                              //     child: Icon(
                              //       consult.status == 'pending'
                              //           ? AppIcons.isFinalNotSubmit
                              //           : AppIcons.isFinalSubmit,
                              //       color: consult.status == 'pending'
                              //           ? Colors.amber
                              //           : AppColors.primary.withOpacity(0.7),
                              //     ),
                              //   ),
                              // )
                              Expanded(
                                child: Tooltip(
                                  message: (consult.isOpen ?? false)
                                      ? context.tr(AppStrings.opened)
                                      : context.tr(AppStrings.closed),
                                  child: Icon(
                                    (consult.isOpen ?? false)
                                        ? AppIcons.consultationOpened
                                        : AppIcons.consultationClosed,
                                    color: (consult.isOpen ?? false)
                                        ? Colors.green
                                        : Colors.red.withOpacity(0.7),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                TimeAgoService.instance.formatTimeAgoFromString(
                                    consult.createdAt.toString(), context),
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.darkDescription
                                      : AppColors.description,
                                  fontSize: 9.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
  }
}
