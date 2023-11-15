import '../../../exports.dart';

part 'add_comment_on_post_model.g.dart';

@JsonSerializable()
class AddCommentOnPostModelResponse extends BaseResponse {
  @JsonKey(name: 'message')
  String? message;
  AddCommentOnPostModelResponse({required this.message});
  factory AddCommentOnPostModelResponse.fromJson(Map<String, dynamic> json) =>
      _$AddCommentOnPostModelResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AddCommentOnPostModelResponseToJson(this);
}
