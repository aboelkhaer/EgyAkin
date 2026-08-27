import 'dart:ui' as ui;

import 'package:egy_akin/app/shared/widgets/admin_only_badge.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';
import 'package:egy_akin/features/patient_sections/data/models/patient_sections_fake_data.dart';
import 'package:egy_akin/features/patient_sections/presentation/widgets/consultation_button.dart';
import 'package:egy_akin/features/patient_sections/presentation/widgets/patient_bmi_card.dart';
import 'package:egy_akin/features/patient_sections/presentation/widgets/patient_sections_comments_preview.dart';
import 'package:egy_akin/features/patient_sections/presentation/widgets/patient_sections_loading_shimmer.dart';
import 'package:egy_akin/app/shared/functions/permissions_helper.dart';

import '../../../../exports.dart';

/// Set to `false` when wiring Patient Sections back to the API.
const bool _kPatientSectionsDesignFakeData = false;

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
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<double> _collapseProgress = ValueNotifier<double>(0);

  static const double _collapseDistance = 72;

  @override
  void initState() {
    super.initState();
    if (!_kPatientSectionsDesignFakeData) {
      context.read<PatientSectionsCubit>().getPatientSections(widget.patientId);
    }
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final progress =
        (_scrollController.offset / _collapseDistance).clamp(0.0, 1.0);
    if ((progress - _collapseProgress.value).abs() > 0.01) {
      _collapseProgress.value = progress;
    }
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    _collapseProgress.dispose();
    super.dispose();
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

  String _displayPatientName(GetPatientSectionsModelResponse response) {
    final canSeeName = widget.currentDoctorModel.id.toString() ==
            response.doctorId.toString() ||
        PermissionHelper.canPermission(AppPermissions.viewPatientsName);

    final raw = response.patientName?.toString() ?? '';
    if (raw.isEmpty) return '';

    if (canSeeName || widget.isAllDataOpen) return raw;
    return convertTextToSymbols(raw);
  }

  String? _latestSavedLabel(
    BuildContext context,
    List<SectionModel> sections,
  ) {
    DateTime? latest;
    for (final section in sections) {
      final raw = section.updatedAt?.toString();
      if (raw == null || raw.isEmpty) continue;
      final parsed = DateTime.tryParse(raw);
      if (parsed == null) continue;
      if (latest == null || parsed.isAfter(latest)) {
        latest = parsed;
      }
    }
    if (latest == null) return null;
    return TimeAgoService.instance.formatTimeAgoFromString(
      latest.toIso8601String(),
      context,
    );
  }

  Future<void> _onBookmarkTap({
    required PatientSectionsCubit cubit,
    required bool isBookmarked,
  }) async {
    if (isBookmarked) {
      final hasUnmarkPermission = await PermissionHelper.hasPermission(
        AppPermissions.unmarkPatient,
      );
      if (!mounted) return;
      if (hasUnmarkPermission) {
        cubit.unmarkPatient(widget.patientId);
      } else {
        showCustomDialog(
          context: context,
          title: context.tr(AppStrings.attention),
          description: context.tr(
            AppStrings.youDontHavePermissionToUnmarkPatients,
          ),
          coloredButtonText: context.tr(AppStrings.ok),
          coloredButtonOnTap: () => Navigator.of(context).pop(),
          isNoColorShow: false,
        );
      }
    } else {
      final hasMarkPermission = await PermissionHelper.hasPermission(
        AppPermissions.markPatient,
      );
      if (!mounted) return;
      if (hasMarkPermission) {
        cubit.markPatient(widget.patientId);
      } else {
        showCustomDialog(
          context: context,
          title: context.tr(AppStrings.attention),
          description: context.tr(
            AppStrings.youDontHavePermissionToMarkPatients,
          ),
          coloredButtonText: context.tr(AppStrings.ok),
          coloredButtonOnTap: () => Navigator.of(context).pop(),
          isNoColorShow: false,
        );
      }
    }
  }

  String _resolvedDoctorId(GetPatientSectionsModelResponse response) {
    final fromApi = response.doctorId?.trim();
    if (fromApi != null && fromApi.isNotEmpty) return fromApi;
    // Missing doctor_Id must not become the literal "null" string.
    if (!widget.isAllDataOpen) {
      return widget.currentDoctorModel.id?.toString() ?? '';
    }
    return '';
  }

  void _openSection(
    SectionModel section,
    GetPatientSectionsModelResponse response,
  ) {
    navigatorKey.currentState?.pushNamed(
      AppRoutes.patientSectionDetails,
      arguments: AppRoutesArgs.patientSectionDetailsRouteArgs(
        sectionModel: section,
        currentDoctorModel: widget.currentDoctorModel,
        finalSubmitStatus: response.submitStatus ?? false,
        patientId: widget.patientId,
        currentDoctorRole: widget.currentDoctorRole,
        currentDoctorPoints: widget.currentDoctorPoints,
        homeDataModel: widget.homeDataModel,
        doctorId: _resolvedDoctorId(response),
        isAllDataOpen: widget.isAllDataOpen,
      ),
    );
  }

  Widget? _buildFooter({
    required PatientSectionsCubit cubit,
    required GetPatientSectionsModelResponse response,
    required bool isDownloadingReport,
    required bool isDark,
  }) {
    if ((response.doctorId.toString() ==
            widget.currentDoctorModel.id.toString()) &&
        (response.submitStatus != null && !response.submitStatus!)) {
      return FooterButtons(
        currentDoctorId: widget.currentDoctorModel.id.toString(),
        doctorId: response.doctorId!,
        patientName: response.patientName!,
        currentDoctorPoints: widget.currentDoctorPoints,
        cubit: cubit,
        patientId: widget.patientId,
        finalSubmit: response.submitStatus!,
        currentDoctorRole: widget.currentDoctorRole,
      );
    }

    if (isDownloadingReport) {
      return Container(
        height: 90.h,
        alignment: Alignment.center,
        color: isDark
            ? AppColors.darkScaffoldBG
            : HomeDashboardColors.scaffold(false),
        child: SizedBox(
          height: 25.w,
          width: 25.w,
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
            color: isDark ? AppColors.darkPrimary : AppColors.primary,
          ),
        ),
      );
    }

    if (((response.doctorId.toString() ==
                widget.currentDoctorModel.id.toString()) &&
            (response.submitStatus == true)) ||
        PermissionHelper.canPermission(
          AppPermissions.viewPatientsFinalSubmitAndDeleteContainerForAdmin,
        )) {
      return FooterButtons(
        currentDoctorId: widget.currentDoctorModel.id.toString(),
        doctorId: response.doctorId ?? '',
        patientName: response.patientName ?? '',
        currentDoctorPoints: widget.currentDoctorPoints,
        cubit: cubit,
        patientId: widget.patientId,
        finalSubmit: response.submitStatus ?? false,
        currentDoctorRole: widget.currentDoctorRole,
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final cubit = PatientSectionsCubit.get(context);

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final scaffold = HomeDashboardColors.scaffold(isDark);

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: isDark
              ? SystemUiOverlayStyle.light.copyWith(
                  statusBarColor: Colors.transparent,
                  statusBarIconBrightness: Brightness.light,
                  statusBarBrightness: Brightness.dark,
                )
              : SystemUiOverlayStyle.dark.copyWith(
                  statusBarColor: Colors.transparent,
                  statusBarIconBrightness: Brightness.dark,
                  statusBarBrightness: Brightness.light,
                ),
          child: Scaffold(
            backgroundColor: scaffold,
            body: BlocConsumer<PatientSectionsCubit, PatientSectionsState>(
              listener: (context, state) {
                state.maybeWhen(
                  orElse: () {},
                  error: (message) {
                    customSnackBar(context: context, message: message);
                  },
                  loaded: (
                    response,
                    isDelete,
                    isFinalSubmit,
                    message,
                    isLoading,
                    reportProgress,
                    filePath,
                    isDownloadingReport,
                    isDownloadedReport,
                    counterChanges,
                  ) {
                    if (message != '') {
                      customSnackBar(context: context, message: message);
                    }
                    if (isDelete || isFinalSubmit) {
                      final homeCubit = sl<HomeCubit>();
                      homeCubit.tabsController.jumpToTab(0);
                      homeCubit.getHome();
                      Navigator.of(context).popUntil(
                        (route) =>
                            route.settings.name == AppRoutes.home ||
                            route.isFirst,
                      );
                    }
                    if (isDownloadedReport) {
                      _showReportReadyDialog(context, cubit.reportPdfUrl);
                    }
                  },
                );
              },
              builder: (context, state) {
                if (_kPatientSectionsDesignFakeData) {
                  final response = PatientSectionsFakeData.response(
                    doctorId: widget.currentDoctorModel.id.toString(),
                  );
                  cubit.sectionsDataList = response.data;
                  return _buildLoadedBody(
                    context: context,
                    cubit: cubit,
                    isDark: isDark,
                    response: response,
                    isDownloadingReport: false,
                  );
                }

                return state.maybeWhen(
                  orElse: () => PatientSectionsLoadingShimmer(isDark: isDark),
                  loaded: (
                    response,
                    isDelete,
                    isFinalSubmit,
                    message,
                    isLoading,
                    reportProgress,
                    filePath,
                    isDownloadingReport,
                    isDownloadedReport,
                    counterChanges,
                  ) {
                    if (isLoading) {
                      return PatientSectionsLoadingShimmer(isDark: isDark);
                    }

                    return _buildLoadedBody(
                      context: context,
                      cubit: cubit,
                      isDark: isDark,
                      response: response,
                      isDownloadingReport: isDownloadingReport,
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoadedBody({
    required BuildContext context,
    required PatientSectionsCubit cubit,
    required bool isDark,
    required GetPatientSectionsModelResponse response,
    required bool isDownloadingReport,
  }) {
    final sections = response.data ?? <SectionModel>[];
    final pending = <({SectionModel section, int index})>[];
    final completed = <({SectionModel section, int index})>[];
    for (var i = 0; i < sections.length; i++) {
      final section = sections[i];
      if (section.sectionStatus == true) {
        completed.add((section: section, index: i));
      } else {
        pending.add((section: section, index: i));
      }
    }

    final total = sections.length;
    final doneCount = completed.length;
    final pendingCount = pending.length;
    final percent = total == 0 ? 0 : ((doneCount / total) * 100).round();
    final patientName = _displayPatientName(response);
    final savedLabel = _latestSavedLabel(context, sections);
    final hasBmi = PatientBmiCard.hasData(
      bmi: response.bmi,
      bmiCategory: response.bmiCategory,
    );
    final hasInsights = response.gfr != null || hasBmi;
    final footer = _buildFooter(
      cubit: cubit,
      response: response,
      isDownloadingReport: isDownloadingReport,
      isDark: isDark,
    );
    final canConsult = widget.currentDoctorModel.id.toString() ==
            response.doctorId.toString() ||
        widget.homeDataModel.role == AppStrings.roleAdmin;

    return Stack(
      children: [
        Positioned.fill(
          child: ColoredBox(
            color: HomeDashboardColors.scaffold(isDark),
          ),
        ),
        Column(
          children: [
            _HeaderGlowBackground(
              isDark: isDark,
              child: SafeArea(
                bottom: false,
                child: ValueListenableBuilder<double>(
                  valueListenable: _collapseProgress,
                  builder: (context, progress, _) {
                    return _CollapsingHeader(
                      isDark: isDark,
                      progress: progress,
                      patientName: patientName,
                      percent: percent,
                      savedLabel: savedLabel,
                      textDirection: RegExp(r'[\u0600-\u06FF]').hasMatch(
                        response.patientName?.toString() ?? '',
                      )
                          ? ui.TextDirection.rtl
                          : ui.TextDirection.ltr,
                      isBookmarked: response.isMarked ?? false,
                      onBack: () => Navigator.of(context).pop(),
                      onBookmark: () => _onBookmarkTap(
                        cubit: cubit,
                        isBookmarked: response.isMarked ?? false,
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: CustomScrollView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                slivers: [
                  if (hasInsights)
                    SliverToBoxAdapter(
                      child: _SectionLabel(
                        isDark: isDark,
                        title: response.gfr != null && hasBmi
                            ? context.tr(AppStrings.gfrEquationsAndBmi)
                            : (hasBmi
                                ? context.tr(AppStrings.bmiUpper)
                                : context.tr(AppStrings.gfrEquations)),
                      ),
                    ),
                  if (hasInsights)
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 104.h,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.fromLTRB(
                            16.w,
                            0,
                            4.w,
                            0,
                          ),
                          children: [
                            if (hasBmi)
                              PatientBmiCard(
                                bmi: response.bmi,
                                bmiCategory: response.bmiCategory,
                              ),
                            if (response.gfr != null) ...[
                              EquationImplementation(
                                equationName: context.tr(AppStrings.ckdEpiShort),
                                currentCreatinineValue: response
                                    .gfr!.ckd!.currentGFR!.value
                                    .toString(),
                                basalCreatinineValue: response
                                    .gfr!.ckd!.basalCreatinine!.value
                                    .toString(),
                                creatinineOnDischargeValue: response
                                    .gfr!.ckd!.creatinineOnDischarge!.value
                                    .toString(),
                                currentCreatinineLocalization:
                                    response.gfr!.ckd!.currentGFR!.localization,
                                basalCreatinineLocalization: response
                                    .gfr!.ckd!.basalCreatinine!.localization,
                                creatinineOnDischargeLocalization: response
                                    .gfr!
                                    .ckd!
                                    .creatinineOnDischarge!
                                    .localization,
                              ),
                              EquationImplementation(
                                equationName:
                                    context.tr(AppStrings.sobhEquation),
                                currentCreatinineValue: response
                                    .gfr!.sobh!.currentGFR!.value
                                    .toString(),
                                basalCreatinineValue: response
                                    .gfr!.sobh!.basalCreatinine!.value
                                    .toString(),
                                creatinineOnDischargeValue: response
                                    .gfr!.sobh!.creatinineOnDischarge!.value
                                    .toString(),
                                currentCreatinineLocalization: response
                                    .gfr!.sobh!.currentGFR!.localization,
                                basalCreatinineLocalization: response
                                    .gfr!.sobh!.basalCreatinine!.localization,
                                creatinineOnDischargeLocalization: response
                                    .gfr!
                                    .sobh!
                                    .creatinineOnDischarge!
                                    .localization,
                              ),
                              EquationImplementation(
                                equationName: context.tr(AppStrings.mdrdShort),
                                currentCreatinineValue: response
                                    .gfr!.mdrd!.currentGFR!.value
                                    .toString(),
                                basalCreatinineValue: response
                                    .gfr!.mdrd!.basalCreatinine!.value
                                    .toString(),
                                creatinineOnDischargeValue: response
                                    .gfr!.mdrd!.creatinineOnDischarge!.value
                                    .toString(),
                                currentCreatinineLocalization: response
                                    .gfr!.mdrd!.currentGFR!.localization,
                                basalCreatinineLocalization: response
                                    .gfr!.mdrd!.basalCreatinine!.localization,
                                creatinineOnDischargeLocalization: response
                                    .gfr!
                                    .mdrd!
                                    .creatinineOnDischarge!
                                    .localization,
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  if (canConsult) ...[
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.only(top: 8.h),
                        child: _SectionLabel(
                          isDark: isDark,
                          title: context.tr(AppStrings.consultationUpper),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: AdminOnlyBadge(
                        style: BadgeStyle.premium,
                        glowEffect: true,
                        pulseAnimation: true,
                        badgeText: 'A',
                        showIcon: false,
                        fontSize: 8.sp,
                        badgePadding: EdgeInsets.symmetric(
                          horizontal: 5.w,
                          vertical: 1.h,
                        ),
                        showBadge:
                            widget.homeDataModel.role == AppStrings.roleAdmin &&
                                widget.currentDoctorModel.id.toString() !=
                                    response.doctorId.toString(),
                        top: 0,
                        right: 24,
                        child: ConsultationButtonsRow(
                          onDoctorConsultationTap: () {
                            navigatorKey.currentState?.pushNamed(
                              AppRoutes.sendConsultation,
                              arguments:
                                  AppRoutesArgs.sendConsultationRouteArgs(
                                homeDataModel: widget.homeDataModel,
                                currentDoctorModel: widget.currentDoctorModel,
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
                              arguments:
                                  AppRoutesArgs.consultationFromAiRouteArgs(
                                patientId: widget.patientId,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(top: 8.h),
                      child: PatientSectionsCommentsPreview(
                        isDark: isDark,
                        patientId: widget.patientId,
                        patientName: patientName,
                        currentDoctorModel: widget.currentDoctorModel,
                        currentDoctorRole: widget.currentDoctorRole,
                        currentDoctorPoints: widget.currentDoctorPoints,
                        homeDataModel: widget.homeDataModel,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(top: 8.h),
                      child: _SectionLabel(
                        isDark: isDark,
                        title: LocalizationService.instance
                            .translate(AppStrings.sections)
                            .toUpperCase(),
                        trailing: pendingCount > 0
                            ? _PillBadge(
                                label:
                                    '$pendingCount ${context.tr(AppStrings.pendingLower)}',
                                color: const Color(0xFFF59E0B),
                                isDark: isDark,
                              )
                            : null,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                      ),
                      child: _ProgressSummaryCard(
                        isDark: isDark,
                        percent: percent,
                        doneCount: doneCount,
                        pendingCount: pendingCount,
                        total: total,
                      ),
                    ),
                  ),
                  if (pending.isNotEmpty) ...[
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                          16.w,
                          12.h,
                          16.w,
                          8.h,
                        ),
                        child: _GroupHeader(
                          isDark: isDark,
                          label: context.tr(AppStrings.needsAttention),
                          count: pendingCount,
                          color: const Color(0xFFF59E0B),
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      sliver: SliverList.separated(
                        itemCount: pending.length,
                        separatorBuilder: (_, __) => SizedBox(height: 10.h),
                        itemBuilder: (context, i) {
                          final item = pending[i];
                          return SectionCard(
                            onTap: () => _openSection(
                              item.section,
                              response,
                            ),
                            updatedAt: item.section.updatedAt?.toString(),
                            isSubmitStatus: false,
                            index: item.index,
                            sectionName: item.section.sectionName ?? '',
                          );
                        },
                      ),
                    ),
                  ],
                  if (completed.isNotEmpty) ...[
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                          16.w,
                          12.h,
                          16.w,
                          8.h,
                        ),
                        child: _GroupHeader(
                          isDark: isDark,
                          label: context.tr(AppStrings.completed),
                          count: doneCount,
                          color: const Color(0xFF22C55E),
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      sliver: SliverList.separated(
                        itemCount: completed.length,
                        separatorBuilder: (_, __) => SizedBox(height: 10.h),
                        itemBuilder: (context, i) {
                          final item = completed[i];
                          return SectionCard(
                            onTap: () => _openSection(
                              item.section,
                              response,
                            ),
                            updatedAt: item.section.updatedAt?.toString(),
                            isSubmitStatus: true,
                            index: item.index,
                            sectionName: item.section.sectionName ?? '',
                          );
                        },
                      ),
                    ),
                  ],
                  SliverToBoxAdapter(
                    child: SizedBox(
                                      height: footer == null ? 12.h : 110.h,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        if (footer != null)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: footer,
          ),
      ],
    );
  }
}

class _HeaderGlowBackground extends StatelessWidget {
  final bool isDark;
  final Widget child;

  const _HeaderGlowBackground({
    required this.isDark,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final base = isDark
        ? HomeDashboardColors.headerDark
        : HomeDashboardColors.headerLight;
    final glow = isDark ? const Color(0xFF5B3FA0) : AppColors.primary;
    final scaffold = HomeDashboardColors.scaffold(isDark);

    return ClipRect(
      child: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    base,
                    Color.lerp(base, scaffold, isDark ? 0.35 : 0.55)!,
                    scaffold,
                  ],
                  stops: const [0, 0.72, 1],
                ),
              ),
            ),
          ),
          Positioned(
            top: -50.h,
            right: -30.w,
            child: IgnorePointer(
              child: Container(
                width: 240.w,
                height: 240.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      glow.withOpacity(isDark ? 0.55 : 0.18),
                      glow.withOpacity(isDark ? 0.18 : 0.08),
                      glow.withOpacity(0),
                    ],
                    stops: const [0, 0.45, 1],
                  ),
                ),
              ),
            ),
          ),
          if (isDark)
            Positioned(
              top: -20.h,
              left: 40.w,
              right: 40.w,
              child: IgnorePointer(
                child: Container(
                  height: 120.h,
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFF6B47E6).withOpacity(0.22),
                        const Color(0xFF6B47E6).withOpacity(0),
                      ],
                    ),
                  ),
                ),
              ),
            )
          else
            Positioned(
              top: -10.h,
              left: 24.w,
              right: 24.w,
              child: IgnorePointer(
                child: Container(
                  height: 90.h,
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      colors: [
                        AppColors.primary.withOpacity(0.1),
                        AppColors.primary.withOpacity(0),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          child,
        ],
      ),
    );
  }
}

class _CollapsingHeader extends StatelessWidget {
  final bool isDark;
  final double progress;
  final String patientName;
  final int percent;
  final String? savedLabel;
  final ui.TextDirection textDirection;
  final bool isBookmarked;
  final VoidCallback onBack;
  final VoidCallback onBookmark;

  const _CollapsingHeader({
    required this.isDark,
    required this.progress,
    required this.patientName,
    required this.percent,
    required this.savedLabel,
    required this.textDirection,
    required this.isBookmarked,
    required this.onBack,
    required this.onBookmark,
  });

  @override
  Widget build(BuildContext context) {
    final titleColor = HomeDashboardColors.title(isDark);
    final subtitleColor = HomeDashboardColors.subtitle(isDark);
    final circleBg = isDark
        ? const Color(0xFF2A2733)
        : Colors.white;
    final circleBorder = HomeDashboardColors.border(isDark);
    final iconColor = HomeDashboardColors.title(isDark);
    final primary = HomeDashboardColors.primary(isDark);
    final nameSize = ui.lerpDouble(18.sp, 14.sp, progress)!;
    final subtitleOpacity = (1 - progress).clamp(0.0, 1.0);
    final subtitleHeight = ui.lerpDouble(18.h, 0, progress)!;

    return Padding(
      padding: EdgeInsets.fromLTRB(12.w, 2.h, 12.w, 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _RoundIconButton(
                icon: Icons.arrow_back_ios_new_rounded,
                background: circleBg,
                borderColor: circleBorder,
                iconColor: iconColor,
                isDark: isDark,
                onTap: onBack,
              ),
              const Spacer(),
              _RoundIconButton(
                icon: isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                background: circleBg,
                borderColor: circleBorder,
                iconColor: isBookmarked ? primary : iconColor,
                isDark: isDark,
                onTap: onBookmark,
              ),
            ],
          ),
          SizedBox(height: ui.lerpDouble(12.h, 4.h, progress)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  patientName,
                  textDirection: textDirection,
                  maxLines: progress > 0.6 ? 1 : 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: nameSize,
                    height: 1.15,
                    fontWeight: FontWeight.w800,
                    color: titleColor,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: primary.withOpacity(isDark ? 0.22 : 0.12),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color: primary.withOpacity(isDark ? 0.28 : 0.18),
                  ),
                ),
                child: Text(
                  '$percent%',
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w700,
                    color: primary,
                  ),
                ),
              ),
            ],
          ),
          ClipRect(
            child: Align(
              alignment: Alignment.topLeft,
              heightFactor: subtitleOpacity,
              child: Opacity(
                opacity: subtitleOpacity,
                child: SizedBox(
                  height: subtitleHeight <= 0 ? 0 : null,
                  child: Padding(
                    padding: EdgeInsets.only(top: 6.h),
                    child: Row(
                      children: [
                        Text(
                          context.tr(AppStrings.patientSections),
                          style: TextStyle(
                            fontSize: 10.5.sp,
                            fontWeight: FontWeight.w500,
                            color: subtitleColor,
                          ),
                        ),
                        if (savedLabel != null) ...[
                          Text(
                            '  ·  ',
                            style: TextStyle(
                              fontSize: 9.5.sp,
                              color: subtitleColor,
                            ),
                          ),
                          Icon(
                            Icons.check_circle_rounded,
                            size: 11.sp,
                            color: HomeDashboardColors.success,
                          ),
                          SizedBox(width: 3.w),
                          Flexible(
                            child: Text(
                              '${context.tr(AppStrings.saved)} $savedLabel',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 9.5.sp,
                                fontWeight: FontWeight.w500,
                                height: 1.25,
                                color: subtitleColor,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  final IconData icon;
  final Color background;
  final Color borderColor;
  final Color iconColor;
  final bool isDark;
  final VoidCallback onTap;

  const _RoundIconButton({
    required this.icon,
    required this.background,
    required this.borderColor,
    required this.iconColor,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: background,
      elevation: isDark ? 0 : 1.5,
      shadowColor: Colors.black.withOpacity(0.12),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Container(
          width: 36.w,
          height: 36.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: borderColor, width: 1),
          ),
          child: Icon(icon, size: 16.sp, color: iconColor),
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final bool isDark;
  final String title;
  final Widget? trailing;

  const _SectionLabel({
    required this.isDark,
    required this.title,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final color = HomeDashboardColors.subtitle(isDark);
    final line = HomeDashboardColors.border(isDark);

    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 6.h, 16.w, 10.h),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.7,
              color: color,
            ),
          ),
          if (trailing != null) ...[
            SizedBox(width: 8.w),
            trailing!,
          ],
          SizedBox(width: 10.w),
          Expanded(
            child: Container(
              height: 1,
              color: line,
            ),
          ),
        ],
      ),
    );
  }
}

class _PillBadge extends StatelessWidget {
  final String label;
  final Color color;
  final bool isDark;

  const _PillBadge({
    required this.label,
    required this.color,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: color.withOpacity(isDark ? 0.18 : 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 9.sp,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }
}

class _ProgressSummaryCard extends StatelessWidget {
  final bool isDark;
  final int percent;
  final int doneCount;
  final int pendingCount;
  final int total;

  const _ProgressSummaryCard({
    required this.isDark,
    required this.percent,
    required this.doneCount,
    required this.pendingCount,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final cardBg = HomeDashboardColors.cardBg(isDark);
    final border = HomeDashboardColors.border(isDark);
    final titleColor = HomeDashboardColors.title(isDark);
    final primary = HomeDashboardColors.primary(isDark);
    const completed = HomeDashboardColors.success;
    const pending = HomeDashboardColors.warning;

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: border.withOpacity(isDark ? 1 : 0.85)),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 12,
                  offset: const Offset(0, 3),
                ),
              ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: 56.w,
            height: 56.w,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 56.w,
                  height: 56.w,
                  child: CircularProgressIndicator(
                    value: total == 0 ? 0 : doneCount / total,
                    strokeWidth: 5.5,
                    backgroundColor: primary.withOpacity(isDark ? 0.18 : 0.12),
                    valueColor: AlwaysStoppedAnimation<Color>(primary),
                    strokeCap: StrokeCap.round,
                  ),
                ),
                Text(
                  '$percent%',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w800,
                    color: titleColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$doneCount ${context.tr(AppStrings.of)} $total ${context.tr(AppStrings.completeLower)}',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: titleColor,
                  ),
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    _LegendDot(
                      color: completed,
                      label:
                          '$doneCount ${context.tr(AppStrings.doneLower)}',
                    ),
                    SizedBox(width: 12.w),
                    _LegendDot(
                      color: pending,
                      label:
                          '$pendingCount ${context.tr(AppStrings.pendingLower)}',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 7.w,
          height: 7.w,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 5.w),
        Text(
          label,
          style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }
}

class _GroupHeader extends StatelessWidget {
  final bool isDark;
  final String label;
  final int count;
  final Color color;

  const _GroupHeader({
    required this.isDark,
    required this.label,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final titleColor = HomeDashboardColors.title(isDark);

    return Row(
      children: [
        Container(
          width: 7.w,
          height: 7.w,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 8.w),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
            color: titleColor,
          ),
        ),
        SizedBox(width: 6.w),
        Container(
          width: 18.w,
          height: 18.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color.withOpacity(isDark ? 0.18 : 0.12),
            shape: BoxShape.circle,
          ),
          child: Text(
            '$count',
            style: TextStyle(
              fontSize: 9.sp,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
