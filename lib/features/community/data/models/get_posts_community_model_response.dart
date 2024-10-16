// ignore_for_file: invalid_annotation_target
import 'package:egy_akin/exports.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_posts_community_model_response.freezed.dart';
part 'get_posts_community_model_response.g.dart';

@freezed
class GetPostsCommunityModelResponse with _$GetPostsCommunityModelResponse {
  const factory GetPostsCommunityModelResponse({
    GetPostsCommunityDataModelResponse? data,
  }) = _GetPostsCommunityModelResponse;
  factory GetPostsCommunityModelResponse.fromJson(Map<String, dynamic> json) =>
      _$GetPostsCommunityModelResponseFromJson(json);
}

@freezed
class GetPostsCommunityDataModelResponse
    with _$GetPostsCommunityDataModelResponse {
  const factory GetPostsCommunityDataModelResponse({
    List<PostCommunityModel>? data,
    @JsonKey(name: 'current_page') int? currentPage,
    @JsonKey(name: 'first_page_url') String? firstPageUrl,
    int? from,
    @JsonKey(name: 'last_page') int? lastPage,
    @JsonKey(name: 'last_page_url') String? lastPageUrl,
    @JsonKey(name: 'next_page_url') String? nextPageUrl,
    String? path,
    int? perPage,
    @JsonKey(name: 'prev_page_url') String? prevPageUrl,
    int? to,
    int? total,
  }) = _GetPostsCommunityDataModelResponse;
  factory GetPostsCommunityDataModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$GetPostsCommunityDataModelResponseFromJson(json);
}

@freezed
class PostCommunityModel with _$PostCommunityModel {
  const factory PostCommunityModel({
    int? id,
    String? content,
    @JsonKey(name: 'media_type') String? mediaType,
    @JsonKey(name: 'media_path') String? mediaPath,
    String? visibility,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    @JsonKey(name: 'likes_count') String? likesCount,
    @JsonKey(name: 'comments_count') String? commentsCount,
    @JsonKey(name: 'isSaved') bool? isSaved,
    @JsonKey(name: 'isLiked') bool? isLiked,
    DoctorModel? doctor,
  }) = _PostCommunityModel;
  factory PostCommunityModel.fromJson(Map<String, dynamic> json) =>
      _$PostCommunityModelFromJson(json);
}
