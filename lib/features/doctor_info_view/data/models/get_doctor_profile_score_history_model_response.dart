// ignore_for_file: invalid_annotation_target
import 'package:egy_akin/exports.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'get_doctor_profile_score_history_model_response.freezed.dart';
part 'get_doctor_profile_score_history_model_response.g.dart';

@freezed
class GetDoctorProfileScoreModelResponse
    with _$GetDoctorProfileScoreModelResponse {
  const factory GetDoctorProfileScoreModelResponse({
    bool? value,
    GetDoctorProfileScoreDataModelResponse? data,
  }) = _GetDoctorProfileScoreModelResponse;
  factory GetDoctorProfileScoreModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$GetDoctorProfileScoreModelResponseFromJson(json);
}

@freezed
class GetDoctorProfileScoreDataModelResponse
    with _$GetDoctorProfileScoreDataModelResponse {
  const factory GetDoctorProfileScoreDataModelResponse({
    @JsonKey(name: 'current_page') int? currentPage,
    List<ScoreModel>? data,
    @JsonKey(name: 'first_page_url') String? firstPageUrl,
    int? from,
    @JsonKey(name: 'last_page') int? lastPage,
    @JsonKey(name: 'last_page_url') String? lastPageUrl,
    List<Link>? links,
    @JsonKey(name: 'next_page_url') String? nextPageUrl,
    String? path,
    int? perPage,
    @JsonKey(name: 'prev_page_url') String? prevPageUrl,
    int? to,
    int? total,
  }) = _GetDoctorProfileScoreDataModelResponse;
  factory GetDoctorProfileScoreDataModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$GetDoctorProfileScoreDataModelResponseFromJson(json);
}

@freezed
class ScoreModel with _$ScoreModel {
  const factory ScoreModel({
    int? id,
    String? score,
    String? action,
    DoctorModel? doctor,
    @JsonKey(name: 'updated_at') String? updateAt,
  }) = _ScoreModel;
  factory ScoreModel.fromJson(Map<String, dynamic> json) =>
      _$ScoreModelFromJson(json);
}
