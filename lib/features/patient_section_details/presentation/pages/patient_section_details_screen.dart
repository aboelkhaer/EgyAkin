import 'package:egy_akin/features/ai_form_upload/presentation/pages/ai_form_upload_screen.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';
import 'package:egy_akin/features/patient_section_details/presentation/widgets/build_dose_section.dart';
import 'package:egy_akin/features/patient_section_details/presentation/widgets/build_section_details_if_final_submit_false.dart';
import 'package:egy_akin/features/patient_section_details/presentation/widgets/build_section_details_if_final_submit_true.dart';
import 'package:egy_akin/features/patient_section_details/data/models/patient_recommendation_model.dart';
import 'package:egy_akin/features/record/presentation/cubit/record_cubit.dart';
import 'package:egy_akin/features/record/presentation/pages/record_screen.dart';
import 'package:egy_akin/app/shared/functions/permissions_helper.dart';
import 'package:egy_akin/app/shared/permissions/app_permissions.dart';

import '../../../../exports.dart';
import '../../../../app/services/theme_bloc.dart';

class PatientSectionDetailsScreen extends StatefulWidget {
  final DoctorModel currentDoctorModel;
  final SectionModel sectionModel;
  final bool finalSubmitStatus;
  final String patientId;
  final String doctorId;
  final HomeModelResponse homeDataModel;
  final String currentDoctorRole;
  final int currentDoctorPoints;
  final bool isAllDataOpen;
  const PatientSectionDetailsScreen({
    super.key,
    required this.currentDoctorModel,
    required this.sectionModel,
    required this.finalSubmitStatus,
    required this.patientId,
    required this.doctorId,
    required this.currentDoctorRole,
    required this.currentDoctorPoints,
    required this.homeDataModel,
    required this.isAllDataOpen,
  });

  @override
  State<PatientSectionDetailsScreen> createState() =>
      _PatientSectionDetailsScreenState();
}

