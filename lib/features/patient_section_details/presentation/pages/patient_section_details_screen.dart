import 'package:egy_akin/features/patient_section_details/presentation/widgets/build_dose_section.dart';
import 'package:egy_akin/features/patient_section_details/presentation/widgets/build_section_details_if_final_submit_false.dart';
import 'package:egy_akin/features/patient_section_details/presentation/widgets/build_section_details_if_final_submit_true.dart';
import 'package:egy_akin/features/patient_section_details/data/models/patient_recommendation_model.dart';

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

  @override
  Widget build(BuildContext context) {
    PatientSectionDetailsCubit cubit = PatientSectionDetailsCubit.get(context);

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;

        return Scaffold(
          backgroundColor: isDarkMode ? AppColors.darkScaffoldBG : Colors.white,
          appBar: AppBar(
            title: GestureDetector(
                onTap: () {
                  animateToTopOfScreen(
                      cubit.patientSectionDetailsScrollController);
                },
                child: Text(
                  widget.sectionModel.sectionName.toString(),
                  style: TextStyle(
                    color: isDarkMode ? AppColors.darkTitle : Colors.white,
                  ),
                )),
            centerTitle: true,
            backgroundColor:
                isDarkMode ? AppColors.darkCardBG : AppColors.primary,
            systemOverlayStyle: SystemUiOverlayStyle.light,
            actions: [
              // Only show add recommendation button for medication section and when not final submitted
              if (widget.sectionModel.sectionId == 12 &&
                  !widget.finalSubmitStatus)
                IconButton(
                  onPressed: () {
                    // Show add recommendation bottom sheet
                    _showAddRecommendationBottomSheet(context);
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
            ],
          ),
          body: BlocConsumer<PatientSectionDetailsCubit,
              PatientSectionDetailsState>(
            listener: (context, state) {
              state.maybeWhen(
                  orElse: () {},
                  error: (message) {
                    customSnackBar(context: context, message: message);
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
                  return const ShimmerLoadingPatientsCards(ishorizontal: false);
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
                  if (widget.currentDoctorRole == AppStrings.roleAdmin) {
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
                  if (widget.finalSubmitStatus &&
                      widget.sectionModel.sectionId != 12) {
                    return BuildSectionDetailsIfFinalSubmitTrue(
                      questionList: cubit.questionModelList,
                      doctorId: widget.doctorId,
                      isAllDataOpen: widget.isAllDataOpen,
                      currentDoctorId: widget.currentDoctorModel.id.toString(),
                    );
                  }
                  if (widget.doctorId.toString() !=
                      widget.currentDoctorModel.id.toString()) {
                    BuildSectionDetailsIfFinalSubmitTrue(
                      questionList: cubit.questionModelList,
                      doctorId: widget.doctorId,
                      isAllDataOpen: widget.isAllDataOpen,
                      currentDoctorId: widget.currentDoctorModel.id.toString(),
                    );
                  }

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
                  return BlocProvider<PatientSectionDetailsCubit>.value(
                    value: cubit,
                    child: BuildDoseSection(
                      currentDoctorModel: widget.currentDoctorModel,
                      patientId: widget.patientId,
                      doctorId: widget.doctorId,
                      sectionModel: widget.sectionModel,
                      homeDataModel: widget.homeDataModel,
                      finalSubmitStatus: widget.finalSubmitStatus,
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
