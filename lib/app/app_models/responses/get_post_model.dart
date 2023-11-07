import '../../../exports.dart';

part 'get_post_model.g.dart';

@JsonSerializable()
class GetPostsModelResponse extends BaseResponse {
  @JsonKey(name: 'data')
  List<BasePostModel>? basePostModel;

  GetPostsModelResponse({
    this.basePostModel,
  });

  factory GetPostsModelResponse.fromJson(Map<String, dynamic> json) =>
      _$GetPostsModelResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$GetPostsModelResponseToJson(this);
}
