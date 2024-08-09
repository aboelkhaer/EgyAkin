import 'package:egy_akin/features/consultation/data/models/get_current_doctor_consultation_model_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'consultation_state.freezed.dart';

@freezed
abstract class ConsultationState with _$ConsultationState {
  const factory ConsultationState.initial() = _Initial;
  const factory ConsultationState.myConsultationsLoading() =
      _MyConsultationsLoading;

  const factory ConsultationState.myConsultationsLoaded(
      List<GetCurrentDoctorConsultationModelResponse>
          allCurrentDoctorConsultation) = _MyConsultationsLoaded;
  const factory ConsultationState.receivedConsultationsLoading() =
      _ReceivedConsultationsLoading;

  const factory ConsultationState.receivedConsultationsLoaded(
      List<GetCurrentDoctorConsultationModelResponse>
          allReceivedConsultation) = _ReceivedConsultationsLoaded;

  const factory ConsultationState.error(String message) = _Error;
}
