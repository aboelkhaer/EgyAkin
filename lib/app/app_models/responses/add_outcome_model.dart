import '../../../../exports.dart';

part 'add_outcome_model.g.dart';

@JsonSerializable()
class AddOutcometModelResponse extends BaseResponse {
  @JsonKey(name: 'message')
  String? message;

  AddOutcometModelResponse({
    this.message,
  });

  factory AddOutcometModelResponse.fromJson(Map<String, dynamic> json) =>
      _$AddOutcometModelResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$AddOutcometModelResponseToJson(this);
}
