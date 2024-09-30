import 'package:egy_akin/exports.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'outcome_state.freezed.dart';

@freezed
abstract class OutcomeState with _$OutcomeState {
  const factory OutcomeState.initial() = _Initial;
  const factory OutcomeState.loading() = _Loading;
  const factory OutcomeState.loaded(
    List<QuestionModel> questionList,
    bool isSubmitedOutcome,
    String message,
    int snackbarErrorCounter,
    bool isSubmitedOutcomeLoading,
    OutcomeSubmitterModel submitter,
  ) = _Loaded;
  const factory OutcomeState.error(String message) = _Error;
}
