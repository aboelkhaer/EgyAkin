import 'dart:developer';

import 'package:egy_akin/app/shared/functions/animate_to_right_end_of_screen.dart';
import 'package:egy_akin/app/shared/functions/doctor_name.dart';
import 'package:egy_akin/features/send_consultation/presentation/cubit/send_consultation_state.dart';

import '../../../../exports.dart';

class SendConsultationScreen extends StatelessWidget {
  final HomeModelResponse homeDataModel;
  final DoctorModel currentDoctorModel;
  final String patientId;
  const SendConsultationScreen(
      {super.key,
      required this.homeDataModel,
      required this.currentDoctorModel,
      required this.patientId});

  @override
  Widget build(BuildContext context) {
    SendConsultationCubit cubit = SendConsultationCubit.get(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Send Consultation',
        ),
        actions: [
          IconButton(
              onPressed: () {
                if (cubit.doctorsChecked.isEmpty) {
                  customSnackBar(
                      context: context,
                      message: 'Please select at least one doctor to proceed.');
                } else {
                  showCustomDialog(
                    context: context,
                    title: 'Consultation',
                    noColoredButtonText: 'Cancel',
                    isWithTextField: true,
                    textFormFieldMaxLines: 3,
                    textInputType: TextInputType.multiline,
                    onChangedTextFormField: (value) {
                      cubit.consultMessage = value;
                    },
                    noColoredButtonOnTap: () {
                      Navigator.pop(context);
                    },
                    description: 'Write note for chosen doctors.',
                    coloredButtonText: 'Send',
                    coloredButtonOnTap: () {
                      Navigator.pop(context);
                      cubit.sendConsultation(patientId);
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
          // BlocBuilder<SendConsultationCubit, SendConsultationState>(
          //   builder: (context, state) {
          //     return state.maybeWhen(
          //       orElse: () {
          //         return const SizedBox.shrink();
          //       },
          //       loaded: (isSearching, isSearched, message, response,
          //           counterChanges) {
          //         if (cubit.doctorsChecked.isNotEmpty) {
          //           return Column(
          //             children: [
          //               FadeIn(
          //                 child: SizedBox(
          //                   height: 50.w,
          //                   width: 50.w,
          //                   child: FloatingActionButton(
          //                     shape: RoundedRectangleBorder(
          //                       borderRadius: BorderRadius.circular(50.0),
          //                     ),
          //                     onPressed: () {
          //                       // Action for second FAB
          //                     },
          //                     child: Icon(
          //                       Icons.send,
          //                       color: Colors.white,
          //                       size: 20.r,
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //               SizedBox(height: 10.h),
          //             ],
          //           );
          //         }
          //         return const SizedBox.shrink();
          //       },
          //     );
          //   },
          // ),
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
                      hintText: 'Search with doctor name or email...',
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
                    return cubit.doctorsChecked.isEmpty
                        ? const SizedBox.shrink()
                        : FadeIn(
                            child: Column(
                              children: [
                                // const Row(
                                //   children: [
                                //     Expanded(child: Divider()),
                                //   ],
                                // ),
                                // SizedBox(height: 5.h),
                                SizedBox(
                                  height: 45.h,
                                  child: ListView.builder(
                                    itemCount: cubit.doctorsChecked.length,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.only(top: 5.h),
                                    controller:
                                        cubit.horizontalScrollController,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      var doctorModel =
                                          cubit.doctorsChecked[index];
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
                                                          currentDoctorModel:
                                                              currentDoctorModel,
                                                          isSyndicateCardRequired:
                                                              homeDataModel
                                                                  .isSyndicateCardRequired
                                                                  .toString(),
                                                          accountVerification:
                                                              homeDataModel
                                                                  .verified!,
                                                          currentDoctorRole:
                                                              homeDataModel.role
                                                                  .toString(),
                                                          currentDoctorPoints:
                                                              int.parse(
                                                                  homeDataModel
                                                                      .scoreValue!),
                                                          homeDataModel:
                                                              homeDataModel,
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
                                            Positioned(
                                              top: 0,
                                              right: 5.w,
                                              child: GestureDetector(
                                                onTap: () {
                                                  cubit.doctorsChecked
                                                      .removeWhere((d) =>
                                                          d.id ==
                                                          doctorModel.id);
                                                  cubit.updateScreen();
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
                loaded: (isSearching,
                    isSearched,
                    message,
                    response,
                    counterChanges,
                    isSendingConsultation,
                    isSendedConsultation) {
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
                loaded: (isSearching, isSearched, message, response, _,
                    isSendingConsultation, isSendedConsultation) {
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
                                      currentDoctorModel: currentDoctorModel,
                                      isSyndicateCardRequired: homeDataModel
                                          .isSyndicateCardRequired
                                          .toString(),
                                      accountVerification:
                                          homeDataModel.verified!,
                                      currentDoctorRole:
                                          homeDataModel.role.toString(),
                                      currentDoctorPoints:
                                          int.parse(homeDataModel.scoreValue!),
                                      homeDataModel: homeDataModel,
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
                                                          currentDoctorModel:
                                                              currentDoctorModel,
                                                          isSyndicateCardRequired:
                                                              homeDataModel
                                                                  .isSyndicateCardRequired!,
                                                          homeDataModel:
                                                              homeDataModel,
                                                          accountVerification:
                                                              homeDataModel
                                                                      .verified ??
                                                                  true,
                                                          currentDoctorRole:
                                                              homeDataModel
                                                                  .role!,
                                                          currentDoctorPoints:
                                                              int.parse(
                                                                  homeDataModel
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
                                                          role: '',
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
                                              value: cubit
                                                  .isDoctorChecked(doctorModel),
                                              onChanged: (bool? value) {
                                                if (value == true) {
                                                  cubit.doctorsChecked
                                                      .add(doctorModel);
                                                } else {
                                                  cubit.doctorsChecked
                                                      .removeWhere((d) =>
                                                          d.id ==
                                                          doctorModel.id);
                                                }
                                                animateToRightEndOfScreen(cubit
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
