import 'dart:developer';

import 'package:egy_akin/app/shared/functions/animate_to_right_end_of_screen.dart';
import 'package:egy_akin/features/send_consultation/presentation/cubit/send_consultation_state.dart';
import '../../../../app/services/theme_bloc.dart';

import '../../../../exports.dart';

class SendConsultationScreen extends StatefulWidget {
  final HomeModelResponse homeDataModel;
  final DoctorModel currentDoctorModel;
  final String patientId;
  final bool isSendConsultation;
  final String groupId;
  final bool isForAddNewDoctors;
  final String consultationId;
  final String ownerOfConsultationId;
  const SendConsultationScreen({
    super.key,
    required this.homeDataModel,
    required this.currentDoctorModel,
    required this.patientId,
    required this.isSendConsultation,
    required this.groupId,
    required this.isForAddNewDoctors,
    required this.consultationId,
    required this.ownerOfConsultationId,
  });

  @override
  State<SendConsultationScreen> createState() => _SendConsultationScreenState();
}

class _SendConsultationScreenState extends State<SendConsultationScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.isForAddNewDoctors) {
      context
          .read<SendConsultationCubit>()
          .getMembersForConsultation(widget.consultationId);
    } else {
      context.read<SendConsultationCubit>().emitLoadedIfNotForMembers();
    }
  }

  @override
  Widget build(BuildContext context) {
    SendConsultationCubit cubit = SendConsultationCubit.get(context);
    log('widget.isForAddNewDoctors: ${widget.isForAddNewDoctors}');
    log('widget.isSendConsultation: ${widget.isSendConsultation}');
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;

        return Scaffold(
          backgroundColor: isDarkMode ? AppColors.darkScaffoldBG : Colors.white,
          appBar: AppBar(
            iconTheme: const IconThemeData(
              color: AppColors.darkTitle,
            ),
            title: Text(
              widget.isSendConsultation
                  ? widget.isForAddNewDoctors
                      ? (widget.ownerOfConsultationId !=
                              widget.currentDoctorModel.id.toString())
                          ? context.tr(AppStrings.invitedDoctors)
                          : context.tr(AppStrings.addDoctorsToConsultation)
                      : context.tr(AppStrings.sendConsultation)
                  : context.tr(AppStrings.inviteMembers),
              style: const TextStyle(
                color: AppColors.darkTitle,
              ),
            ),
            actions: [
              widget.isSendConsultation == true &&
                      widget.isForAddNewDoctors == true &&
                      widget.ownerOfConsultationId !=
                          widget.currentDoctorModel.id.toString()
                  ? const SizedBox.shrink()
                  : IconButton(
                      onPressed: () {
                        if (cubit.doctorsChecked.isEmpty) {
                          customSnackBar(
                              context: context,
                              message: context.tr(AppStrings
                                  .pleaseSelectAtLeastOneDoctorToProceed));
                        } else {
                          showCustomDialog(
                            context: context,
                            title: widget.isSendConsultation
                                ? context.tr(AppStrings.consultation)
                                : context.tr(AppStrings.invitation),
                            noColoredButtonText: context.tr(AppStrings.cancel),
                            isWithTextField:
                                widget.isSendConsultation ? true : false,
                            textFormFieldMaxLines: 3,
                            textInputType: TextInputType.multiline,
                            onChangedTextFormField: (value) {
                              cubit.consultMessage = value;
                            },
                            noColoredButtonOnTap: () {
                              Navigator.pop(context);
                            },
                            description: widget.isSendConsultation
                                ? context
                                    .tr(AppStrings.writeNoteForChosenDoctors)
                                : context.tr(AppStrings.youAreDone),
                            coloredButtonText: widget.isSendConsultation
                                ? context.tr(AppStrings.send)
                                : context.tr(AppStrings.invite),
                            coloredButtonOnTap: () {
                              Navigator.pop(context);
                              if (widget.isSendConsultation) {
                                if (widget.isForAddNewDoctors) {
                                  cubit.addDoctorsForConsultation(
                                      widget.consultationId,
                                      cubit.doctorsChecked
                                          .map((e) => e.id.toString())
                                          .toList());
                                } else {
                                  cubit.sendConsultation(widget.patientId);
                                }
                              } else {
                                cubit.sendGroupInvitation(widget.groupId);
                              }
                            },
                          );
                        }
                      },
                      icon: const Icon(
                        Icons.send,
                      ))
            ],
          ),
          floatingActionButton: widget.isSendConsultation == true &&
                  widget.isForAddNewDoctors == true &&
                  widget.ownerOfConsultationId !=
                      widget.currentDoctorModel.id.toString()
              ? const SizedBox.shrink()
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 50.w,
                      width: 50.w,
                      child: FloatingActionButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        onPressed: () {
                          cubit.getConsultationSearch();
                        },
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 25.r,
                        ),
                      ),
                    ),
                  ],
                ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    widget.isSendConsultation == true &&
                            widget.isForAddNewDoctors == true &&
                            widget.ownerOfConsultationId !=
                                widget.currentDoctorModel.id.toString()
                        ? const SizedBox.shrink()
                        : SizedBox(
                            height: 55,
                            child: TextFormField(
                              controller: cubit.searchController,
                              cursorColor: AppColors.primary,
                              style: TextStyle(
                                color: isDarkMode
                                    ? AppColors.darkTitle
                                    : Colors.black,
                              ),
                              onTapOutside: (event) =>
                                  FocusManager.instance.primaryFocus?.unfocus(),
                              onFieldSubmitted: (value) {
                                // cubit.getSearchHome();
                              },
                              decoration: InputDecoration(
                                hintText: context
                                    .tr(AppStrings.searchWithDoctorNameOrEmail),
                                hintStyle: TextStyle(
                                  fontSize: 11.sp,
                                  color: isDarkMode
                                      ? AppColors.darkDescription
                                      : Colors.grey,
                                ),
                                filled: true,
                                fillColor: isDarkMode
                                    ? AppColors.darkBorder
                                    : Colors.grey.shade100,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    Icons.clear,
                                    color: isDarkMode
                                        ? AppColors.darkTitle
                                        : Colors.grey,
                                  ),
                                  onPressed: () =>
                                      cubit.searchController.clear(),
                                ),
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: isDarkMode
                                      ? AppColors.darkTitle
                                      : Colors.grey,
                                ),
                                prefixIconColor: WidgetStateColor.resolveWith(
                                    (states) =>
                                        states.contains(WidgetState.focused)
                                            ? AppColors.primary
                                            : isDarkMode
                                                ? AppColors.darkTitle
                                                : Colors.grey),
                                suffixIconColor: WidgetStateColor.resolveWith(
                                    (states) =>
                                        states.contains(WidgetState.focused)
                                            ? AppColors.primary
                                            : isDarkMode
                                                ? AppColors.darkTitle
                                                : Colors.grey),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                    color: isDarkMode
                                        ? AppColors.darkBorder
                                        : Colors.grey.shade300,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                    color: isDarkMode
                                        ? AppColors.darkBorder
                                        : Colors.grey.shade300,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                      color: AppColors.primary),
                                ),
                              ),
                              autofocus: true,
                            ),
                          ),
                    widget.isSendConsultation == true &&
                            widget.isForAddNewDoctors == true &&
                            widget.ownerOfConsultationId !=
                                widget.currentDoctorModel.id.toString()
                        ? const SizedBox.shrink()
                        : SizedBox(height: 16.h),
                    BlocBuilder<SendConsultationCubit, SendConsultationState>(
                      builder: (context, state) {
                        return state.maybeWhen(
                          orElse: () => const SizedBox.shrink(),
                          loaded: (
                            isSearching,
                            isSearched,
                            message,
                            response,
                            counterChanges,
                            isSendingConsultation,
                            isSendedConsultation,
                            membersForConsultation,
                            isRemoveMemberFromConsultationLoading,
                            isRemoveMemberFromConsultationLoaded,
                          ) {
                            // Debug logging
                            debugPrint('=== DEBUG: UI State ===');
                            debugPrint(
                                'isForAddNewDoctors: ${widget.isForAddNewDoctors}');
                            debugPrint(
                                'membersForConsultation: $membersForConsultation');
                            debugPrint(
                                'membersForConsultation.data: ${membersForConsultation?.data}');
                            debugPrint(
                                'membersForConsultation.data length: ${membersForConsultation?.data?.length}');
                            debugPrint(
                                'doctorsChecked length: ${cubit.doctorsChecked.length}');
                            debugPrint('================================');

                            // Show doctors from both doctorsChecked and membersForConsultation
                            final allDoctors =
                                <DoctorModelInConsultationModelResponse>[];

                            // Add doctors from doctorsChecked (newly selected doctors)
                            allDoctors.addAll(cubit.doctorsChecked);

                            // Add doctors from membersForConsultation (existing consultation members)
                            if (widget.isForAddNewDoctors &&
                                membersForConsultation != null &&
                                membersForConsultation.data != null) {
                              for (var member in membersForConsultation.data!) {
                                // Only add if not already in doctorsChecked to avoid duplicates
                                if (!allDoctors.any((d) => d.id == member.id)) {
                                  allDoctors.add(member);
                                }
                              }
                            }

                            debugPrint(
                                'Final allDoctors length: ${allDoctors.length}');
                            debugPrint(
                                'Existing members count: ${membersForConsultation?.data?.length ?? 0}');
                            debugPrint(
                                'Newly selected doctors count: ${cubit.doctorsChecked.length}');

                            if (allDoctors.isEmpty) {
                              return const SizedBox.shrink();
                            }

                            // Check if current doctor is the owner
                            final isOwner = widget.ownerOfConsultationId ==
                                widget.currentDoctorModel.id.toString();

                            return Directionality(
                              textDirection: TextDirection.ltr,
                              child: FadeIn(
                                child: Column(
                                  children: [
                                    if (isOwner)
                                      // Horizontal list for owner
                                      SizedBox(
                                        height: 45.h,
                                        child: ListView.builder(
                                          itemCount: allDoctors.length,
                                          shrinkWrap: true,
                                          padding: EdgeInsets.only(top: 5.h),
                                          controller:
                                              cubit.horizontalScrollController,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            var doctorModel = allDoctors[index];
                                            // Check if this doctor is from membersForConsultation (existing member)
                                            final isExistingMember = widget
                                                    .isForAddNewDoctors &&
                                                membersForConsultation !=
                                                    null &&
                                                membersForConsultation.data !=
                                                    null &&
                                                membersForConsultation.data!
                                                    .any((m) =>
                                                        m.id == doctorModel.id);

                                            // Check if this doctor is newly selected (in doctorsChecked)
                                            final isNewlySelected =
                                                cubit.doctorsChecked.any((d) =>
                                                    d.id == doctorModel.id);

                                            return FadeIn(
                                              child: Stack(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    15.w),
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.4),
                                                              spreadRadius: 3,
                                                              blurRadius: 9,
                                                              offset:
                                                                  const Offset(
                                                                      0, 3),
                                                            ),
                                                          ],
                                                        ),
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            navigatorKey
                                                                .currentState
                                                                ?.pushNamed(
                                                              AppRoutes
                                                                  .doctorInfoView,
                                                              arguments:
                                                                  AppRoutesArgs
                                                                      .doctorInfoViewRouteArgs(
                                                                doctorId:
                                                                    doctorModel
                                                                        .id
                                                                        .toString(),
                                                                initialIndex: 0,
                                                                currentDoctorModel:
                                                                    widget
                                                                        .currentDoctorModel,
                                                                isSyndicateCardRequired: widget
                                                                    .homeDataModel
                                                                    .isSyndicateCardRequired
                                                                    .toString(),
                                                                accountVerification: widget
                                                                    .homeDataModel
                                                                    .verified!,
                                                                currentDoctorRole: widget
                                                                    .homeDataModel
                                                                    .role
                                                                    .toString(),
                                                                currentDoctorPoints:
                                                                    int.parse(widget
                                                                        .homeDataModel
                                                                        .scoreValue!),
                                                                homeDataModel:
                                                                    widget
                                                                        .homeDataModel,
                                                                isNavigateToTheButtonOfInformationTab:
                                                                    false,
                                                              ),
                                                            );
                                                          },
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        80.r),
                                                            child: CircleAvatar(
                                                              radius: 15.r,
                                                              backgroundColor:
                                                                  AppColors
                                                                      .primary
                                                                      .withOpacity(
                                                                          0.8),
                                                              child: doctorModel
                                                                          .image ==
                                                                      null
                                                                  ? Text(
                                                                      doctorModel.firstName ==
                                                                              null
                                                                          ? ''
                                                                          : doctorModel
                                                                              .firstName![0]
                                                                              .toUpperCase(),
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              16.sp),
                                                                    )
                                                                  : CustomCachedNetworkImage(
                                                                      imageUrl: doctorModel
                                                                          .image
                                                                          .toString(),
                                                                      height:
                                                                          100.h,
                                                                      width:
                                                                          100.w,
                                                                    ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 5.h),
                                                      Text(
                                                        'Dr.${capitalizeFirstText(doctorModel.firstName.toString())}',
                                                        style: TextStyle(
                                                            fontSize: 8.sp,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: isDarkMode
                                                                ? AppColors
                                                                    .darkTitle
                                                                : Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                  // Show remove button for both newly selected doctors and existing members
                                                  // But hide it for the current doctor
                                                  // Also show when isSendConsultation is true
                                                  if ((((isNewlySelected ||
                                                              isExistingMember) &&
                                                          doctorModel.id
                                                                  .toString() !=
                                                              widget
                                                                  .currentDoctorModel
                                                                  .id
                                                                  .toString())) ||
                                                      (widget.isSendConsultation ==
                                                              true &&
                                                          widget.ownerOfConsultationId !=
                                                              widget
                                                                  .currentDoctorModel
                                                                  .id
                                                                  .toString()))
                                                    Positioned(
                                                      top: 0,
                                                      right: 5.w,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          if (isExistingMember) {
                                                            // Remove existing member from consultation via API
                                                            cubit.removeMemberFromConsultation(
                                                                widget
                                                                    .consultationId,
                                                                doctorModel.id
                                                                    .toString());
                                                          } else {
                                                            // Remove newly selected doctor from local list
                                                            cubit.doctorsChecked
                                                                .removeWhere((d) =>
                                                                    d.id ==
                                                                    doctorModel
                                                                        .id);
                                                            cubit
                                                                .updateScreen();
                                                          }
                                                        },
                                                        child: Icon(
                                                          Icons.clear,
                                                          size: 15.r,
                                                          color: Colors
                                                              .red.shade700,
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                    else
                                      // Show vertical list for non-owner when isForAddNewDoctors is true, horizontal otherwise
                                      FadeIn(
                                        child: Column(
                                          children: [
                                            const SizedBox(height: 20),
                                            widget.isForAddNewDoctors
                                                ? // Vertical list when isForAddNewDoctors is true
                                                ListView.builder(
                                                    itemCount:
                                                        allDoctors.length,
                                                    shrinkWrap: true,
                                                    padding: EdgeInsets.only(
                                                        top: 5.h),
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    itemBuilder:
                                                        (context, index) {
                                                      var doctorModel =
                                                          allDoctors[index];
                                                      return FadeIn(
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                            left: 20.w,
                                                            right: 20.w,
                                                            bottom: 10.h,
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: isDarkMode
                                                                ? AppColors
                                                                    .darkCardBG
                                                                : Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.2),
                                                                spreadRadius: 1,
                                                                blurRadius: 5,
                                                                offset:
                                                                    const Offset(
                                                                        0, 2),
                                                              ),
                                                            ],
                                                          ),
                                                          child: ListTile(
                                                            leading: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .grey
                                                                        .withOpacity(
                                                                            0.4),
                                                                    spreadRadius:
                                                                        2,
                                                                    blurRadius:
                                                                        6,
                                                                    offset:
                                                                        const Offset(
                                                                            0,
                                                                            2),
                                                                  ),
                                                                ],
                                                              ),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            80.r),
                                                                child:
                                                                    CircleAvatar(
                                                                  radius: 20.r,
                                                                  backgroundColor:
                                                                      AppColors
                                                                          .primary
                                                                          .withOpacity(
                                                                              0.8),
                                                                  child: doctorModel
                                                                              .image ==
                                                                          null
                                                                      ? Text(
                                                                          doctorModel.firstName == null
                                                                              ? ''
                                                                              : doctorModel.firstName![0].toUpperCase(),
                                                                          style:
                                                                              TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize:
                                                                                16.sp,
                                                                          ),
                                                                        )
                                                                      : CustomCachedNetworkImage(
                                                                          imageUrl: doctorModel
                                                                              .image
                                                                              .toString(),
                                                                          height:
                                                                              100.h,
                                                                          width:
                                                                              100.w,
                                                                        ),
                                                                ),
                                                              ),
                                                            ),
                                                            title: Text(
                                                              'Dr.${capitalizeFirstText(doctorModel.firstName.toString())} ${capitalizeFirstText(doctorModel.lastName.toString())}',
                                                              style: TextStyle(
                                                                fontSize: 14.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: isDarkMode
                                                                    ? AppColors
                                                                        .darkTitle
                                                                    : Colors
                                                                        .black,
                                                              ),
                                                            ),
                                                            subtitle: Text(
                                                              doctorModel.email
                                                                  .toString(),
                                                              style: TextStyle(
                                                                fontSize: 12.sp,
                                                                color: isDarkMode
                                                                    ? AppColors
                                                                        .darkDescription
                                                                    : Colors
                                                                        .grey
                                                                        .shade600,
                                                              ),
                                                            ),
                                                            trailing: widget
                                                                            .isSendConsultation ==
                                                                        true &&
                                                                    widget.isForAddNewDoctors ==
                                                                        true &&
                                                                    widget.ownerOfConsultationId ==
                                                                        widget
                                                                            .currentDoctorModel
                                                                            .id
                                                                            .toString()
                                                                ? IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      // Remove doctor from selection
                                                                      cubit.doctorsChecked.removeWhere((d) =>
                                                                          d.id ==
                                                                          doctorModel
                                                                              .id);
                                                                      cubit
                                                                          .updateScreen();
                                                                    },
                                                                    icon: Icon(
                                                                      Icons
                                                                          .clear,
                                                                      color: Colors
                                                                          .red
                                                                          .shade700,
                                                                      size: 20,
                                                                    ),
                                                                  )
                                                                : null,
                                                            onTap: () {
                                                              navigatorKey
                                                                  .currentState
                                                                  ?.pushNamed(
                                                                AppRoutes
                                                                    .doctorInfoView,
                                                                arguments:
                                                                    AppRoutesArgs
                                                                        .doctorInfoViewRouteArgs(
                                                                  doctorId:
                                                                      doctorModel
                                                                          .id
                                                                          .toString(),
                                                                  initialIndex:
                                                                      0,
                                                                  currentDoctorModel:
                                                                      widget
                                                                          .currentDoctorModel,
                                                                  isSyndicateCardRequired: widget
                                                                      .homeDataModel
                                                                      .isSyndicateCardRequired
                                                                      .toString(),
                                                                  accountVerification: widget
                                                                      .homeDataModel
                                                                      .verified!,
                                                                  currentDoctorRole: widget
                                                                      .homeDataModel
                                                                      .role
                                                                      .toString(),
                                                                  currentDoctorPoints:
                                                                      int.parse(widget
                                                                          .homeDataModel
                                                                          .scoreValue!),
                                                                  homeDataModel:
                                                                      widget
                                                                          .homeDataModel,
                                                                  isNavigateToTheButtonOfInformationTab:
                                                                      false,
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  )
                                                : // Horizontal list when isForAddNewDoctors is false
                                                SizedBox(
                                                    height: 45.h,
                                                    child: ListView.builder(
                                                      itemCount:
                                                          allDoctors.length,
                                                      shrinkWrap: true,
                                                      padding: EdgeInsets.only(
                                                          top: 5.h),
                                                      controller: cubit
                                                          .horizontalScrollController,
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemBuilder:
                                                          (context, index) {
                                                        var doctorModel =
                                                            allDoctors[index];
                                                        return FadeIn(
                                                          child: Stack(
                                                            children: [
                                                              Column(
                                                                children: [
                                                                  Container(
                                                                    margin: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            15.w),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                          color: Colors
                                                                              .grey
                                                                              .withOpacity(0.4),
                                                                          spreadRadius:
                                                                              3,
                                                                          blurRadius:
                                                                              9,
                                                                          offset: const Offset(
                                                                              0,
                                                                              3),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    child:
                                                                        GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        navigatorKey
                                                                            .currentState
                                                                            ?.pushNamed(
                                                                          AppRoutes
                                                                              .doctorInfoView,
                                                                          arguments:
                                                                              AppRoutesArgs.doctorInfoViewRouteArgs(
                                                                            doctorId:
                                                                                doctorModel.id.toString(),
                                                                            initialIndex:
                                                                                0,
                                                                            currentDoctorModel:
                                                                                widget.currentDoctorModel,
                                                                            isSyndicateCardRequired:
                                                                                widget.homeDataModel.isSyndicateCardRequired.toString(),
                                                                            accountVerification:
                                                                                widget.homeDataModel.verified!,
                                                                            currentDoctorRole:
                                                                                widget.homeDataModel.role.toString(),
                                                                            currentDoctorPoints:
                                                                                int.parse(widget.homeDataModel.scoreValue!),
                                                                            homeDataModel:
                                                                                widget.homeDataModel,
                                                                            isNavigateToTheButtonOfInformationTab:
                                                                                false,
                                                                          ),
                                                                        );
                                                                      },
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(80.r),
                                                                        child:
                                                                            CircleAvatar(
                                                                          radius:
                                                                              15.r,
                                                                          backgroundColor: AppColors
                                                                              .primary
                                                                              .withOpacity(0.8),
                                                                          child: doctorModel.image == null
                                                                              ? Text(
                                                                                  doctorModel.firstName == null ? '' : doctorModel.firstName![0].toUpperCase(),
                                                                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                                                                                )
                                                                              : CustomCachedNetworkImage(
                                                                                  imageUrl: doctorModel.image.toString(),
                                                                                  height: 100.h,
                                                                                  width: 100.w,
                                                                                ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                      height:
                                                                          5.h),
                                                                  Text(
                                                                    'Dr.${capitalizeFirstText(doctorModel.firstName.toString())}',
                                                                    style: TextStyle(
                                                                        fontSize: 8
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: isDarkMode
                                                                            ? AppColors.darkTitle
                                                                            : Colors.black),
                                                                  ),
                                                                ],
                                                              ),
                                                              // Remove button for non-owner
                                                              if (widget.isSendConsultation ==
                                                                      false ||
                                                                  widget.isSendConsultation ==
                                                                      true)
                                                                Positioned(
                                                                  top: 0,
                                                                  right: 5.w,
                                                                  child:
                                                                      GestureDetector(
                                                                    onTap: () {
                                                                      // Remove from doctorsChecked if it exists there
                                                                      cubit.doctorsChecked.removeWhere((d) =>
                                                                          d.id ==
                                                                          doctorModel
                                                                              .id);
                                                                      cubit
                                                                          .updateScreen();
                                                                    },
                                                                    child: Icon(
                                                                      Icons
                                                                          .clear,
                                                                      size:
                                                                          15.r,
                                                                      color: Colors
                                                                          .red
                                                                          .shade700,
                                                                    ),
                                                                  ),
                                                                ),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                            SizedBox(height: 5.h),
                                            const Row(
                                              children: [
                                                Expanded(child: Divider()),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    SizedBox(height: 5.h),
                                    if (isOwner)
                                      const Row(
                                        children: [
                                          Expanded(child: Divider()),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              BlocConsumer<SendConsultationCubit, SendConsultationState>(
                listener: (context, state) {
                  state.maybeWhen(
                    orElse: () {},
                    loaded: (
                      isSearching,
                      isSearched,
                      message,
                      response,
                      counterChanges,
                      isSendingConsultation,
                      isSendedConsultation,
                      membersForConsultation,
                      isRemoveMemberFromConsultationLoading,
                      isRemoveMemberFromConsultationLoaded,
                    ) {
                      if (message != '') {
                        customSnackBar(context: context, message: message);
                      }
                    },
                  );
                },
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return const Expanded(
                        child: SingleChildScrollView(
                          child:
                              ShimmerLoadingPatientsCards(ishorizontal: false),
                        ),
                      );
                    },
                    loaded: (
                      isSearching,
                      isSearched,
                      message,
                      response,
                      _,
                      isSendingConsultation,
                      isSendedConsultation,
                      membersForConsultation,
                      isRemoveMemberFromConsultationLoading,
                      isRemoveMemberFromConsultationLoaded,
                    ) {
                      if (isSendingConsultation) {
                        return Column(
                          children: [
                            SizedBox(height: 140.h),
                            const SizedBox(
                              width: 35,
                              height: 35,
                              child: CircularProgressIndicator(),
                            ),
                          ],
                        );
                      }
                      if (isSearching) {
                        return const Expanded(
                          child: SingleChildScrollView(
                            child: ShimmerLoadingPatientsCards(
                                ishorizontal: false),
                          ),
                        );
                      }
                      if (isSearched) {
                        return Expanded(
                          child: response!.data!.isEmpty
                              ? const SizedBox.shrink()
                              : // Show search results when doctors are found
                              ListView.builder(
                                  itemCount: response.data!.length,
                                  padding: EdgeInsets.only(bottom: 150.h),
                                  itemBuilder: (context, index) {
                                    var doctorModel = response.data![index];

                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20, bottom: 8),
                                      child: Card(
                                        color: isDarkMode
                                            ? AppColors.darkCardBG
                                            : Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          splashColor: isDarkMode
                                              ? AppColors.darkCardBG
                                              : AppColors.subBG,
                                          onTap: () {
                                            navigatorKey.currentState
                                                ?.pushNamed(
                                              AppRoutes.doctorInfoView,
                                              arguments: AppRoutesArgs
                                                  .doctorInfoViewRouteArgs(
                                                doctorId:
                                                    doctorModel.id.toString(),
                                                currentDoctorModel:
                                                    widget.currentDoctorModel,
                                                isSyndicateCardRequired: widget
                                                    .homeDataModel
                                                    .isSyndicateCardRequired
                                                    .toString(),
                                                initialIndex: 0,
                                                accountVerification: widget
                                                    .homeDataModel.verified!,
                                                currentDoctorRole: widget
                                                    .homeDataModel.role
                                                    .toString(),
                                                currentDoctorPoints: int.parse(
                                                    widget.homeDataModel
                                                        .scoreValue!),
                                                homeDataModel:
                                                    widget.homeDataModel,
                                                isNavigateToTheButtonOfInformationTab:
                                                    false,
                                              ),
                                            );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(20),
                                            child: Row(
                                              children: [
                                                Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.4),
                                                                spreadRadius: 2,
                                                                blurRadius: 9,
                                                                offset:
                                                                    const Offset(
                                                                        0, 3),
                                                              ),
                                                            ],
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        80.r),
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                navigatorKey
                                                                    .currentState
                                                                    ?.pushNamed(
                                                                  AppRoutes
                                                                      .doctorInfoView,
                                                                  arguments:
                                                                      AppRoutesArgs
                                                                          .doctorInfoViewRouteArgs(
                                                                    doctorId:
                                                                        doctorModel
                                                                            .id
                                                                            .toString(),
                                                                    initialIndex:
                                                                        0,
                                                                    currentDoctorModel:
                                                                        widget
                                                                            .currentDoctorModel,
                                                                    isSyndicateCardRequired: widget
                                                                        .homeDataModel
                                                                        .isSyndicateCardRequired!,
                                                                    homeDataModel:
                                                                        widget
                                                                            .homeDataModel,
                                                                    accountVerification:
                                                                        widget.homeDataModel.verified ??
                                                                            true,
                                                                    currentDoctorRole: widget
                                                                        .homeDataModel
                                                                        .role!,
                                                                    isNavigateToTheButtonOfInformationTab:
                                                                        false,
                                                                    currentDoctorPoints:
                                                                        int.parse(widget
                                                                            .homeDataModel
                                                                            .scoreValue!),
                                                                  ),
                                                                );
                                                              },
                                                              child:
                                                                  CircleAvatar(
                                                                radius: 20.r,
                                                                backgroundColor:
                                                                    AppColors
                                                                        .primary
                                                                        .withOpacity(
                                                                            0.8),
                                                                child: doctorModel
                                                                            .image ==
                                                                        null
                                                                    ? Text(
                                                                        doctorModel
                                                                            .firstName![0]
                                                                            .toUpperCase(),
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize: 16.sp),
                                                                      )
                                                                    : CustomCachedNetworkImage(
                                                                        imageUrl: doctorModel
                                                                            .image
                                                                            .toString(),
                                                                        height:
                                                                            100.h,
                                                                        width:
                                                                            100.w,
                                                                      ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(width: 8.w),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  doctorName(
                                                                    firstName:
                                                                        doctorModel
                                                                            .firstName,
                                                                    lastName:
                                                                        doctorModel
                                                                            .lastName,
                                                                    role: doctorModel
                                                                        .isSyndicateCardRequired
                                                                        .toString(),
                                                                  ),
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: isDarkMode
                                                                        ? AppColors
                                                                            .darkTitle
                                                                        : Colors
                                                                            .black,
                                                                  ),
                                                                ),
                                                                doctorModel.isSyndicateCardRequired
                                                                            .toString() ==
                                                                        'Verified'
                                                                    ? const VerificationIcon()
                                                                    : const SizedBox
                                                                        .shrink()
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  doctorModel
                                                                          .email ??
                                                                      '',
                                                                  style:
                                                                      TextStyle(
                                                                    color: isDarkMode
                                                                        ? AppColors
                                                                            .darkDescription
                                                                        : Colors
                                                                            .grey
                                                                            .shade700,
                                                                    fontSize:
                                                                        10.sp,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Checkbox(
                                                        value: cubit
                                                                .isDoctorChecked(
                                                                    doctorModel) ||
                                                            (widget.isForAddNewDoctors &&
                                                                membersForConsultation !=
                                                                    null &&
                                                                membersForConsultation
                                                                        .data !=
                                                                    null &&
                                                                membersForConsultation
                                                                    .data!
                                                                    .any((m) =>
                                                                        m.id ==
                                                                        doctorModel
                                                                            .id)),
                                                        // Disable checkbox for current doctor
                                                        onChanged: doctorModel
                                                                    .id
                                                                    .toString() ==
                                                                widget
                                                                    .currentDoctorModel
                                                                    .id
                                                                    .toString()
                                                            ? null
                                                            : (bool? value) {
                                                                if (value ==
                                                                    true) {
                                                                  // Only add to doctorsChecked if not already an existing member
                                                                  if (!(widget
                                                                          .isForAddNewDoctors &&
                                                                      membersForConsultation !=
                                                                          null &&
                                                                      membersForConsultation
                                                                              .data !=
                                                                          null &&
                                                                      membersForConsultation
                                                                          .data!
                                                                          .any((m) =>
                                                                              m.id ==
                                                                              doctorModel.id))) {
                                                                    cubit
                                                                        .doctorsChecked
                                                                        .add(
                                                                            doctorModel);
                                                                  }
                                                                } else {
                                                                  // Check if this is an existing member
                                                                  final isExistingMember = widget
                                                                          .isForAddNewDoctors &&
                                                                      membersForConsultation !=
                                                                          null &&
                                                                      membersForConsultation
                                                                              .data !=
                                                                          null &&
                                                                      membersForConsultation
                                                                          .data!
                                                                          .any((m) =>
                                                                              m.id ==
                                                                              doctorModel.id);

                                                                  if (isExistingMember) {
                                                                    // Remove existing member from consultation via API
                                                                    cubit.removeMemberFromConsultation(
                                                                        widget
                                                                            .consultationId,
                                                                        doctorModel
                                                                            .id
                                                                            .toString());
                                                                  } else {
                                                                    // Remove newly selected doctor from local list
                                                                    cubit.doctorsChecked.removeWhere((d) =>
                                                                        d.id ==
                                                                        doctorModel
                                                                            .id);
                                                                  }
                                                                }
                                                                animateToRightEndOfScreen(
                                                                    cubit
                                                                        .horizontalScrollController);
                                                                cubit
                                                                    .updateScreen();
                                                              },
                                                        activeColor: AppColors
                                                            .primary
                                                            .withOpacity(0.8),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  );
                },
              )
            ],
          ),
        );
      },
    );
  }
}
