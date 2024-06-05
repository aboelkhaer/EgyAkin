// ignore_for_file: invalid_annotation_target
import 'package:egy_akin/exports.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'get_outcome_model_response.freezed.dart';
part 'get_outcome_model_response.g.dart';

@freezed
class GetOutcomeModelResponse with _$GetOutcomeModelResponse {
  const factory GetOutcomeModelResponse({
    bool? value,
    List<QuestionModel>? data,
    @JsonKey(name: 'Submitter') OutcomeSubmitterModel? submitter,
  }) = _GetOutcomeModelResponse;
  factory GetOutcomeModelResponse.fromJson(Map<String, dynamic> json) =>
      _$GetOutcomeModelResponseFromJson(json);
}

@freezed
class GetOutcomeDataModelResponse with _$GetOutcomeDataModelResponse {
  const factory GetOutcomeDataModelResponse({
    @JsonKey(name: 'outcome_of_the_patient') String? outcomeOfThePatient,
    @JsonKey(name: 'creatinine_on_discharge') String? creatinineOnDischarge,
    @JsonKey(name: 'duration_of_admission') String? duration,
    @JsonKey(name: 'final_status') String? finalSubmit,
    @JsonKey(name: 'other') String? other,
    @JsonKey(name: 'update_at') String? updateAt,
    DoctorModel? doctor,
  }) = _GetOutcomeDataModelResponse;
  factory GetOutcomeDataModelResponse.fromJson(Map<String, dynamic> json) =>
      _$GetOutcomeDataModelResponseFromJson(json);
}

@freezed
class OutcomeSubmitterModel with _$OutcomeSubmitterModel {
  const factory OutcomeSubmitterModel({
    String? name,
    String? image,
  }) = _OutcomeSubmitterModel;
  factory OutcomeSubmitterModel.fromJson(Map<String, dynamic> json) =>
      _$OutcomeSubmitterModelFromJson(json);
}
