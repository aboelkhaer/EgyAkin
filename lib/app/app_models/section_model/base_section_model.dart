import '../../../exports.dart';

part 'base_section_model.g.dart';

@JsonSerializable(includeIfNull: true)
class BaseSectionModel {
  @JsonKey(name: 'section_id')
  int? sectionId;
  @JsonKey(name: 'section_name')
  String? sectionName;
  @JsonKey(name: 'section_status')
  bool? sectionStatus;
  @JsonKey(name: 'updated_at')
  String? updatedAt;

  BaseSectionModel({
    this.sectionId,
    this.sectionName,
    this.sectionStatus,
    this.updatedAt,
  });
  factory BaseSectionModel.fromJson(Map<String, dynamic> json) =>
      _$BaseSectionModelFromJson(json);

  Map<String, dynamic> toJson() => _$BaseSectionModelToJson(this);
}
