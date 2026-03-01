// ignore_for_file: invalid_annotation_target
import 'package:egy_akin/exports.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_posts_community_model_response.freezed.dart';
part 'get_posts_community_model_response.g.dart';

/// Parses int from JSON when API returns number as String or num (avoids "String is not a subtype of num?").
int? _parseInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is num) return value.toInt();
  if (value is String) return int.tryParse(value);
  return null;
}

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
    @JsonKey(name: 'current_page', fromJson: _parseInt) int? currentPage,
    @JsonKey(name: 'first_page_url') String? firstPageUrl,
    @JsonKey(fromJson: _parseInt) int? from,
    @JsonKey(name: 'last_page', fromJson: _parseInt) int? lastPage,
    @JsonKey(name: 'last_page_url') String? lastPageUrl,
    @JsonKey(name: 'next_page_url') String? nextPageUrl,
    String? path,
    @JsonKey(fromJson: _parseInt) int? perPage,
    @JsonKey(name: 'prev_page_url') String? prevPageUrl,
    @JsonKey(fromJson: _parseInt) int? to,
    @JsonKey(fromJson: _parseInt) int? total,
  }) = _GetPostsCommunityDataModelResponse;
  factory GetPostsCommunityDataModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$GetPostsCommunityDataModelResponseFromJson(json);
}

@freezed
class PostCommunityModel with _$PostCommunityModel {
  const factory PostCommunityModel({
    @JsonKey(fromJson: _parseInt) int? id,
    String? content,
    @JsonKey(name: 'media_type') String? mediaType,
    @JsonKey(name: 'media_path') List<String>? mediaPath,
    String? visibility,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    @JsonKey(name: 'likes_count', fromJson: _parseInt) int? likesCount,
    @JsonKey(name: 'comments_count', fromJson: _parseInt) int? commentsCount,
    @JsonKey(name: 'isSaved') bool? isSaved,
    @JsonKey(name: 'isLiked') bool? isLiked,
    @JsonKey(name: 'existing_media_path') List<String>? existingMediaPath,
    GroupDetails? group,
    DoctorModel? doctor,
    PollModelResponse? poll,
  }) = _PostCommunityModel;
  factory PostCommunityModel.fromJson(Map<String, dynamic> json) =>
      _$PostCommunityModelFromJson(json);
}

@freezed
class PollModelResponse with _$PollModelResponse {
  const factory PollModelResponse({
    @JsonKey(fromJson: _parseInt) int? id,
    String? content,
    @JsonKey(name: 'feed_post_id', fromJson: _parseInt) int? feedPostId,
    String? question,
    @JsonKey(name: 'allow_add_options') bool? allowAddOptions,
    @JsonKey(name: 'allow_multiple_choice') bool? allowMultipleChoice,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    List<PollOptionsModelResponse>? options,
  }) = _PollModelResponse;
  factory PollModelResponse.fromJson(Map<String, dynamic> json) =>
      _$PollModelResponseFromJson(json);
}

@freezed
class PollOptionsModelResponse with _$PollOptionsModelResponse {
  const factory PollOptionsModelResponse({
    @JsonKey(fromJson: _parseInt) int? id,
    @JsonKey(name: 'poll_id', fromJson: _parseInt) int? pollId,
    @JsonKey(name: 'option_text') String? optionText,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    @JsonKey(name: 'votes_count', fromJson: _parseInt) int? votesCount,
    @JsonKey(name: 'is_voted') bool? isVoted,
  }) = _PollOptionsModelResponse;
  factory PollOptionsModelResponse.fromJson(Map<String, dynamic> json) =>
      _$PollOptionsModelResponseFromJson(json);
}

@freezed
class GroupDetails with _$GroupDetails {
  const factory GroupDetails({
    @JsonKey(fromJson: _parseInt) int? id,
    String? name,
  }) = _GroupDetails;
  factory GroupDetails.fromJson(Map<String, dynamic> json) =>
      _$GroupDetailsFromJson(json);
}
