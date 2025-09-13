import 'package:egy_akin/features/consultation_details/presentation/cubit/consultation_details_state.dart';
import 'package:readmore/readmore.dart';
import '../widgets/consultation_lock_widget.dart';
import '../../../../exports.dart';

class ConsultationDetailsScreen extends StatefulWidget {
  final DoctorModel currentDoctorModel;
  final HomeModelResponse homeDataModel;
  final String patientName;
  final String consultationId;
  final bool isReceivedConsultation;
  final bool isOpen;

  const ConsultationDetailsScreen({
    super.key,
    required this.currentDoctorModel,
    required this.homeDataModel,
    required this.isReceivedConsultation,
    required this.consultationId,
    required this.patientName,
    required this.isOpen,
  });

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

  void _toggleConsultationLock() async {
    final cubit = context.read<ConsultationDetailsCubit>();
    final currentState = cubit.state;

    // Get current isOpen value from the consultation details
    bool currentIsOpen = true; // Default value
    if (currentState.maybeWhen(
      loaded: (consultDetails, newCommentValue, isSendingConsultation,
          isSendedConsultation, message, isLocking, isLocked) {
        currentIsOpen = consultDetails.isOpen ?? true;
        return true;
      },
      orElse: () => false,
    )) {
      // Toggle the isOpen value - if currently open, send false to close; if currently closed, send true to open
      final newIsOpen = !currentIsOpen;

      // Call the cubit method to lock/unlock consultation
      await cubit.lockOrUnlockConsultation(widget.consultationId, newIsOpen);

      // Show success message
      // if (mounted) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(
      //       content: Text(
      //         newIsOpen
      //             ? context.tr(AppStrings.consultationUnlocked)
      //             : context.tr(AppStrings.consultationLocked),
      //       ),
      //       backgroundColor: AppColors.primary,
      //       duration: const Duration(seconds: 2),
      //     ),
      //   );
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    ConsultationDetailsCubit cubit = ConsultationDetailsCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.patientName.toString()),
        actions: [
          BlocBuilder<ConsultationDetailsCubit, ConsultationDetailsState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return const SizedBox.shrink();
                },
                loaded: (
                  consultDetails,
                  newCommentValue,
                  isSendingConsultation,
                  isSendedConsultation,
                  message,
                  isLocking,
                  isLocked,
                ) {
                  if (isLocked) {
                    return const SizedBox.shrink();
                  }
                  return IconButton(
                    onPressed: () {
                      navigatorKey.currentState?.pushNamed(
                        AppRoutes.sendConsultation,
                        arguments: AppRoutesArgs.sendConsultationRouteArgs(
                          homeDataModel: widget.homeDataModel,
                          currentDoctorModel: widget.currentDoctorModel,
                          patientId: consultDetails.patientModel!.id.toString(),
                          isSendConsultation: true,
                          groupId: '',
                          isForAddNewDoctors: true,
                          consultationId: widget.consultationId,
                          ownerOfConsultationId:
                              consultDetails.doctorId.toString(),
                        ),
                      );
                    },
                    icon: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.person),
                        const SizedBox(height: 2),
                        Text(
                          context.tr(AppStrings.doctors),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 7.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          )
        ],
      ),
      body: BlocConsumer<ConsultationDetailsCubit, ConsultationDetailsState>(
        listener: (context, state) {
          state.maybeWhen(
            orElse: () {},
            error: (message) {
              customSnackBar(context: context, message: message);
            },
            loaded: (
              consultDetails,
              newCommentValue,
              isSendingConsultation,
              isSendedConsultation,
              message,
              isLocking,
              isLocked,
            ) {
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
            loaded: (
              consultDetails,
              newConsultationValue,
              isSendingConsultation,
              isSendedConsultation,
              message,
              isLocking,
              isLocked,
            ) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        // Consultation Lock Widget
                        widget.isReceivedConsultation &&
                                consultDetails.doctorId.toString() !=
                                    widget.currentDoctorModel.id.toString()
                            ? const SizedBox.shrink()
                            : BlocBuilder<ConsultationDetailsCubit,
                                ConsultationDetailsState>(
                                builder: (context, state) {
                                  return state.maybeWhen(
                                    loaded: (consultDetails,
                                        newCommentValue,
                                        isSendingConsultation,
                                        isSendedConsultation,
                                        message,
                                        isLocking,
                                        isLocked) {
                                      return ConsultationLockWidget(
                                        isLocked: !(consultDetails.isOpen ??
                                            true), // isLocked is opposite of isOpen
                                        isLoading: isLocking,
                                        onToggle: _toggleConsultationLock,
                                      );
                                    },
                                    orElse: () => ConsultationLockWidget(
                                      isLocked: false,
                                      isLoading: false,
                                      onToggle: _toggleConsultationLock,
                                    ),
                                  );
                                },
                              ),

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
                            trimCollapsedText:
                                ' ${context.tr(AppStrings.seeMore)} ',
                            trimExpandedText:
                                ' ${context.tr(AppStrings.seeLess)} ',
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
                                '${context.tr(AppStrings.consultations)}:',
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
                                                        initialIndex: 0,
                                                        isNavigateToTheButtonOfInformationTab:
                                                            false,
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
                                                                      role: doctorConsultation
                                                                          .isVerified
                                                                          .toString(),
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
                                                  TimeAgoService.instance
                                                      .formatTimeAgoFromString(
                                                          doctorConsultation
                                                              .updatedAt
                                                              .toString(),
                                                          context),
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
                  BlocBuilder<ConsultationDetailsCubit,
                      ConsultationDetailsState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        loaded: (consultDetails,
                            newCommentValue,
                            isSendingConsultation,
                            isSendedConsultation,
                            message,
                            isLocking,
                            isLocked) {
                          return (consultDetails.isOpen ?? true)
                              ? Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    height: 80.h,
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(16.0) +
                                        const EdgeInsets.only(
                                            left: 10, right: 10),
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      border: Border(
                                        top: BorderSide(
                                          color: Colors.black12,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        isSendingConsultation
                                            ? const SizedBox(
                                                width: 30,
                                                height: 30,
                                                child:
                                                    CircularProgressIndicator(),
                                              )
                                            : Expanded(
                                                child: CustomTextFormField(
                                                  title: context.tr(AppStrings
                                                      .writeConsultation),
                                                  textInputType:
                                                      TextInputType.text,
                                                  enableSuggestions: true,
                                                  onChanged: (val) {
                                                    cubit.newConsultation = val;
                                                    if (val.trim().isNotEmpty) {
                                                      cubit
                                                          .newConsultationValueChanged(
                                                              val);
                                                    }
                                                    if (val.trim().isEmpty) {
                                                      cubit
                                                          .newConsultationValueChanged(
                                                              val);
                                                    }
                                                  },
                                                  onFieldSubmitted: (val) {},
                                                  textInputAction:
                                                      TextInputAction.done,
                                                  validator: (val) {
                                                    return null;
                                                  },
                                                ),
                                              ),
                                        isSendingConsultation
                                            ? const SizedBox.shrink()
                                            : BlocBuilder<
                                                ConsultationDetailsCubit,
                                                ConsultationDetailsState>(
                                                builder: (context, state) {
                                                  return state.maybeWhen(
                                                    orElse: () {
                                                      return const SizedBox
                                                          .shrink();
                                                    },
                                                    loaded: (
                                                      consultDetails,
                                                      newConsultationValue,
                                                      isSendingConsultation,
                                                      isSendedConsultation,
                                                      message,
                                                      isLocking,
                                                      isLocked,
                                                    ) {
                                                      return newConsultationValue
                                                                  .trim() ==
                                                              AppStrings.empty
                                                          ? const SizedBox
                                                              .shrink()
                                                          : Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    if (!widget
                                                                        .homeDataModel
                                                                        .verified!) {
                                                                      showCustomDialog(
                                                                        context:
                                                                            context,
                                                                        title: context
                                                                            .tr(AppStrings.emailVerification),
                                                                        description:
                                                                            context.tr(AppStrings.toAddConsultationYouMustVerifyYourEmailAddress),
                                                                        noColoredButtonOnTap:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        },
                                                                        coloredButtonText:
                                                                            context.tr(AppStrings.verify),
                                                                        noColoredButtonText:
                                                                            context.tr(AppStrings.cancel),
                                                                        coloredButtonOnTap:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                          navigatorKey
                                                                              .currentState
                                                                              ?.pushNamed(
                                                                            AppRoutes.emailVerification,
                                                                            arguments:
                                                                                AppRoutesArgs.emailVerificationRouteArgs(currentDoctorModel: widget.currentDoctorModel),
                                                                          );
                                                                        },
                                                                      );
                                                                    }
                                                                    if (widget
                                                                            .homeDataModel
                                                                            .verified! &&
                                                                        widget.homeDataModel.isSyndicateCardRequired !=
                                                                            'Required' &&
                                                                        widget.homeDataModel.isSyndicateCardRequired !=
                                                                            'Pending') {
                                                                      cubit
                                                                          .addConsultationReply(
                                                                        consultationId: consultDetails
                                                                            .id
                                                                            .toString(),
                                                                        reply:
                                                                            newConsultationValue,
                                                                      );
                                                                    } else {
                                                                      if (widget.homeDataModel.isSyndicateCardRequired !=
                                                                              'Required' &&
                                                                          widget.homeDataModel.isSyndicateCardRequired !=
                                                                              'Pending') {
                                                                        showCustomDialog(
                                                                          context:
                                                                              context,
                                                                          title:
                                                                              context.tr(AppStrings.emailVerification),
                                                                          description:
                                                                              context.tr(AppStrings.toAddConsultationYouMustVerifyYourSyndicateCard),
                                                                          noColoredButtonOnTap:
                                                                              () {
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                          coloredButtonText:
                                                                              context.tr(AppStrings.verify),
                                                                          noColoredButtonText:
                                                                              context.tr(AppStrings.cancel),
                                                                          coloredButtonOnTap:
                                                                              () {
                                                                            Navigator.of(context).pop();
                                                                            navigatorKey.currentState?.pushNamed(
                                                                              AppRoutes.emailVerification,
                                                                              arguments: AppRoutesArgs.emailVerificationRouteArgs(currentDoctorModel: widget.currentDoctorModel),
                                                                            );
                                                                          },
                                                                        );
                                                                      }
                                                                    }
                                                                    if (widget
                                                                            .homeDataModel
                                                                            .verified! &&
                                                                        (widget.homeDataModel.isSyndicateCardRequired ==
                                                                                'Required' ||
                                                                            widget.homeDataModel.isSyndicateCardRequired ==
                                                                                'Pending')) {
                                                                      showCustomDialog(
                                                                        context:
                                                                            context,
                                                                        title: context
                                                                            .tr(AppStrings.syndicateCardVerification),
                                                                        description:
                                                                            context.tr(AppStrings.toAddConsultationYouMustVerifyYourSyndicateCard),
                                                                        noColoredButtonOnTap:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        },
                                                                        coloredButtonText:
                                                                            context.tr(AppStrings.ok),
                                                                        noColoredButtonText:
                                                                            '',
                                                                        isNoColorShow:
                                                                            true,
                                                                        coloredButtonOnTap:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        },
                                                                      );
                                                                    }
                                                                  },
                                                                  icon: Icon(
                                                                    Icons
                                                                        .send_outlined,
                                                                    size: 30,
                                                                    color: AppColors
                                                                        .primary
                                                                        .withOpacity(
                                                                            0.7),
                                                                  ),
                                                                ),
                                                                // SizedBox(
                                                                //   height: 7.h,
                                                                // )
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
                              : const SizedBox.shrink();
                        },
                        orElse: () => const SizedBox.shrink(),
                      );
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
