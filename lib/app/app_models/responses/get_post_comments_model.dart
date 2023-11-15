import '../../../exports.dart';

part 'get_post_comments_model.g.dart';

@JsonSerializable()
class GetPostCommentsModelResponse extends BaseResponse {
  @JsonKey(name: 'data')
  List<BaseCommentModel>? baseCommentModel;

  GetPostCommentsModelResponse({
    this.baseCommentModel,
  });

  factory GetPostCommentsModelResponse.fromJson(Map<String, dynamic> json) =>
      _$GetPostCommentsModelResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$GetPostCommentsModelResponseToJson(this);
}