class _PatientSectionDetailsScreenState
    extends State<PatientSectionDetailsScreen> {
  late TextEditingController _recommendationController;
  final GlobalKey<FormState> _recommendationFormKey = GlobalKey<FormState>();

  /// Patient final-submit locks editing, unless this section is always_open.
  /// - finalSubmit=false                   → always editable
  /// - finalSubmit=true + alwaysOpen=true  → editable
  /// - finalSubmit=true + alwaysOpen=false → read-only
  bool get _isSectionAlwaysOpen => widget.sectionModel.alwaysOpen == true;

  bool get _isEditingLocked =>
      widget.finalSubmitStatus && !_isSectionAlwaysOpen;

  /// Editable form vs read-only summary. Ownership is NOT used here —
  /// finalSubmit / always_open alone decide lock state.
  bool get _canEditSection {
    if (widget.currentDoctorRole == AppStrings.roleAdmin) return true;
    if (!widget.finalSubmitStatus) return true;
    return _isSectionAlwaysOpen;
  }

  @override
  void initState() {
    _recommendationController = TextEditingController();
    if (widget.sectionModel.sectionId == 12) {
      context
          .read<PatientSectionDetailsCubit>()
          .getMedicationSection(widget.patientId.toString());
    } else {
      context.read<PatientSectionDetailsCubit>().getPatientSectionDetails(
          widget.sectionModel.sectionId.toString(),
          widget.patientId.toString());
    }
    super.initState();
  }

  @override
  void dispose() {
    _recommendationController.dispose();
    super.dispose();
  }

  void _showAddRecommendationBottomSheet(BuildContext context) {
    final cubit = PatientSectionDetailsCubit.get(context);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;

          return BlocProvider<PatientSectionDetailsCubit>.value(
            value: cubit,
            child: StatefulBuilder(
              builder: (context, setState) {
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isDarkMode ? AppColors.darkCardBG : Colors.white,
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(24)),
                      boxShadow: [
                        BoxShadow(
                          color: isDarkMode
                              ? Colors.black.withOpacity(0.3)
                              : Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, -2),
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Form(
                          key: _recommendationFormKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Header
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        context
                                            .tr(AppStrings.addRecommendation),
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          color: isDarkMode
                                              ? AppColors.darkTitle
                                              : Colors.black87,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        context.tr(AppStrings
                                            .addANewRecommendationNote),
                                        style: TextStyle(
                                          fontSize: 11.sp,
                                          color: isDarkMode
                                              ? AppColors.darkDescription
                                              : Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      _recommendationController.clear();
                                    },
                                    icon: Icon(
                                      Icons.close,
                                      color: isDarkMode
                                          ? AppColors.darkDescription
                                          : Colors.grey[600],
                                      size: 24,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                              // Form Fields
                              Container(
                                decoration: BoxDecoration(
                                  color: isDarkMode
                                      ? AppColors.darkSurface
                                      : Colors.grey[50],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    // Recommendation Content Field
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              context.tr(
                                                  AppStrings.recommendation),
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w500,
                                                color: isDarkMode
                                                    ? AppColors.darkTitle
                                                    : Colors.black87,
                                              ),
                                            ),
                                            Text(
                                              ' *',
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        CustomTextFormField(
                                          title: '',
                                          textFormFieldController:
                                              _recommendationController,
                                          textInputType:
                                              TextInputType.multiline,
                                          maxLines: 5,
                                          onChanged: (value) {
                                            setState(
                                                () {}); // Trigger rebuild when text changes
                                          },
                                          validator: (value) {
                                            if (value == null ||
                                                value.trim().isEmpty) {
                                              return context.tr(AppStrings
                                                  .pleaseEnterRecommendation);
                                            }
                                            return null;
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 24),
                              // Action Button
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: _recommendationController.text
                                          .trim()
                                          .isEmpty
                                      ? null
                                      : () {
                                          // Validate form
                                          if (!_recommendationFormKey
                                              .currentState!
                                              .validate()) {
                                            return;
                                          }

                                          // Create new recommendation
                                          final newRecommendation =
                                              PatientRecommendationModel(
                                            id: DateTime.now()
                                                .millisecondsSinceEpoch
                                                .toString(),
                                            doseName: null,
                                            dose: null,
                                            route: null,
                                            frequency: null,
                                            duration: null,
                                            type: MedicineTypeEnum.note.name,
                                            content: _recommendationController
                                                .text
                                                .trim(),
                                          );

                                          // Add to list
                                          context
                                              .read<
                                                  PatientSectionDetailsCubit>()
                                              .addPatientRecommendation(
                                                newRecommendation,
                                                widget.patientId,
                                              );

                                          // Clear and close
                                          _recommendationController.clear();
                                          Navigator.pop(context);
                                        },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: _recommendationController
                                            .text
                                            .trim()
                                            .isEmpty
                                        ? Colors.grey
                                        : (isDarkMode
                                            ? AppColors.darkPrimary
                                            : AppColors.primary),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Text(
                                    context.tr(AppStrings.addRecommendation),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Future<void> _openVoice(PatientSectionDetailsCubit cubit) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => sl<RecordCubit>(),
          child: RecordScreen(
            questions: cubit.questionModelList,
            source: 'section_details',
            sectionId: widget.sectionModel.sectionId.toString(),
            aiMode: 'voice',
            aiHintHtml: cubit.sectionAiHint,
            aiVoiceTime: cubit.sectionAiVoiceTime,
          ),
        ),
      ),
    );
    if (result is Map<String, dynamic>) {
      cubit.applyVoiceAnswers(result);
      if (mounted) setState(() {});
    }
  }

  Future<void> _openImageAi(PatientSectionDetailsCubit cubit) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AiFormUploadScreen(
          sectionId: widget.sectionModel.sectionId.toString(),
        ),
      ),
    );
    if (result is Map) {
      cubit.applyVoiceAnswers(Map<String, dynamic>.from(result));
      if (mounted) setState(() {});
    }
  }

  Future<void> _onAddRecommendation() async {
    final hasPermission = await PermissionHelper.hasPermission(
      AppPermissions.createRecommendation,
    );
    if (!mounted) return;
    if (hasPermission) {
      _showAddRecommendationBottomSheet(context);
    } else {
      showCustomDialog(
        context: context,
        title: context.tr(AppStrings.attention),
        description:
            context.tr(AppStrings.youDontHavePermissionToCreateRecommendations),
        coloredButtonText: context.tr(AppStrings.ok),
        coloredButtonOnTap: () => Navigator.of(context).pop(),
        isNoColorShow: false,
      );
    }
  }

  void _popSectionDetails(BuildContext context) {
    final cubit = PatientSectionDetailsCubit.get(context);
    Navigator.of(context).pop(cubit.markSectionCompletedOnPop);
  }

  @override
  Widget build(BuildContext context) {
    PatientSectionDetailsCubit cubit = PatientSectionDetailsCubit.get(context);

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState is ThemeLoaded && themeState.isDarkMode;
        final primary = isDark ? AppColors.darkPrimary : AppColors.primary;
        final scaffold = HomeDashboardColors.scaffold(isDark);
        final titleColor = HomeDashboardColors.title(isDark);

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
          child: PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, _) {
              if (didPop) return;
              _popSectionDetails(context);
            },
            child: Scaffold(
              backgroundColor: scaffold,
              body: Column(
                children: [
                  AnimatedContainer(
                    duration: Duration.zero,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: isDark
                            ? [
                                const Color(0xFF4A2F7A),
                                const Color(0xFF2B1A52),
                                scaffold,
                              ]
                            : [
                                primary.withOpacity(0.28),
                                primary.withOpacity(0.14),
                                scaffold,
                              ],
                        stops: const [0.0, 0.55, 1.0],
                      ),
                    ),
                    child: SafeArea(
                      bottom: false,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(14.w, 4.h, 14.w, 8.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _SectionRoundIconButton(
                              isDark: isDark,
                              icon: Icons.arrow_back_ios_new_rounded,
                              onTap: () => _popSectionDetails(context),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  animateToTopOfScreen(
                                    cubit.patientSectionDetailsScrollController,
                                  );
                                },
                                child: Text(
                                  widget.sectionModel.sectionName.toString(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w800,
                                    color: isDark ? Colors.white : titleColor,
                                    letterSpacing: -0.2,
                                  ),
                                ),
                              ),
                            ),
                            BlocBuilder<PatientSectionDetailsCubit,
                                PatientSectionDetailsState>(
                              builder: (context, _) {
                                final currentAiMode =
                                    PatientSectionDetailsCubit.get(context)
                                        .sectionAiMode;
                                final canShowAiActions =
                                    !(widget.sectionModel.sectionStatus ??
                                            false) &&
                                        !_isEditingLocked;
                                return Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (canShowAiActions &&
                                        currentAiMode == 'voice') ...[
                                      SizedBox(width: 8.w),
                                      _SectionAiActionButton(
                                        primary: primary,
                                        icon: Icons.mic_rounded,
                                        onTap: () => _openVoice(cubit),
                                      ),
                                    ],
                                    if (canShowAiActions &&
                                        currentAiMode == 'image') ...[
                                      SizedBox(width: 8.w),
                                      _SectionAiActionButton(
                                        primary: primary,
                                        icon: Icons.image_outlined,
                                        onTap: () => _openImageAi(cubit),
                                      ),
                                    ],
                                    if (widget.sectionModel.sectionId == 12 &&
                                        !_isEditingLocked) ...[
                                      SizedBox(width: 8.w),
                                      _SectionRoundIconButton(
                                        isDark: isDark,
                                        icon: Icons.add_rounded,
                                        onTap: _onAddRecommendation,
                                      ),
                                    ],
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: BlocConsumer<PatientSectionDetailsCubit,
                        PatientSectionDetailsState>(
                      listener: (context, state) {
                        state.maybeWhen(
                            orElse: () {},
                            error: (message) {
                              customSnackBar(
                                  context: context, message: message);
                            },
                            medicationSectionLoaded: (
                              response,
                              changesCounter,
                              snackBarMessage,
                              dialogMessage,
                              isSubmitLoading,
                              isSubmitLoaded,
                              isSearchMedicationLoading,
                              searchForDoseInMedicationSectionResponse,
                              isDeletePatientRecommendationLoading,
                              isSeeMore,
                            ) {
                              if (snackBarMessage.isNotEmpty) {
                                customSnackBar(
                                    context: context, message: snackBarMessage);
                              }
                            });
                      },
                      builder: (context, state) {
                        return state.maybeWhen(
                          orElse: () {
                            return _SectionDetailsLoadingView(
                              isDark: isDark,
                              primary: primary,
                            );
                          },
                          loaded: (
                            questions,
                            isSubmitLoading,
                            isSubmitted,
                            message,
                            snackbarErrorCounter,
                            isChooseFilesLoading,
                            isChooseFilesLoaded,
                            uploadFilesProgress,
                            isGetMedicationsLoading,
                            isGetMedicationsLoaded,
                            isSearchMedicationLoading,
                            counterChanges,
                            isCreateMedicationLoading,
                            isCreateMedicationLoaded,
                            dialogMessage,
                          ) {
                            // finalSubmit=false → editable
                            // finalSubmit=true + always_open → editable
                            // finalSubmit=true + !always_open → read-only
                            if (_canEditSection) {
                              return BuildSectionDetailsIfFinalSubmitFalse(
                                questions: questions,
                                patientId: widget.patientId,
                                doctorId: widget.doctorId,
                                sectionModel: widget.sectionModel,
                                homeDataModel: widget.homeDataModel,
                                currentDoctorModel: widget.currentDoctorModel,
                                finalSubmitStatus: widget.finalSubmitStatus,
                                isAllDataOpen: widget.isAllDataOpen,
                              );
                            }

                            return BuildSectionDetailsIfFinalSubmitTrue(
                              questionList: cubit.questionModelList,
                              doctorId: widget.doctorId,
                              isAllDataOpen: widget.isAllDataOpen,
                              currentDoctorId:
                                  widget.currentDoctorModel.id.toString(),
                            );
                          },
                          medicationSectionLoaded: (
                            response,
                            changesCounter,
                            snackBarMessage,
                            dialogMessage,
                            isSubmitLoading,
                            isSubmitLoaded,
                            isSearchMedicationLoading,
                            searchForDoseInMedicationSectionResponse,
                            isDeletePatientRecommendationLoading,
                            isSeeMore,
                          ) {
                            return BlocProvider<
                                PatientSectionDetailsCubit>.value(
                              value: cubit,
                              child: BuildDoseSection(
                                currentDoctorModel: widget.currentDoctorModel,
                                patientId: widget.patientId,
                                doctorId: widget.doctorId,
                                sectionModel: widget.sectionModel,
                                homeDataModel: widget.homeDataModel,
                                finalSubmitStatus: _isEditingLocked,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SectionRoundIconButton extends StatelessWidget {
  final bool isDark;
  final IconData icon;
  final VoidCallback onTap;

  const _SectionRoundIconButton({
    required this.isDark,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38.r,
        height: 38.r,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isDark ? const Color(0xFF2A2A2E) : Colors.white,
          border: Border.all(
            color: isDark
                ? Colors.white.withOpacity(0.08)
                : const Color(0xFFE8E8EE),
          ),
          boxShadow: isDark
              ? null
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Icon(
          icon,
          size: 15.sp,
          color: HomeDashboardColors.title(isDark),
        ),
      ),
    );
  }
}

class _SectionAiActionButton extends StatelessWidget {
  final Color primary;
  final IconData icon;
  final VoidCallback onTap;

  const _SectionAiActionButton({
    required this.primary,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 34.r,
            height: 34.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  primary,
                  Color.lerp(primary, const Color(0xFFB794F6), 0.35)!,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: primary.withOpacity(0.35),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 16.sp,
            ),
          ),
          Positioned(
            top: -2.h,
            right: -2.w,
            child: Container(
              width: 13.r,
              height: 13.r,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: primary, width: 1),
              ),
              child: Icon(
                Icons.auto_awesome,
                size: 7.sp,
                color: primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionDetailsLoadingView extends StatelessWidget {
  final bool isDark;
  final Color primary;

  const _SectionDetailsLoadingView({
    required this.isDark,
    required this.primary,
  });

  @override
  Widget build(BuildContext context) {
    final cardBg = isDark ? const Color(0xFF1C1C1E) : Colors.white;
    final shimmer = isDark ? const Color(0xFF2A2A2E) : const Color(0xFFE8E8EE);

    return ListView.separated(
      padding: EdgeInsets.fromLTRB(14.w, 10.h, 14.w, 24.h),
      itemCount: 6,
      separatorBuilder: (_, __) => SizedBox(height: 8.h),
      itemBuilder: (_, __) {
        return Container(
          padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: isDark
                  ? Colors.white.withOpacity(0.06)
                  : const Color(0xFFE8E8EE),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 12.h,
                width: 140.w,
                decoration: BoxDecoration(
                  color: shimmer,
                  borderRadius: BorderRadius.circular(6.r),
                ),
              ),
              SizedBox(height: 12.h),
              Container(
                height: 42.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: shimmer.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
