import '../../../../exports.dart';

part 'add_comment_model.g.dart';

@JsonSerializable()
class AddCommentModelResponse extends BaseResponse {
  @JsonKey(name: 'message')
  String? message;

  AddCommentModelResponse({
    this.message,
  });

  factory AddCommentModelResponse.fromJson(Map<String, dynamic> json) =>
      _$AddCommentModelResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$AddCommentModelResponseToJson(this);
}
