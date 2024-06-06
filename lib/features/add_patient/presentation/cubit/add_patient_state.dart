import 'package:egy_akin/exports.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'add_patient_state.freezed.dart';

@freezed
abstract class AddPatientState with _$AddPatientState {
  const factory AddPatientState.initial() = _Initial;
  const factory AddPatientState.loading() = _Loading;
  const factory AddPatientState.loaded(
    List<QuestionModel> questions,
    bool isAddedPatientSuccessfully,
    int patientId,
    bool isAddPatientLoading,
    String message,
    int snackbarErrorCounter,
  ) = _Loaded;
  const factory AddPatientState.error(String message) = _Error;
}
