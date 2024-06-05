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
      int snackbarErrorCounter) = Loaded;

  const factory PatientSectionDetailsState.error(String message) = _Error;
}
