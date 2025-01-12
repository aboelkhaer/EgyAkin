// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../exports.dart';

part 'get_comments_in_community_model_response.freezed.dart';
part 'get_comments_in_community_model_response.g.dart';

@freezed
class GetCommentsInCommunityModelResponse
    with _$GetCommentsInCommunityModelResponse {
  const factory GetCommentsInCommunityModelResponse({
    bool? value,
    PostCommentsData? data,
    String? message,
  }) = _GetCommentsInCommunityModelResponse;

  factory GetCommentsInCommunityModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$GetCommentsInCommunityModelResponseFromJson(json);
}

@freezed
class PostCommentsData with _$PostCommentsData {
  const factory PostCommentsData({
    @JsonKey(name: 'current_page') int? currentPage,
    List<CommentModelInCommunity>? data,
    @JsonKey(name: 'first_page_url') String? firstPageUrl,
    int? from,
    @JsonKey(name: 'last_page') int? lastPage,
    @JsonKey(name: 'last_page_url') String? lastPageUrl,
    List<Link>? links,
    @JsonKey(name: 'next_page_url') String? nextPageUrl,
    String? path,
    @JsonKey(name: 'per_page') int? perPage,
    @JsonKey(name: 'prev_page_url') String? prevPageUrl,
    int? to,
    int? total,
  }) = _PostCommentsData;

  factory PostCommentsData.fromJson(Map<String, dynamic> json) =>
      _$PostCommentsDataFromJson(json);
}

@freezed
class CommentModelInCommunity with _$CommentModelInCommunity {
  const factory CommentModelInCommunity({
    int? id,
    @JsonKey(name: 'feed_post_id') int? feedPostId,
    @JsonKey(name: 'doctor_id') int? doctorId,
    String? comment,
    @JsonKey(name: 'parent_id') int? parentId,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    @JsonKey(name: 'likes_count') int? likesCount,
    @JsonKey(name: 'replies_count') int? repliesCount,
    bool? isLiked,
    DoctorModel? doctor,
    List<CommentModelInCommunity>? replies,
  }) = _CommentModelInCommunity;

  factory CommentModelInCommunity.fromJson(Map<String, dynamic> json) =>
      _$CommentModelInCommunityFromJson(json);
}
