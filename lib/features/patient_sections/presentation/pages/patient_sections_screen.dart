import 'dart:ui' as ui;
import 'package:egy_akin/features/patient_sections/presentation/widgets/consultation_button.dart';

import '../../../../exports.dart';

class PatientSectionsScreen extends StatefulWidget {
  final String patientId;
  final DoctorModel currentDoctorModel;
  final String currentDoctorRole;
  final int currentDoctorPoints;
  final bool isAllDataOpen;
  final HomeModelResponse homeDataModel;
  const PatientSectionsScreen({
    super.key,
    required this.patientId,
    required this.isAllDataOpen,
    required this.currentDoctorModel,
    required this.currentDoctorRole,
    required this.currentDoctorPoints,
    required this.homeDataModel,
  });

  @override
  State<PatientSectionsScreen> createState() => _PatientSectionsScreenState();
}

class _PatientSectionsScreenState extends State<PatientSectionsScreen> {
  @override
  void initState() {
    context.read<PatientSectionsCubit>().getPatientSections(widget.patientId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark));
    PatientSectionsCubit cubit = PatientSectionsCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: BlocConsumer<PatientSectionsCubit, PatientSectionsState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () {},
              error: (message) {
                customSnackBar(context: context, message: message);
              },
              loaded: (response,
                  isDelete,
                  isFinalSubmit,
                  message,
                  isLoading,
                  reportProgress,
                  filePath,
                  isDownloadingReport,
                  isDownloadedReport) {
                if (message != '') {
                  customSnackBar(context: context, message: message);
                }
                if (isDelete) {
                  Navigator.pushReplacementNamed(context, AppRoutes.home,
                      arguments: 0);
                }
                if (isFinalSubmit) {
                  Navigator.pushReplacementNamed(context, AppRoutes.home,
                      arguments: 0);
                }
                if (isDownloadedReport) {
                  launchURL(
                    url: cubit.reportPdfUrl,
                    onError: (error) {
                      showErrorDialog(context, error);
                    },
                  );
                }
              },
            );
          },
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () {
                return const Text(
                  '',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                );
              },
              loaded: (response,
                  isDelete,
                  isFinalSubmit,
                  message,
                  isLoading,
                  reportProgress,
                  filePath,
                  isDownloadingReport,
                  isDownloadedReport) {
                return Text(
                  (widget.currentDoctorModel.id.toString() ==
                              response.doctorId.toString() ||
                          widget.homeDataModel.role == AppStrings.roleAdmin)
                      ? response.patientName.toString()
                      : widget.isAllDataOpen
                          ? response.patientName.toString()
                          : convertTextToSymbols(
                              response.patientName.toString()),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textDirection: RegExp(r'[\u0600-\u06FF]')
                          .hasMatch(response.patientName.toString())
                      ? ui.TextDirection.rtl
                      : ui.TextDirection.ltr,
                );
              },
            );
          },
        ),
        centerTitle: true,
        // actions: [
        //   BlocBuilder<PatientSectionsCubit, PatientSectionsState>(
        //     builder: (context, state) {
        //       return state.maybeWhen(
        //         orElse: () {
        //           return const SizedBox.shrink();
        //         },
        //         loaded: (response,
        //             isDelete,
        //             isFinalSubmit,
        //             message,
        //             isLoading,
        //             reportProgress,
        //             filePath,
        //             isDownloadingReport,
        //             isDownloadedReport) {
        //           if ((response.doctorId.toString() ==
        //                   widget.currentDoctorModel.id.toString()) ||
        //               widget.currentDoctorRole == AppStrings.roleAdmin) {
        //             return Tooltip(
        //               message: 'Send consultation',
        //               child: Padding(
        //                 padding: EdgeInsets.only(right: 5.w),
        //                 child: InkWell(
        //                   onTap: () {
        //                     navigatorKey.currentState?.pushNamed(
        //                       AppRoutes.sendConsultation,
        //                       arguments:
        //                           AppRoutesArgs.sendConsultationRouteArgs(
        //                         homeDataModel: widget.homeDataModel,
        //                         currentDoctorModel: widget.currentDoctorModel,
        //                         patientId: widget.patientId,
        //                       ),
        //                     );
        //                   },
        //                   borderRadius: BorderRadius.circular(20.r),
        //                   child: Container(
        //                     height: 40.r,
        //                     width: 40.r,
        //                     decoration: const BoxDecoration(
        //                       shape: BoxShape.circle,
        //                       color: Colors.transparent,
        //                     ),
        //                     child: Center(
        //                       child: Image.asset(
        //                         AppImages.consultation,
        //                         height: 20.r,
        //                         color: Colors.white,
        //                       ),
        //                     ),
        //                   ),
        //                 ),
        //               ),
        //             );
        //           }
        //           return const SizedBox.shrink();
        //         },
        //       );
        //     },
        //   )
        // ],
      ),
      body: BlocConsumer<PatientSectionsCubit, PatientSectionsState>(
        listener: (context, state) {
          state.maybeWhen(
            orElse: () {},
            loaded: (response,
                isDelete,
                isFinalSubmit,
                message,
                isLoading,
                reportProgress,
                filePath,
                isDownloadingReport,
                isDownloadedReport) {
              if (message.isNotEmpty) {
                customSnackBar(context: context, message: message);
              }
            },
          );
        },
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return const ShimmerLoadingPatientsCards(ishorizontal: false);
            },
            loaded: (response,
                isDelete,
                isFinalSubmit,
                message,
                isLoading,
                reportProgress,
                filePath,
                isDownloadingReport,
                isDownloadedReport) {
              if (isLoading) {
                return const ShimmerLoadingPatientsCards(ishorizontal: false);
              } else {
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          response.gfr == null
                              ? const SizedBox.shrink()
                              : SizedBox(
                                  height: 120.h,
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 20),
                                    shrinkWrap: true,
                                    children: [
                                      EquationImplementation(
                                        equationName: 'CKD-EPI',
                                        currentCreatinineValue: response
                                            .gfr!.ckd!.currentGFR
                                            .toString(),
                                        basalCreatinineValue: response
                                            .gfr!.ckd!.basalCreatinine
                                            .toString(),
                                        creatinineOnDischargeValue: response
                                            .gfr!.ckd!.creatinineOnDischarge
                                            .toString(),
                                      ),
                                      EquationImplementation(
                                        equationName: 'Sobh Equation',
                                        currentCreatinineValue: response
                                            .gfr!.sobh!.currentGFR
                                            .toString(),
                                        basalCreatinineValue: response
                                            .gfr!.sobh!.basalCreatinine
                                            .toString(),
                                        creatinineOnDischargeValue: response
                                            .gfr!.sobh!.creatinineOnDischarge
                                            .toString(),
                                      ),
                                      EquationImplementation(
                                        equationName: 'MDRD',
                                        currentCreatinineValue: response
                                            .gfr!.mdrd!.currentGFR
                                            .toString(),
                                        basalCreatinineValue: response
                                            .gfr!.mdrd!.basalCreatinine
                                            .toString(),
                                        creatinineOnDischargeValue: response
                                            .gfr!.mdrd!.creatinineOnDischarge
                                            .toString(),
                                      ),
                                    ],
                                  ),
                                ),
                          SizedBox(height: 25.h),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              children: [
                                Text(
                                  'Request Consultation:',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13.sp,
                                      color: Colors.grey.shade600),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          ConsultationButtonsRow(
                            onDoctorConsultationTap: () {
                              navigatorKey.currentState?.pushNamed(
                                AppRoutes.sendConsultation,
                                arguments:
                                    AppRoutesArgs.sendConsultationRouteArgs(
                                  homeDataModel: widget.homeDataModel,
                                  currentDoctorModel: widget.currentDoctorModel,
                                  patientId: widget.patientId,
                                ),
                              );
                            },
                            onAiConsultationTap: () {
                              navigatorKey.currentState?.pushNamed(
                                  AppRoutes.consultationFromAi,
                                  arguments:
                                      AppRoutesArgs.consultationFromAiRouteArgs(
                                    patientId: widget.patientId,
                                  ));
                            },
                          ),
                          SizedBox(height: 25.h),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              children: [
                                Text(
                                  'Sections:',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13.sp,
                                      color: Colors.grey.shade600),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 20, left: 30, right: 30),
                            child: response.data == null ||
                                    response.data!.isEmpty
                                ? const SizedBox.shrink()
                                : ListView.builder(
                                    itemCount: response.data!.length,
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.only(bottom: 20),
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      var section = response.data![index];
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8),
                                        child: SectionCard(
                                          onTap: () {
                                            navigatorKey.currentState
                                                ?.pushNamed(
                                              AppRoutes.patientSectionDetails,
                                              arguments: AppRoutesArgs
                                                  .patientSectionDetailsRouteArgs(
                                                sectionModel: section,
                                                currentDoctorModel:
                                                    widget.currentDoctorModel,
                                                finalSubmitStatus:
                                                    response.submitStatus!,
                                                patientId: widget.patientId,
                                                currentDoctorRole:
                                                    widget.currentDoctorRole,
                                                currentDoctorPoints:
                                                    widget.currentDoctorPoints,
                                                homeDataModel:
                                                    widget.homeDataModel,
                                                doctorId: response.doctorId
                                                    .toString(),
                                                isAllDataOpen:
                                                    widget.isAllDataOpen,
                                              ),
                                            );
                                          },
                                          updatedAt: section.updatedAt ?? '',
                                          isSubmitStatus:
                                              section.sectionStatus ?? false,
                                          index: index,
                                          sectionName:
                                              section.sectionName ?? '',
                                        ),
                                      );
                                    },
                                  ),
                          ),
                          const SizedBox(height: 90),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: BlocBuilder<PatientSectionsCubit,
                          PatientSectionsState>(
                        builder: (context, state) {
                          return state.maybeWhen(
                            orElse: () {
                              return const SizedBox.shrink();
                            },
                            loaded: (response,
                                isDelete,
                                isFinalSubmit,
                                message,
                                isLoading,
                                reportProgress,
                                filePath,
                                isDownloadingReport,
                                isDownloadedReport) {
                              if ((response.doctorId.toString() ==
                                      widget.currentDoctorModel.id
                                          .toString()) &&
                                  (response.submitStatus != null &&
                                      !response.submitStatus!)) {
                                return FooterButtons(
                                  currentDoctorId:
                                      widget.currentDoctorModel.id.toString(),
                                  doctorId: response.doctorId!,
                                  patientName: response.patientName!,
                                  currentDoctorPoints:
                                      widget.currentDoctorPoints,
                                  cubit: cubit,
                                  patientId: widget.patientId,
                                  finalSubmit: response.submitStatus!,
                                  currentDoctorRole: widget.currentDoctorRole,
                                );
                              }
                              if (isDownloadingReport) {
                                return const SizedBox(
                                  height: 90,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 25,
                                          width: 25,
                                          child: CircularProgressIndicator(),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }

                              if (((response.doctorId.toString() ==
                                          widget.currentDoctorModel.id
                                              .toString()) &&
                                      (response.submitStatus == true) ||
                                  widget.currentDoctorRole ==
                                      AppStrings.roleAdmin)) {
                                return FooterButtons(
                                  currentDoctorId:
                                      widget.currentDoctorModel.id.toString(),
                                  doctorId: response.doctorId ?? '',
                                  patientName: response.patientName ?? '',
                                  currentDoctorPoints:
                                      widget.currentDoctorPoints,
                                  cubit: cubit,
                                  patientId: widget.patientId,
                                  finalSubmit: response.submitStatus ?? false,
                                  currentDoctorRole: widget.currentDoctorRole,
                                );
                              }
                              // if (widget.currentDoctorRole == 'Admin') {
                              //   return FooterButtons(
                              //     currentDoctorId:
                              //         widget.currentDoctorModel.id.toString(),
                              //     doctorId: response.doctorId ?? '',
                              //     patientName: response.patientName ?? '',
                              //     currentDoctorPoints:
                              //         widget.currentDoctorPoints,
                              //     cubit: cubit,
                              //     patientId: widget.patientId,
                              //     finalSubmit: response.submitStatus ?? false,
                              //     currentDoctorRole: widget.currentDoctorRole,
                              //   );
                              // }

                              return const SizedBox.shrink();
                            },
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
            },
          );
        },
      ),
    );
  }
}
