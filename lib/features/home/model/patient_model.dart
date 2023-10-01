import 'package:json_annotation/json_annotation.dart';

part 'patient_model.g.dart';

@JsonSerializable()
class PatientModelResponse {
  @JsonKey(name: 'value')
  bool? value;
  @JsonKey(name: 'data')
  PatientModel? patientModel;

  PatientModelResponse({
    this.value,
    this.patientModel,
  });

  factory PatientModelResponse.fromJson(Map<String, dynamic> json) =>
      _$PatientModelResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PatientModelResponseToJson(this);
}

@JsonSerializable(includeIfNull: true)
class PatientModel {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'owner_id')
  String? ownerId;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'hospital')
  String? hospital;
  @JsonKey(name: 'collected_data_from')
  String? collectedDataFrom;
  @JsonKey(name: 'NID')
  String? nID;
  @JsonKey(name: 'phone')
  String? phone;
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'age')
  String? age;
  @JsonKey(name: 'gender')
  String? gender;
  @JsonKey(name: 'occupation')
  String? occupation;
  @JsonKey(name: 'residency')
  String? residency;
  @JsonKey(name: 'governorate')
  String? governorate;
  @JsonKey(name: 'marital_status')
  String? maritalStatus;
  @JsonKey(name: 'educational_level')
  String? educationalLevel;
  @JsonKey(name: 'special_habits_of_the_patient')
  String? specialHabitsOfThePatient;
  @JsonKey(name: 'DM')
  String? dM;
  @JsonKey(name: 'DM_duration')
  String? dMDuration;
  @JsonKey(name: 'HTN')
  String? hTN;
  @JsonKey(name: 'HTN_duration')
  String? hTNDuration;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'updated_at')
  String? updatedAt;

  PatientModel({
    this.id,
    this.ownerId,
    this.name,
    this.hospital,
    this.collectedDataFrom,
    this.nID,
    this.phone,
    this.email,
    this.age,
    this.gender,
    this.occupation,
    this.residency,
    this.governorate,
    this.maritalStatus,
    this.educationalLevel,
    this.specialHabitsOfThePatient,
    this.dM,
    this.dMDuration,
    this.hTN,
    this.hTNDuration,
    this.createdAt,
    this.updatedAt,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) =>
      _$PatientModelFromJson(json);

  Map<String, dynamic> toJson() => _$PatientModelToJson(this);
}
