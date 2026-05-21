import 'dart:ui' as ui;
import 'package:egy_akin/app/shared/widgets/admin_only_badge.dart';
import 'package:egy_akin/features/patient_sections/presentation/widgets/consultation_button.dart';
import 'package:egy_akin/app/shared/functions/permissions_helper.dart';
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

  void _showReportReadyDialog(BuildContext context, String reportUrl) {
    final trimmed = reportUrl.trim();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!context.mounted) return;
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (dialogContext) {
          final isDark = Theme.of(dialogContext).brightness == Brightness.dark;
          return AlertDialog(
            backgroundColor: isDark ? AppColors.darkCardBG : Colors.white,
            title: Text(
              context.tr(AppStrings.reportReady),
              style: TextStyle(
                color: isDark ? AppColors.darkTitle : Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    context.tr(AppStrings.reportUrlSelectableHint),
                    style: TextStyle(
                      color:
                          isDark ? AppColors.darkDescription : Colors.black54,
                      fontSize: 13.sp,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Material(
                    color: AppColors.primary.withOpacity(isDark ? 0.12 : 0.08),
                    borderRadius: BorderRadius.circular(8.r),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8.r),
                      onTap: trimmed.isEmpty
                          ? null
                          : () {
                              Clipboard.setData(ClipboardData(text: trimmed));
                              if (context.mounted) {
                                customSnackBar(
                                  context: context,
                                  message:
                                      context.tr(AppStrings.reportLinkCopied),
                                );
                              }
                            },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 12.h,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                trimmed.isEmpty ? '—' : trimmed,
                                style: TextStyle(
                                  color: isDark
                                      ? AppColors.darkTitle
                                      : AppColors.primary,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Icon(
                              Icons.copy_rounded,
                              size: 22.sp,
                              color: isDark
                                  ? AppColors.darkDescription
                                  : AppColors.primary,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: Text(
                  context.tr(AppStrings.cancel),
                  style: TextStyle(
                    color: isDark ? AppColors.darkDescription : Colors.black54,
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.of(dialogContext).pop();
                  if (!context.mounted) return;
                  if (trimmed.isEmpty) {
                    customSnackBar(
                      context: context,
                      message: context.tr(AppStrings.somethingWentWrong),
                    );
                    return;
                  }

                  launchURL(
                    url: trimmed,
                    externalBrowserOnly: true,
                    onError: (error) {
                      if (!context.mounted) return;
                      showErrorDialog(context, error);
                    },
                  );
                },
                child: Text(
                  context.tr(AppStrings.open),
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark));
    PatientSectionsCubit cubit = PatientSectionsCubit.get(context);

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;

        return Scaffold(
          appBar: AppBar(
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
                      isDownloadedReport,
                      counterChanges) {
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
                      _showReportReadyDialog(context, cubit.reportPdfUrl);
                    }
                  },
                );
              },
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () {
                    return const Text(
                      '',
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
                      isDownloadedReport,
                      counterChanges) {
                    return Text(
                      (widget.currentDoctorModel.id.toString() ==
                                  response.doctorId.toString() ||
                              PermissionHelper.canPermission(
                                  AppPermissions.viewPatientsName))
                          ? response.patientName == null
                              ? ''
                              : response.patientName.toString()
                          : widget.isAllDataOpen
                              ? response.patientName == null
                                  ? ''
                                  : response.patientName.toString()
                              : convertTextToSymbols(
                                  response.patientName.toString()),
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
            actions: [
              BlocBuilder<PatientSectionsCubit, PatientSectionsState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () => const SizedBox.shrink(),
                    loaded: (response,
                        isDelete,
                        isFinalSubmit,
                        message,
                        isLoading,
                        reportProgress,
                        filePath,
                        isDownloadingReport,
                        isDownloadedReport,
                        counterChanges) {
                      final isBookmarked = response.isMarked ?? false;
                      return IconButton(
                        onPressed: () async {
                          if (isBookmarked) {
                            // Check unmark permission
                            final hasUnmarkPermission =
                                await PermissionHelper.hasPermission(
                              AppPermissions.unmarkPatient,
                            );

                            if (!mounted) return;

                            if (hasUnmarkPermission) {
                              cubit.unmarkPatient(widget.patientId);
                            } else {
                              // Show permission denied dialog
                              showCustomDialog(
                                context: context,
                                title: context.tr(AppStrings.attention),
                                description: context.tr(AppStrings
                                    .youDontHavePermissionToUnmarkPatients),
                                coloredButtonText: context.tr(AppStrings.ok),
                                coloredButtonOnTap: () =>
                                    Navigator.of(context).pop(),
                                isNoColorShow: false,
                              );
                            }
                          } else {
                            // Check mark permission
                            final hasMarkPermission =
                                await PermissionHelper.hasPermission(
                              AppPermissions.markPatient,
                            );

                            if (!mounted) return;

                            if (hasMarkPermission) {
                              cubit.markPatient(widget.patientId);
                            } else {
                              // Show permission denied dialog
                              showCustomDialog(
                                context: context,
                                title: context.tr(AppStrings.attention),
                                description: context.tr(AppStrings
                                    .youDontHavePermissionToMarkPatients),
                                coloredButtonText: context.tr(AppStrings.ok),
                                coloredButtonOnTap: () =>
                                    Navigator.of(context).pop(),
                                isNoColorShow: false,
                              );
                            }
                          }
                        },
                        icon: Icon(
                          isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                          color:
                              isBookmarked ? AppColors.white : AppColors.white,
                        ),
                      );
                    },
                  );
                },
              ),
            ],
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
                    isDownloadedReport,
                    counterChanges) {
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
                    isDownloadedReport,
                    counterChanges) {
                  if (isLoading) {
                    return const ShimmerLoadingPatientsCards(
                        ishorizontal: false);
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
                                                .gfr!.ckd!.currentGFR!.value
                                                .toString(),
                                            basalCreatinineValue: response.gfr!
                                                .ckd!.basalCreatinine!.value
                                                .toString(),
                                            creatinineOnDischargeValue: response
                                                .gfr!
                                                .ckd!
                                                .creatinineOnDischarge!
                                                .value
                                                .toString(),
                                            currentCreatinineLocalization:
                                                response.gfr!.ckd!.currentGFR!
                                                    .localization,
                                            basalCreatinineLocalization:
                                                response
                                                    .gfr!
                                                    .ckd!
                                                    .basalCreatinine!
                                                    .localization,
                                            creatinineOnDischargeLocalization:
                                                response
                                                    .gfr!
                                                    .ckd!
                                                    .creatinineOnDischarge!
                                                    .localization,
                                          ),
                                          EquationImplementation(
                                            equationName: 'Sobh Equation',
                                            currentCreatinineValue: response
                                                .gfr!.sobh!.currentGFR!.value
                                                .toString(),
                                            basalCreatinineValue: response.gfr!
                                                .sobh!.basalCreatinine!.value
                                                .toString(),
                                            creatinineOnDischargeValue: response
                                                .gfr!
                                                .sobh!
                                                .creatinineOnDischarge!
                                                .value
                                                .toString(),
                                            currentCreatinineLocalization:
                                                response.gfr!.sobh!.currentGFR!
                                                    .localization,
                                            basalCreatinineLocalization:
                                                response
                                                    .gfr!
                                                    .sobh!
                                                    .basalCreatinine!
                                                    .localization,
                                            creatinineOnDischargeLocalization:
                                                response
                                                    .gfr!
                                                    .sobh!
                                                    .creatinineOnDischarge!
                                                    .localization,
                                          ),
                                          EquationImplementation(
                                            equationName: 'MDRD',
                                            currentCreatinineValue: response
                                                .gfr!.mdrd!.currentGFR!.value
                                                .toString(),
                                            basalCreatinineValue: response.gfr!
                                                .mdrd!.basalCreatinine!.value
                                                .toString(),
                                            creatinineOnDischargeValue: response
                                                .gfr!
                                                .mdrd!
                                                .creatinineOnDischarge!
                                                .value
                                                .toString(),
                                            currentCreatinineLocalization:
                                                response.gfr!.mdrd!.currentGFR!
                                                    .localization,
                                            basalCreatinineLocalization:
                                                response
                                                    .gfr!
                                                    .mdrd!
                                                    .basalCreatinine!
                                                    .localization,
                                            creatinineOnDischargeLocalization:
                                                response
                                                    .gfr!
                                                    .mdrd!
                                                    .creatinineOnDischarge!
                                                    .localization,
                                          ),
                                        ],
                                      ),
                                    ),
                              widget.currentDoctorModel.id.toString() ==
                                          response.doctorId.toString() ||
                                      widget.homeDataModel.role ==
                                          AppStrings.roleAdmin
                                  ? AdminOnlyBadge(
                                      style: BadgeStyle.premium,
                                      glowEffect: true,
                                      pulseAnimation: true,
                                      badgeText: 'A',
                                      showIcon: false,
                                      fontSize: 8.sp,
                                      badgePadding: EdgeInsets.symmetric(
                                          horizontal: 5.w, vertical: 1.h),
                                      showBadge: widget.homeDataModel.role ==
                                              AppStrings.roleAdmin &&
                                          widget.currentDoctorModel.id
                                                  .toString() !=
                                              response.doctorId.toString(),
                                      top: 15,
                                      right: 10,
                                      child: Column(
                                        children: [
                                          SizedBox(height: 25.h),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20, right: 20),
                                            child: Row(
                                              children: [
                                                Text(
                                                  '${LocalizationService.instance.translate(AppStrings.requestConsultation)}:',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13.sp,
                                                      color:
                                                          Colors.grey.shade600),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          ConsultationButtonsRow(
                                            onDoctorConsultationTap: () {
                                              navigatorKey.currentState
                                                  ?.pushNamed(
                                                AppRoutes.sendConsultation,
                                                arguments: AppRoutesArgs
                                                    .sendConsultationRouteArgs(
                                                  homeDataModel:
                                                      widget.homeDataModel,
                                                  currentDoctorModel:
                                                      widget.currentDoctorModel,
                                                  patientId: widget.patientId,
                                                  isSendConsultation: true,
                                                  groupId: '',
                                                  isForAddNewDoctors: false,
                                                  consultationId: '',
                                                  ownerOfConsultationId: '',
                                                ),
                                              );
                                            },
                                            onAiConsultationTap: () {
                                              navigatorKey.currentState?.pushNamed(
                                                  AppRoutes.consultationFromAi,
                                                  arguments: AppRoutesArgs
                                                      .consultationFromAiRouteArgs(
                                                    patientId: widget.patientId,
                                                  ));
                                            },
                                          ),
                                        ],
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                              SizedBox(height: 25.h),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Row(
                                  children: [
                                    Text(
                                      '${LocalizationService.instance.translate(AppStrings.sections)}:',
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
                                        padding:
                                            const EdgeInsets.only(bottom: 20),
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          var section = response.data![index];
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8),
                                            child: SectionCard(
                                              onTap: () {
                                                navigatorKey.currentState
                                                    ?.pushNamed(
                                                  AppRoutes
                                                      .patientSectionDetails,
                                                  arguments: AppRoutesArgs
                                                      .patientSectionDetailsRouteArgs(
                                                    sectionModel: section,
                                                    currentDoctorModel: widget
                                                        .currentDoctorModel,
                                                    finalSubmitStatus:
                                                        response.submitStatus!,
                                                    patientId: widget.patientId,
                                                    currentDoctorRole: widget
                                                        .currentDoctorRole,
                                                    currentDoctorPoints: widget
                                                        .currentDoctorPoints,
                                                    homeDataModel:
                                                        widget.homeDataModel,
                                                    doctorId: response.doctorId
                                                        .toString(),
                                                    isAllDataOpen:
                                                        widget.isAllDataOpen,
                                                  ),
                                                );
                                              },
                                              updatedAt:
                                                  section.updatedAt ?? '',
                                              isSubmitStatus:
                                                  section.sectionStatus ??
                                                      false,
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
                                    isDownloadedReport,
                                    counterChanges) {
                                  if ((response.doctorId.toString() ==
                                          widget.currentDoctorModel.id
                                              .toString()) &&
                                      (response.submitStatus != null &&
                                          !response.submitStatus!)) {
                                    return FooterButtons(
                                      currentDoctorId: widget
                                          .currentDoctorModel.id
                                          .toString(),
                                      doctorId: response.doctorId!,
                                      patientName: response.patientName!,
                                      currentDoctorPoints:
                                          widget.currentDoctorPoints,
                                      cubit: cubit,
                                      patientId: widget.patientId,
                                      finalSubmit: response.submitStatus!,
                                      currentDoctorRole:
                                          widget.currentDoctorRole,
                                    );
                                  }
                                  if (isDownloadingReport) {
                                    return Container(
                                      height: 90,
                                      padding:
                                          const EdgeInsets.only(bottom: 20),
                                      color: isDarkMode
                                          ? AppColors.darkScaffoldBG
                                          : Colors.grey.shade100,
                                      child: const Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: 25,
                                              width: 25,
                                              child:
                                                  CircularProgressIndicator(),
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
                                      PermissionHelper.canPermission(AppPermissions
                                          .viewPatientsFinalSubmitAndDeleteContainerForAdmin))) {
                                    return FooterButtons(
                                      currentDoctorId: widget
                                          .currentDoctorModel.id
                                          .toString(),
                                      doctorId: response.doctorId ?? '',
                                      patientName: response.patientName ?? '',
                                      currentDoctorPoints:
                                          widget.currentDoctorPoints,
                                      cubit: cubit,
                                      patientId: widget.patientId,
                                      finalSubmit:
                                          response.submitStatus ?? false,
                                      currentDoctorRole:
                                          widget.currentDoctorRole,
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
      },
    );
  }
}
