import 'package:egy_akin/app/shared/functions/animate_to_right_end_of_screen.dart';
import 'package:egy_akin/features/send_consultation/presentation/cubit/send_consultation_state.dart';

import '../../../../exports.dart';

class SendConsultationScreen extends StatefulWidget {
  final HomeModelResponse homeDataModel;
  final DoctorModel currentDoctorModel;
  final String patientId;
  final bool isSendConsultation;
  final String groupId;
  final bool isForAddNewDoctors;
  final String consultationId;
  const SendConsultationScreen({
    super.key,
    required this.homeDataModel,
    required this.currentDoctorModel,
    required this.patientId,
    required this.isSendConsultation,
    required this.groupId,
    required this.isForAddNewDoctors,
    required this.consultationId,
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

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isSendConsultation
              ? widget.isForAddNewDoctors
                  ? context.tr(AppStrings.addDoctorsToConsultation)
                  : context.tr(AppStrings.sendConsultation)
              : context.tr(AppStrings.inviteMembers),
        ),
        actions: [
          IconButton(
              onPressed: () {
                if (cubit.doctorsChecked.isEmpty) {
                  customSnackBar(
                      context: context,
                      message: context.tr(
                          AppStrings.pleaseSelectAtLeastOneDoctorToProceed));
                } else {
                  showCustomDialog(
                    context: context,
                    title: widget.isSendConsultation
                        ? context.tr(AppStrings.consultation)
                        : context.tr(AppStrings.invitation),
                    noColoredButtonText: context.tr(AppStrings.cancel),
                    isWithTextField: widget.isSendConsultation ? true : false,
                    textFormFieldMaxLines: 3,
                    textInputType: TextInputType.multiline,
                    onChangedTextFormField: (value) {
                      cubit.consultMessage = value;
                    },
                    noColoredButtonOnTap: () {
                      Navigator.pop(context);
                    },
                    description: widget.isSendConsultation
                        ? context.tr(AppStrings.writeNoteForChosenDoctors)
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
      floatingActionButton: Column(
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
                SizedBox(
                  height: 55,
                  child: TextFormField(
                    controller: cubit.searchController,
                    cursorColor: AppColors.primary,
                    onTapOutside: (event) =>
                        FocusManager.instance.primaryFocus?.unfocus(),
                    onFieldSubmitted: (value) {
                      // cubit.getSearchHome();
                    },
                    decoration: InputDecoration(
                      hintText:
                          context.tr(AppStrings.searchWithDoctorNameOrEmail),
                      hintStyle: TextStyle(fontSize: 11.sp),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () => cubit.searchController.clear(),
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                      ),
                      prefixIconColor: WidgetStateColor.resolveWith((states) =>
                          states.contains(WidgetState.focused)
                              ? AppColors.primary
                              : Colors.grey),
                      suffixIconColor: WidgetStateColor.resolveWith((states) =>
                          states.contains(WidgetState.focused)
                              ? AppColors.primary
                              : Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: AppColors.primary),
                      ),
                    ),
                    autofocus: true,
                  ),
                ),
                SizedBox(height: 16.h),
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
                        print('=== DEBUG: UI State ===');
                        print(
                            'isForAddNewDoctors: ${widget.isForAddNewDoctors}');
                        print(
                            'membersForConsultation: $membersForConsultation');
                        print(
                            'membersForConsultation.data: ${membersForConsultation?.data}');
                        print(
                            'membersForConsultation.data length: ${membersForConsultation?.data?.length}');
                        print(
                            'doctorsChecked length: ${cubit.doctorsChecked.length}');
                        print('================================');

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

                        print('Final allDoctors length: ${allDoctors.length}');
                        print(
                            'Existing members count: ${membersForConsultation?.data?.length ?? 0}');
                        print(
                            'Newly selected doctors count: ${cubit.doctorsChecked.length}');

                        if (allDoctors.isEmpty) {
                          return const SizedBox.shrink();
                        }

                        return Directionality(
                          textDirection: TextDirection.rtl,
                          child: FadeIn(
                            child: Column(
                              children: [
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
                                          membersForConsultation != null &&
                                          membersForConsultation.data != null &&
                                          membersForConsultation.data!.any(
                                              (m) => m.id == doctorModel.id);

                                      // Check if this doctor is newly selected (in doctorsChecked)
                                      final isNewlySelected = cubit
                                          .doctorsChecked
                                          .any((d) => d.id == doctorModel.id);

                                      return FadeIn(
                                        child: Stack(
                                          children: [
                                            Column(
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 15.w),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.4),
                                                        spreadRadius: 3,
                                                        blurRadius: 9,
                                                        offset:
                                                            const Offset(0, 3),
                                                      ),
                                                    ],
                                                  ),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      navigatorKey.currentState
                                                          ?.pushNamed(
                                                        AppRoutes
                                                            .doctorInfoView,
                                                        arguments: AppRoutesArgs
                                                            .doctorInfoViewRouteArgs(
                                                          doctorId: doctorModel
                                                              .id
                                                              .toString(),
                                                          initialIndex: 0,
                                                          currentDoctorModel: widget
                                                              .currentDoctorModel,
                                                          isSyndicateCardRequired:
                                                              widget
                                                                  .homeDataModel
                                                                  .isSyndicateCardRequired
                                                                  .toString(),
                                                          accountVerification:
                                                              widget
                                                                  .homeDataModel
                                                                  .verified!,
                                                          currentDoctorRole:
                                                              widget
                                                                  .homeDataModel
                                                                  .role
                                                                  .toString(),
                                                          currentDoctorPoints:
                                                              int.parse(widget
                                                                  .homeDataModel
                                                                  .scoreValue!),
                                                          homeDataModel: widget
                                                              .homeDataModel,
                                                          isNavigateToTheButtonOfInformationTab:
                                                              false,
                                                        ),
                                                      );
                                                    },
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
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
                                                                        .firstName![
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
                                                                imageUrl:
                                                                    doctorModel
                                                                        .image
                                                                        .toString(),
                                                                height: 100.h,
                                                                width: 100.w,
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
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            // Show remove button for both newly selected doctors and existing members
                                            // But hide it for the current doctor
                                            if ((isNewlySelected ||
                                                    isExistingMember) &&
                                                doctorModel.id.toString() !=
                                                    widget.currentDoctorModel.id
                                                        .toString())
                                              Positioned(
                                                top: 0,
                                                right: 5.w,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    if (isExistingMember) {
                                                      // Remove existing member from consultation via API
                                                      cubit.removeMemberFromConsultation(
                                                          widget.consultationId,
                                                          doctorModel.id
                                                              .toString());
                                                    } else {
                                                      // Remove newly selected doctor from local list
                                                      cubit.doctorsChecked
                                                          .removeWhere((d) =>
                                                              d.id ==
                                                              doctorModel.id);
                                                      cubit.updateScreen();
                                                    }
                                                  },
                                                  child: Icon(
                                                    Icons.clear,
                                                    size: 15.r,
                                                    color: Colors.red.shade700,
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
                      child: ShimmerLoadingPatientsCards(ishorizontal: false),
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
                        child: ShimmerLoadingPatientsCards(ishorizontal: false),
                      ),
                    );
                  }
                  if (isSearched) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: response!.data!.length,
                        padding: EdgeInsets.only(bottom: 150.h),
                        itemBuilder: (context, index) {
                          var doctorModel = response.data![index];

                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 8),
                            child: Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(10),
                                splashColor: AppColors.subBG,
                                onTap: () {
                                  navigatorKey.currentState?.pushNamed(
                                    AppRoutes.doctorInfoView,
                                    arguments:
                                        AppRoutesArgs.doctorInfoViewRouteArgs(
                                      doctorId: doctorModel.id.toString(),
                                      currentDoctorModel:
                                          widget.currentDoctorModel,
                                      isSyndicateCardRequired: widget
                                          .homeDataModel.isSyndicateCardRequired
                                          .toString(),
                                      initialIndex: 0,
                                      accountVerification:
                                          widget.homeDataModel.verified!,
                                      currentDoctorRole:
                                          widget.homeDataModel.role.toString(),
                                      currentDoctorPoints: int.parse(
                                          widget.homeDataModel.scoreValue!),
                                      homeDataModel: widget.homeDataModel,
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
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.4),
                                                      spreadRadius: 2,
                                                      blurRadius: 9,
                                                      offset:
                                                          const Offset(0, 3),
                                                    ),
                                                  ],
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          80.r),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      navigatorKey.currentState
                                                          ?.pushNamed(
                                                        AppRoutes
                                                            .doctorInfoView,
                                                        arguments: AppRoutesArgs
                                                            .doctorInfoViewRouteArgs(
                                                          doctorId: doctorModel
                                                              .id
                                                              .toString(),
                                                          initialIndex: 0,
                                                          currentDoctorModel: widget
                                                              .currentDoctorModel,
                                                          isSyndicateCardRequired:
                                                              widget
                                                                  .homeDataModel
                                                                  .isSyndicateCardRequired!,
                                                          homeDataModel: widget
                                                              .homeDataModel,
                                                          accountVerification:
                                                              widget.homeDataModel
                                                                      .verified ??
                                                                  true,
                                                          currentDoctorRole:
                                                              widget
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
                                                    child: CircleAvatar(
                                                      radius: 20.r,
                                                      backgroundColor: AppColors
                                                          .primary
                                                          .withOpacity(0.8),
                                                      child: doctorModel
                                                                  .image ==
                                                              null
                                                          ? Text(
                                                              doctorModel
                                                                  .firstName![0]
                                                                  .toUpperCase(),
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      16.sp),
                                                            )
                                                          : CustomCachedNetworkImage(
                                                              imageUrl:
                                                                  doctorModel
                                                                      .image
                                                                      .toString(),
                                                              height: 100.h,
                                                              width: 100.w,
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
                                                      Text(
                                                        doctorName(
                                                          firstName: doctorModel
                                                              .firstName,
                                                          lastName: doctorModel
                                                              .lastName,
                                                          role: doctorModel
                                                              .isSyndicateCardRequired
                                                              .toString(),
                                                        ),
                                                        style: TextStyle(
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                                        doctorModel.email ?? '',
                                                        style: TextStyle(
                                                          color: Colors
                                                              .grey.shade700,
                                                          fontSize: 10.sp,
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
                                              value: cubit.isDoctorChecked(
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
                                                              doctorModel.id)),
                                              // Disable checkbox for current doctor
                                              onChanged: doctorModel.id
                                                          .toString() ==
                                                      widget
                                                          .currentDoctorModel.id
                                                          .toString()
                                                  ? null
                                                  : (bool? value) {
                                                      if (value == true) {
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
                                                                    doctorModel
                                                                        .id))) {
                                                          cubit.doctorsChecked
                                                              .add(doctorModel);
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
                                                                    doctorModel
                                                                        .id);

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
                                                        }
                                                      }
                                                      animateToRightEndOfScreen(
                                                          cubit
                                                              .horizontalScrollController);
                                                      cubit.updateScreen();
                                                    },
                                              activeColor: AppColors.primary
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
  }
}
