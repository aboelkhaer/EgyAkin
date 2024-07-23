import 'package:freezed_annotation/freezed_annotation.dart';
part 'send_consultation_state.freezed.dart';

@freezed
abstract class SendConsultationState with _$SendConsultationState {
  const factory SendConsultationState.initial() = _Initial;
  const factory SendConsultationState.loading() = _Loading;
  const factory SendConsultationState.loaded() = _Loaded;

  const factory SendConsultationState.error(String message) = _Error;
}
