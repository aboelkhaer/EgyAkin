// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_patient_history_for_add_patient.freezed.dart';
part 'get_patient_history_for_add_patient.g.dart';

@freezed
class GetPatientHistoryForAddPatientModelResponse
    with _$GetPatientHistoryForAddPatientModelResponse {
  const factory GetPatientHistoryForAddPatientModelResponse({
    bool? value,
    List<QuestionModel>? data,
  }) = _GetPatientHistoryForAddPatientModelResponse;
  factory GetPatientHistoryForAddPatientModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$GetPatientHistoryForAddPatientModelResponseFromJson(json);
}

@freezed
class QuestionModel with _$QuestionModel {
  const factory QuestionModel({
    int? id,
    String? question,
    List<dynamic>? values,
    String? type,
    @JsonKey(name: 'keyboard_type') String? keyboardType,
    bool? mandatory,
    @JsonKey(name: 'updated_at') String? updatedAt,
    dynamic answer,
  }) = _QuestionModel;
  factory QuestionModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionModelFromJson(json);
}
