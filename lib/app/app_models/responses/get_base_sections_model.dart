import '../../../exports.dart';

part 'get_base_sections_model.g.dart';

@JsonSerializable()
class GetBaseSectionsModelResponse extends BaseResponse {
  @JsonKey(name: 'data')
  List<BaseSectionModel>? baseSectionsList;
  @JsonKey(name: 'submit_status')
  bool? submitStatus;

  GetBaseSectionsModelResponse({
    this.baseSectionsList,
    this.submitStatus,
  });

  factory GetBaseSectionsModelResponse.fromJson(Map<String, dynamic> json) =>
      _$GetBaseSectionsModelResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$GetBaseSectionsModelResponseToJson(this);
}
