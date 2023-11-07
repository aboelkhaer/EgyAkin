import '../../../../exports.dart';

part 'delete_comment_model.g.dart';

@JsonSerializable()
class DeleteCommentModelResponse extends BaseResponse {
  @JsonKey(name: 'message')
  String? message;

  DeleteCommentModelResponse({
    this.message,
  });

  factory DeleteCommentModelResponse.fromJson(Map<String, dynamic> json) =>
      _$DeleteCommentModelResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$DeleteCommentModelResponseToJson(this);
}
