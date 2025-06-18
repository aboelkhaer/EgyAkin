import 'package:egy_akin/features/patient_section_details/presentation/widgets/build_dose_section.dart';
import 'package:egy_akin/features/patient_section_details/presentation/widgets/build_section_details_if_final_submit_false.dart';
import 'package:egy_akin/features/patient_section_details/presentation/widgets/build_section_details_if_final_submit_true.dart';

import '../../../../exports.dart';

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
  @override
  void initState() {
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
  Widget build(BuildContext context) {
    PatientSectionDetailsCubit cubit = PatientSectionDetailsCubit.get(context);

    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
            onTap: () {
              animateToTopOfScreen(cubit.patientSectionDetailsScrollController);
            },
            child: Text(
              widget.sectionModel.sectionName.toString(),
            )),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        actions: const [],
      ),
      body:
          BlocConsumer<PatientSectionDetailsCubit, PatientSectionDetailsState>(
        listener: (context, state) {
          state.maybeWhen(
            orElse: () {},
            error: (message) {
              customSnackBar(context: context, message: message);
            },
            medicationSectionLoaded: (response, changesCounter, snackBarMessage, dialogMessage, isSubmitLoading, isSubmitLoaded, isSearchMedicationLoading, searchForDoseInMedicationSectionResponse, isDeletePatientRecommendationLoading) {
              if(snackBarMessage.isNotEmpty){
                customSnackBar(context: context, message: snackBarMessage);
              }
            }
          );
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
              if (widget.finalSubmitStatus) {
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
  }
}
