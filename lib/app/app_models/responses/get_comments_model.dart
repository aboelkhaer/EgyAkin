import '../../../exports.dart';

part 'get_comments_model.g.dart';

@JsonSerializable()
class GetCommentstModelResponse extends BaseResponse {
  @JsonKey(name: 'data')
  List<BaseCommentModel>? baseCommentModel;

  GetCommentstModelResponse({
    this.baseCommentModel,
  });

  factory GetCommentstModelResponse.fromJson(Map<String, dynamic> json) =>
      _$GetCommentstModelResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$GetCommentstModelResponseToJson(this);
}
