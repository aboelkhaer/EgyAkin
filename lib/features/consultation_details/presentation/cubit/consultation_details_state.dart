import 'package:egy_akin/features/consultation_details/data/models/get_consultation_details_model_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'consultation_details_state.freezed.dart';

@freezed
abstract class ConsultationDetailsState with _$ConsultationDetailsState {
  const factory ConsultationDetailsState.initial() = _Initial;
  const factory ConsultationDetailsState.loading() = _Loading;

  const factory ConsultationDetailsState.loaded(
      List<GetConsultationDetailsModelResponse> consultDetails) = _Loaded;
  const factory ConsultationDetailsState.error(String message) = _Error;
}
