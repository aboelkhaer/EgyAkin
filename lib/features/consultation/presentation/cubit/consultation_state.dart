import 'package:egy_akin/features/consultation/data/models/get_current_doctor_consultation_model_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'consultation_state.freezed.dart';

@freezed
abstract class ConsultationState with _$ConsultationState {
  const factory ConsultationState.initial() = _Initial;
  const factory ConsultationState.loading() = _Loading;

  const factory ConsultationState.loaded(
      GetCurrentDoctorConsultationModelResponse
          allCurrentDoctorConsultation) = _Loaded;
  const factory ConsultationState.error(String message) = _Error;
}
