import '../../../exports.dart';

part 'base_response.g.dart';

@JsonSerializable()
class BaseResponse {
  @JsonKey(name: 'value')
  bool? value;

  BaseResponse({
    this.value,
  });

  factory BaseResponse.fromJson(Map<String, dynamic> json) =>
      _$BaseResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BaseResponseToJson(this);
}
