import '../../../../exports.dart';

part 'final_submit_model.g.dart';

@JsonSerializable()
class FinalSubmitModelResponse extends BaseResponse {
  @JsonKey(name: 'message')
  String? message;

  FinalSubmitModelResponse({
    this.message,
  });

  factory FinalSubmitModelResponse.fromJson(Map<String, dynamic> json) =>
      _$FinalSubmitModelResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$FinalSubmitModelResponseToJson(this);
}
