import 'package:egy_akin/features/doctor_info_view/data/models/get_doctor_profile_score_history_model_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'score_history_state.freezed.dart';

@freezed
abstract class ScoreHistoryState with _$ScoreHistoryState {
  const factory ScoreHistoryState.initial() = _Initial;
  const factory ScoreHistoryState.loading() = _Loading;
  const factory ScoreHistoryState.loaded(
          GetDoctorProfileScoreDataModelResponse scoreHistory, bool isSeeMore) =
      _Loaded;

  const factory ScoreHistoryState.error(String message) = _Error;
}
