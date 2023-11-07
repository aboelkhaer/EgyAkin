import '../../../exports.dart';

part 'patient_model.g.dart';

@JsonSerializable(includeIfNull: true)
class PatientModel extends BasePatientModel {
  @JsonKey(name: 'doctor_id')
  int? doctorId;
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
  List<dynamic>? specialHabitsOfThePatient;
  @JsonKey(name: 'DM')
  String? dM;
  @JsonKey(name: 'DM_duration')
  String? dMDuration;
  @JsonKey(name: 'HTN')
  String? hTN;
  @JsonKey(name: 'HTN_duration')
  String? hTNDuration;

  PatientModel({
    this.doctorId,
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
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) =>
      _$PatientModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PatientModelToJson(this);
}
