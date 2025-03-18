// ignore_for_file: invalid_annotation_target
import 'package:egy_akin/features/community/data/models/get_posts_community_model_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'get_all_doctor_posts_model_response.freezed.dart';
part 'get_all_doctor_posts_model_response.g.dart';

@freezed
class GetAllDoctorPostsModelResponse with _$GetAllDoctorPostsModelResponse {
  const factory GetAllDoctorPostsModelResponse({
    GetPostsCommunityDataModelResponse? data,
  }) = _GetAllDoctorPostsModelResponse;
  factory GetAllDoctorPostsModelResponse.fromJson(Map<String, dynamic> json) =>
      _$GetAllDoctorPostsModelResponseFromJson(json);
}
