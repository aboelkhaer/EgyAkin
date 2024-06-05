// ignore_for_file: invalid_annotation_target

import 'package:egy_akin/exports.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'post_comments_model_response.freezed.dart';
part 'post_comments_model_response.g.dart';

@freezed
class PostCommentsModelResponse with _$PostCommentsModelResponse {
  const factory PostCommentsModelResponse({
    bool? value,
    List<CommentModel>? data,
  }) = _PostCommentsModelResponse;
  factory PostCommentsModelResponse.fromJson(Map<String, dynamic> json) =>
      _$PostCommentsModelResponseFromJson(json);
}

@freezed
class CommentModel with _$CommentModel {
  const factory CommentModel({
    int? id,
    String? content,
    @JsonKey(name: 'updated_at') String? updatedAt,
    DoctorModel? doctor,
  }) = _CommentModel;
  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);
}
