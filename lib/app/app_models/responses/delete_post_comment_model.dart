import '../../../exports.dart';

part 'delete_post_comment_model.g.dart';

@JsonSerializable()
class DeletePostCommentModelResponse extends BaseResponse {
  @JsonKey(name: 'message')
  String? message;
  DeletePostCommentModelResponse({required this.message});
  factory DeletePostCommentModelResponse.fromJson(Map<String, dynamic> json) =>
      _$DeletePostCommentModelResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DeletePostCommentModelResponseToJson(this);
}
