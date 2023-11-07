import '../../../exports.dart';

part 'get_questions_model.g.dart';

@JsonSerializable()
class GetQuestionsModelResponse extends BaseResponse {
  @JsonKey(name: 'data')
  List<BaseQuestionModel>? baseQuestionModel;

  GetQuestionsModelResponse({
    this.baseQuestionModel,
  });

  factory GetQuestionsModelResponse.fromJson(Map<String, dynamic> json) =>
      _$GetQuestionsModelResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$GetQuestionsModelResponseToJson(this);
}
