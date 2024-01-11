import '../../../exports.dart';

part 'base_patient_model.g.dart';

@JsonSerializable()
class BasePatientModel {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'hospital')
  String? hospital;
  @JsonKey(name: 'updated_at')
  String? updatedAt;
  @JsonKey(name: 'doctor')
  BaseDoctorModel? doctorModel;
  @JsonKey(name: 'sections')
  SimpleSectionModel? sections;

  BasePatientModel({
    this.id,
    this.name,
    this.hospital,
    this.updatedAt,
    this.doctorModel,
  });

  factory BasePatientModel.fromJson(Map<String, dynamic> json) =>
      _$BasePatientModelFromJson(json);
  Map<String, dynamic> toJson() => _$BasePatientModelToJson(this);
}

@JsonSerializable()
class SimpleSectionModel {
  @JsonKey(name: 'submit_status')
  bool? submitStatus;
  @JsonKey(name: 'outcome_status')
  bool? outcomeStatus;

  SimpleSectionModel({
    this.submitStatus,
    this.outcomeStatus,
  });

  factory SimpleSectionModel.fromJson(Map<String, dynamic> json) =>
      _$SimpleSectionModelFromJson(json);
  Map<String, dynamic> toJson() => _$SimpleSectionModelToJson(this);
}
