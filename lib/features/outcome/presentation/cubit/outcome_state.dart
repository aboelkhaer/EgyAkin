import 'package:egy_akin/exports.dart';
import 'package:egy_akin/features/patient_section_details/data/models/get_patient_section_model_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'outcome_state.freezed.dart';

@freezed
abstract class OutcomeState with _$OutcomeState {
  const factory OutcomeState.initial() = _Initial;
  const factory OutcomeState.loading() = _Loading;
  const factory OutcomeState.loaded(GetOutcomeModelResponse response,
      bool isSubmitedOutcome, String message) = _Loaded;
  const factory OutcomeState.error(String message) = _Error;
}
