import 'package:freezed_annotation/freezed_annotation.dart';
part 'consultation_from_ai_state.freezed.dart';

@freezed
abstract class ConsultationFromAIState with _$ConsultationFromAIState {
  const factory ConsultationFromAIState.initial() = _Initial;
  const factory ConsultationFromAIState.loading() = _Loading;

  const factory ConsultationFromAIState.loaded() = _Loaded;
  const factory ConsultationFromAIState.error(String message) = _Error;
}
