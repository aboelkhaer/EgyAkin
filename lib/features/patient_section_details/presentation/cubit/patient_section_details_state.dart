import 'package:egy_akin/features/patient_section_details/data/models/get_recommendations_model_response.dart';
import 'package:egy_akin/features/patient_section_details/data/models/search_for_dose_model_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../exports.dart';
part 'patient_section_details_state.freezed.dart';

@freezed
abstract class PatientSectionDetailsState with _$PatientSectionDetailsState {
  const factory PatientSectionDetailsState.initial() = _Initial;
  const factory PatientSectionDetailsState.loading() = _Loading;
  const factory PatientSectionDetailsState.loaded(
    List<QuestionModel> questions,
    bool isSubmitLoading,
    bool isSubmitted,
    String message,
    int snackbarErrorCounter,
    bool isChooseFilesLoading,
    bool isChooseFilesLoaded,
    double uploadFilesProgress,
    bool isGetMedicationsLoading,
    bool isGetMedicationsLoaded,
    bool isSearchMedicationLoading,
    int counterChanges,
    bool isCreateMedicationLoading,
    bool isCreateMedicationLoaded,
    String dialogMessage,
  ) = Loaded;
  const factory PatientSectionDetailsState.medicationSectionLoaded(
    GetRecommendationsModelResponse response,
    int changesCounter,
    String snackBarMessage,
    String dialogMessage,
    bool isSubmitLoading,
    bool isSubmitLoaded,
    bool isSearchMedicationLoading,
    SearchForDoseInMedicationSectionModelResponse? searchForDoseInMedicationSectionResponse,
    bool isDeletePatientRecommendationLoading,
  ) = MedicationSectionLoaded;

  const factory PatientSectionDetailsState.error(String message) = _Error;
}
