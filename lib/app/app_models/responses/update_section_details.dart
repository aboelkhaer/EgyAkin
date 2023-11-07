import '../../../../exports.dart';

part 'update_section_details.g.dart';

@JsonSerializable()
class UpdateSectionDetailsModelResponse extends BaseResponse {
  @JsonKey(name: 'message')
  String? message;

  UpdateSectionDetailsModelResponse({
    this.message,
  });

  factory UpdateSectionDetailsModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$UpdateSectionDetailsModelResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() =>
      _$UpdateSectionDetailsModelResponseToJson(this);
}
