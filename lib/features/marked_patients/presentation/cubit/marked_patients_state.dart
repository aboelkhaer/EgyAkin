import 'package:egy_akin/features/marked_patients/data/models/get_marked_patients_model_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'marked_patients_state.freezed.dart';

@freezed
abstract class MarkedPatientsState with _$MarkedPatientsState {
  const factory MarkedPatientsState.initial() = _Initial;
  const factory MarkedPatientsState.loading() = _Loading;
  const factory MarkedPatientsState.loaded(
      GetMarkedPatientsModelResponse response, bool isSeeMore) = _Loaded;
  const factory MarkedPatientsState.error(String message) = _Error;
}
