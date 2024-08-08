import 'package:egy_akin/features/send_consultation/data/models/get_consultation_search_model_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'send_consultation_state.freezed.dart';

@freezed
abstract class SendConsultationState with _$SendConsultationState {
  const factory SendConsultationState.initial() = _Initial;
  const factory SendConsultationState.loading() = _Loading;
  const factory SendConsultationState.loaded(
      bool isSearching,
      bool isSearched,
      String message,
      GetConsultationSearchModelResponse? response,
      int counterChanges,
      bool isSendingConsultation,
      bool isSendedConsultation) = _Loaded;

  const factory SendConsultationState.error(String message) = _Error;
}
