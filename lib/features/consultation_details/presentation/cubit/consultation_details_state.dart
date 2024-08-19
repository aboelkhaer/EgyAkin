import 'package:egy_akin/features/consultation_details/data/models/get_consultation_details_model_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'consultation_details_state.freezed.dart';

@freezed
abstract class ConsultationDetailsState with _$ConsultationDetailsState {
  const factory ConsultationDetailsState.initial() = _Initial;
  const factory ConsultationDetailsState.loading() = _Loading;

  const factory ConsultationDetailsState.loaded(
      GetConsultationDetailsModelResponse consultDetails,
      String newCommentValue,
      bool isSendingConsultation,
      bool isSendedConsultation,
      String message) = _Loaded;
  const factory ConsultationDetailsState.error(String message) = _Error;
}
