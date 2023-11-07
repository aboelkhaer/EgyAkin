import '../../../exports.dart';

part 'section_model.g.dart';

@JsonSerializable(includeIfNull: true)
class SectionModel {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'doctor_id')
  int? ownerId;
  @JsonKey(name: 'patient_id')
  int? patientId;
  @JsonKey(name: 'section_1')
  bool? section1;
  @JsonKey(name: 'section_2')
  bool? section2;
  @JsonKey(name: 'section_3')
  bool? section3;
  @JsonKey(name: 'section_4')
  bool? section4;
  @JsonKey(name: 'section_5')
  bool? section5;
  @JsonKey(name: 'section_6')
  bool? section6;
  @JsonKey(name: 'section_7')
  bool? section7;
  @JsonKey(name: 'submit_status')
  bool? submitStatus;
  @JsonKey(name: 'outcome_status')
  bool? outcomeStatus;
  @JsonKey(name: 'doc_id')
  int? doctorId;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'updated_at')
  String? updatedAt;

  SectionModel({
    this.id,
    this.ownerId,
    this.patientId,
    this.section1,
    this.section2,
    this.section3,
    this.section4,
    this.section5,
    this.section6,
    this.section7,
    this.submitStatus,
    this.outcomeStatus,
    this.doctorId,
    this.createdAt,
    this.updatedAt,
  });
  factory SectionModel.fromJson(Map<String, dynamic> json) =>
      _$SectionModelFromJson(json);

  Map<String, dynamic> toJson() => _$SectionModelToJson(this);
}
