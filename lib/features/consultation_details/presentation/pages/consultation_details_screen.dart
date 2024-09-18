import 'dart:developer';

import 'package:egy_akin/features/consultation_details/presentation/cubit/consultation_details_cubit.dart';
import 'package:egy_akin/features/consultation_details/presentation/cubit/consultation_details_state.dart';
import 'package:readmore/readmore.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../exports.dart';

class ConsultationDetailsScreen extends StatefulWidget {
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;
  final String patientName;
  final String consultationId;
  final bool isReceivedConsultation;
  const ConsultationDetailsScreen(
      {super.key,
      required this.currentDoctorModel,
      required this.homeDataModel,
      required this.isReceivedConsultation,
      required this.consultationId,
      required this.patientName});

  @override
  State<ConsultationDetailsScreen> createState() =>
      _ConsultationDetailsScreenState();
}

class _ConsultationDetailsScreenState extends State<ConsultationDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<ConsultationDetailsCubit>()
        .getConsultationDetails(widget.consultationId.toString());
  }

  @override
  Widget build(BuildContext context) {
    ConsultationDetailsCubit cubit = ConsultationDetailsCubit.get(context);
    log(widget.isReceivedConsultation.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.patientName.toString()),
      ),
      body: BlocConsumer<ConsultationDetailsCubit, ConsultationDetailsState>(
        listener: (context, state) {
          state.maybeWhen(
            orElse: () {},
            error: (message) {
              customSnackBar(context: context, message: message);
            },
            loaded: (consultDetails, newCommentValue, isSendingConsultation,
                isSendedConsultation, message) {
              if (message != '') {
                customSnackBar(context: context, message: message);
              }
              if (isSendedConsultation) {
                cubit.getConsultationDetails(widget.consultationId.toString());
              }
            },
          );
        },
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            loaded: (consultDetails, newConsultationValue,
                isSendingConsultation, isSendedConsultation, message) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(
                              left: 20, top: 20, right: 20),
                          decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(10)),
                          child: ReadMoreText(
                            '${consultDetails.consultMessage}',
                            trimMode: TrimMode.Line,
                            trimLines: 2,
                            colorClickableText: Colors.blue,
                            trimCollapsedText: ' See more ',
                            trimExpandedText: ' See less ',
                            moreStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.blue,
                              fontSize: 11.sp,
                            ),
                            lessStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.blue,
                              fontSize: 11.sp,
                            ),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.sp,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: PatientCard(
                            patientName:
                                consultDetails.patientModel!.name.toString(),
                            drFirstName: consultDetails
                                .patientModel!.doctor!.firstName
                                .toString(),
                            isAllDataOpen: true,
                            drLastName: consultDetails
                                .patientModel!.doctor!.lastName
                                .toString(),
                            isOutcomeStatus: consultDetails
                                .patientModel!.sections!.outcomeStatus!,
                            hospital: consultDetails.patientModel!.hospital
                                .toString(),
                            submitStatus: consultDetails
                                .patientModel!.sections!.submitStatus!,
                            updatedAt: consultDetails.patientModel!.updatedAt
                                .toString(),
                            doctorImage: consultDetails
                                .patientModel!.doctor!.image
                                .toString(),
                            doctorId: consultDetails.patientModel!.doctor!.id
                                .toString(),
                            currentDoctorModel: widget.currentDoctorModel,
                            isSyndicateCardRequired: consultDetails
                                .patientModel!.doctor!.isSyndicateCardRequired
                                .toString(),
                            accountVerification: consultDetails.patientModel!
                                        .doctor!.emailVerifiedAt ==
                                    null
                                ? false
                                : true,
                            currentDoctorRole:
                                widget.homeDataModel.role.toString(),
                            currentDoctorPoints: int.parse(
                                widget.homeDataModel.scoreValue.toString()),
                            homeDataModel: widget.homeDataModel,
                            onAddCommentTap: () {
                              navigatorKey.currentState?.pushNamed(
                                AppRoutes.comments,
                                arguments: AppRoutesArgs
                                    .patientCommentsRouteArgs(
                                        patientId: consultDetails
                                            .patientModel!.id
                                            .toString(),
                                        currentDoctorModel: widget
                                            .currentDoctorModel,
                                        verified: widget
                                            .homeDataModel.verified!,
                                        patientName: consultDetails
                                            .patientModel!.name
                                            .toString(),
                                        currentDoctorPoints: int.parse(widget
                                            .homeDataModel.scoreValue!),
                                        currentDoctorRole: widget
                                            .homeDataModel.role
                                            .toString(),
                                        homeDataModel: widget.homeDataModel,
                                        isSyndicateCardRequired: widget
                                            .homeDataModel
                                            .isSyndicateCardRequired!),
                              );
                            },
                            onOutcomeTap: () {
                              navigatorKey.currentState?.pushNamed(
                                AppRoutes.outcome,
                                arguments: AppRoutesArgs.outcomeRouteArgs(
                                  verified: widget.homeDataModel.verified!,
                                  outcomeStatus: consultDetails
                                      .patientModel!.sections!.outcomeStatus!,
                                  patientName: consultDetails.patientModel!.name
                                      .toString(),
                                  patientId: consultDetails.patientModel!.id
                                      .toString(),
                                  currentDoctorModel: widget.currentDoctorModel,
                                  doctorId: consultDetails
                                      .patientModel!.doctor!.id
                                      .toString(),
                                  isSyndicateCardRequired: widget
                                      .homeDataModel.isSyndicateCardRequired!,
                                  currentDoctorRole:
                                      widget.homeDataModel.role.toString(),
                                  currentDoctorPoints: int.parse(
                                      widget.homeDataModel.scoreValue!),
                                  homeDataModel: widget.homeDataModel,
                                ),
                              );
                            },
                            onTap: () {
                              navigatorKey.currentState?.pushNamed(
                                AppRoutes.patientSections,
                                arguments:
                                    AppRoutesArgs.patientSectionsRouteArguments(
                                  patientId: consultDetails.patientModel!.id
                                      .toString(),
                                  currentDoctorRole:
                                      widget.homeDataModel.role.toString(),
                                  currentDoctorPoints: int.parse(
                                      widget.homeDataModel.scoreValue!),
                                  currentDoctorModel: widget.currentDoctorModel,
                                  homeDataModel: widget.homeDataModel,
                                  isAllDataOpen: true,
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 20,
                            left: 20,
                            right: 20,
                          ),
                          child: Row(
                            children: [
                              Text(
                                'Consultations:',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ListView.builder(
                          itemCount: consultDetails.consultationDoctors!.length,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.only(bottom: 100.h),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            var doctorConsultation =
                                consultDetails.consultationDoctors![index];
                            // todo: remove this
                            return doctorConsultation.reply == null ||
                                    doctorConsultation.reply ==
                                        'No reply available remove this'
                                ? const SizedBox.shrink()
                                : Card(
                                    color: Colors.white,
                                    margin: const EdgeInsets.only(
                                      left: 20,
                                      right: 20,
                                      top: 20,
                                    ),
                                    elevation: 0.8,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(10),
                                      splashColor:
                                          AppColors.subBG, // Splash color
                                      // onLongPress: () {
                                      //   if (doctorConsultation.doctorId.toString() ==
                                      //           widget.currentDoctorModel.id.toString() ||
                                      //       widget.homeDataModel.role.toString() ==
                                      //           'Admin') {
                                      //     showCustomDialog(
                                      //         context: context,
                                      //         title: 'Delete',
                                      //         description:
                                      //             'Are you sure to delete comment?',
                                      //         noColoredButtonOnTap: () {
                                      //           Navigator.of(context).pop();
                                      //         },
                                      //         coloredButtonText: 'Cancel',
                                      //         noColoredButtonText: 'Delete',
                                      //         isNoColorShow: true,
                                      //         coloredButtonOnTap: () =>
                                      //             Navigator.of(context).pop());
                                      //   }
                                      // },
                                      onTap: () {},
                                      child: Container(
                                        width: 300.w,
                                        padding: const EdgeInsets.all(16),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    navigatorKey.currentState
                                                        ?.pushNamed(
                                                      AppRoutes.doctorInfoView,
                                                      arguments: AppRoutesArgs
                                                          .doctorInfoViewRouteArgs(
                                                        doctorId:
                                                            doctorConsultation
                                                                .doctorId
                                                                .toString(),
                                                        currentDoctorModel: widget
                                                            .currentDoctorModel,
                                                        isSyndicateCardRequired:
                                                            widget.homeDataModel
                                                                .isSyndicateCardRequired
                                                                .toString(),
                                                        accountVerification:
                                                            widget.homeDataModel
                                                                .verified!,
                                                        currentDoctorRole:
                                                            widget.homeDataModel
                                                                .role
                                                                .toString(),
                                                        currentDoctorPoints:
                                                            int.parse(widget
                                                                .homeDataModel
                                                                .scoreValue
                                                                .toString()),
                                                        homeDataModel: widget
                                                            .homeDataModel,
                                                      ),
                                                    );
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.4),
                                                          spreadRadius: 2,
                                                          blurRadius: 9,
                                                          offset: const Offset(
                                                              0, 3),
                                                        ),
                                                      ],
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              80.r),
                                                      child: CircleAvatar(
                                                        radius: 20.r,
                                                        backgroundColor:
                                                            AppColors
                                                                .primary
                                                                .withOpacity(
                                                                    0.8),
                                                        child: doctorConsultation
                                                                    .doctorId ==
                                                                null
                                                            ? Text(
                                                                doctorConsultation
                                                                    .doctorFirstName![
                                                                        0]
                                                                    .toUpperCase(),
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        16.sp),
                                                              )
                                                            : CustomCachedNetworkImage(
                                                                imageUrl: doctorConsultation
                                                                    .doctorImage
                                                                    .toString(),
                                                                height: 100.h,
                                                                width: 100.w,
                                                              ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const SizedBox(width: 15),
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              // mainAxisAlignment:
                                                              //     MainAxisAlignment
                                                              //         .spaceBetween,
                                                              children: [
                                                                Flexible(
                                                                  child: Text(
                                                                    doctorName(
                                                                      firstName:
                                                                          doctorConsultation.doctorFirstName ??
                                                                              '',
                                                                      lastName:
                                                                          doctorConsultation.doctorLastName ??
                                                                              '',
                                                                      role: '',
                                                                    ),
                                                                    style:
                                                                        TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: doctorConsultation.doctorId.toString() ==
                                                                              widget.currentDoctorModel.id
                                                                                  .toString()
                                                                          ? Colors
                                                                              .green
                                                                              .shade600
                                                                          : AppColors
                                                                              .title,
                                                                      fontSize:
                                                                          12.sp,
                                                                    ),
                                                                    maxLines: 1,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                  ),
                                                                ),
                                                                doctorConsultation
                                                                        .isVerified!
                                                                    ? const VerificationIcon()
                                                                    : const SizedBox
                                                                        .shrink(),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                                height: 4),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    doctorConsultation.reply
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12.sp,
                                                      height: 1.6,
                                                      wordSpacing: 2,
                                                      letterSpacing: 1,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 5.h),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  timeago.format(DateTime.parse(
                                                      doctorConsultation
                                                          .updatedAt
                                                          .toString())),
                                                  style: const TextStyle(
                                                    color:
                                                        AppColors.description,
                                                    fontSize: 12,
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                          },
                        ),
                      ],
                    ),
                  ),
                  widget.isReceivedConsultation
                      ? Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 80.h,
                            width: double.infinity,
                            padding: const EdgeInsets.all(16.0) +
                                const EdgeInsets.only(left: 10, right: 10),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                top: BorderSide(
                                  color: Colors.black12,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                isSendingConsultation
                                    ? const SizedBox(
                                        width: 30,
                                        height: 30,
                                        child: CircularProgressIndicator(),
                                      )
                                    : Expanded(
                                        child: CustomTextFormField(
                                          title: 'Write consultation',
                                          textInputType: TextInputType.text,
                                          enableSuggestions: true,
                                          onChanged: (val) {
                                            cubit.newConsultation = val;
                                            if (val.trim().isNotEmpty) {
                                              cubit.newConsultationValueChanged(
                                                  val);
                                            }
                                            if (val.trim().isEmpty) {
                                              cubit.newConsultationValueChanged(
                                                  val);
                                            }
                                          },
                                          onFieldSubmitted: (val) {
                                            // if (accountVerification &&
                                            //     isSyndicateCardRequired != 'Required' &&
                                            //     isSyndicateCardRequired != 'Pending') {
                                            //   cubit.addPatientComments(patientId: patientId);
                                            // } else {
                                            //   if (isSyndicateCardRequired != 'Required' &&
                                            //       isSyndicateCardRequired != 'Pending') {
                                            //     showCustomDialog(
                                            //       context: context,
                                            //       title: AppStrings.emailVerification,
                                            //       description: AppStrings
                                            //           .toAddCommentYouMustVerifyYourEmailAddress,
                                            //       noColoredButtonOnTap: () {
                                            //         Navigator.of(context).pop();
                                            //       },
                                            //       coloredButtonText: AppStrings.verify,
                                            //       noColoredButtonText: AppStrings.cancel,
                                            //       coloredButtonOnTap: () {
                                            //         Navigator.of(context).pop();
                                            //         navigatorKey.currentState?.pushNamed(
                                            //           AppRoutes.emailVerification,
                                            //           arguments: AppRoutesArgs
                                            //               .emailVerificationRouteArgs(
                                            //                   currentDoctorModel:
                                            //                       currentDoctorModel),
                                            //         );
                                            //       },
                                            //     );
                                            //   }
                                            // }
                                            // if (accountVerification &&
                                            //     (isSyndicateCardRequired == 'Required' ||
                                            //         isSyndicateCardRequired == 'Pending')) {
                                            //   showCustomDialog(
                                            //     context: context,
                                            //     title: 'Syndicate card verification',
                                            //     description:
                                            //         'To add comment you must verify your syndicate card.',
                                            //     noColoredButtonOnTap: () {
                                            //       Navigator.of(context).pop();
                                            //     },
                                            //     coloredButtonText: AppStrings.ok,
                                            //     noColoredButtonText: '',
                                            //     isNoColorShow: true,
                                            //     coloredButtonOnTap: () {
                                            //       Navigator.of(context).pop();
                                            //     },
                                            //   );
                                            // }
                                          },
                                          textInputAction: TextInputAction.done,
                                          validator: (val) {
                                            return null;
                                          },
                                        ),
                                      ),
                                isSendingConsultation
                                    ? const SizedBox.shrink()
                                    : BlocBuilder<ConsultationDetailsCubit,
                                        ConsultationDetailsState>(
                                        builder: (context, state) {
                                          return state.maybeWhen(
                                            orElse: () {
                                              return const SizedBox.shrink();
                                            },
                                            loaded: (consultDetails,
                                                newConsultationValue,
                                                isSendingConsultation,
                                                isSendedConsultation,
                                                message) {
                                              return newConsultationValue
                                                          .trim() ==
                                                      AppStrings.empty
                                                  ? const SizedBox.shrink()
                                                  : Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        IconButton(
                                                          onPressed: () {
                                                            if (widget
                                                                    .homeDataModel
                                                                    .verified! &&
                                                                widget.homeDataModel
                                                                        .isSyndicateCardRequired !=
                                                                    'Required' &&
                                                                widget.homeDataModel
                                                                        .isSyndicateCardRequired !=
                                                                    'Pending') {
                                                              cubit
                                                                  .addConsultationReply(
                                                                consultationId:
                                                                    consultDetails
                                                                        .id
                                                                        .toString(),
                                                                reply:
                                                                    newConsultationValue,
                                                              );
                                                            } else {
                                                              if (widget.homeDataModel
                                                                          .isSyndicateCardRequired !=
                                                                      'Required' &&
                                                                  widget.homeDataModel
                                                                          .isSyndicateCardRequired !=
                                                                      'Pending') {
                                                                showCustomDialog(
                                                                  context:
                                                                      context,
                                                                  title: AppStrings
                                                                      .emailVerification,
                                                                  description:
                                                                      AppStrings
                                                                          .toAddCommentYouMustVerifyYourEmailAddress,
                                                                  noColoredButtonOnTap:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  coloredButtonText:
                                                                      AppStrings
                                                                          .verify,
                                                                  noColoredButtonText:
                                                                      AppStrings
                                                                          .cancel,
                                                                  coloredButtonOnTap:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                    navigatorKey
                                                                        .currentState
                                                                        ?.pushNamed(
                                                                      AppRoutes
                                                                          .emailVerification,
                                                                      arguments:
                                                                          AppRoutesArgs.emailVerificationRouteArgs(
                                                                              currentDoctorModel: widget.currentDoctorModel),
                                                                    );
                                                                  },
                                                                );
                                                              }
                                                            }
                                                            if (widget
                                                                    .homeDataModel
                                                                    .verified! &&
                                                                (widget.homeDataModel
                                                                            .isSyndicateCardRequired ==
                                                                        'Required' ||
                                                                    widget.homeDataModel
                                                                            .isSyndicateCardRequired ==
                                                                        'Pending')) {
                                                              showCustomDialog(
                                                                context:
                                                                    context,
                                                                title:
                                                                    'Syndicate card verification',
                                                                description:
                                                                    'To add consultation you must verify your syndicate card.',
                                                                noColoredButtonOnTap:
                                                                    () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                coloredButtonText:
                                                                    AppStrings
                                                                        .ok,
                                                                noColoredButtonText:
                                                                    '',
                                                                isNoColorShow:
                                                                    true,
                                                                coloredButtonOnTap:
                                                                    () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                              );
                                                            }
                                                          },
                                                          icon: Icon(
                                                            Icons.send_outlined,
                                                            size: 30,
                                                            color: AppColors
                                                                .primary
                                                                .withOpacity(
                                                                    0.7),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 7.h,
                                                        )
                                                      ],
                                                    );
                                            },
                                          );
                                        },
                                      ),
                              ],
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
