import '../../../exports.dart';

part 'doctor_model.g.dart';

@JsonSerializable(includeIfNull: true)
class DoctorModel {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? firstName;
  @JsonKey(name: 'lname')
  String? lastName;
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'emailVerifiedAt')
  String? emailVerifiedAt;
  @JsonKey(name: 'age')
  String? age;
  @JsonKey(name: 'specialty')
  String? specialty;
  @JsonKey(name: 'password_confirmation')
  String? passwordConfirmation;
  @JsonKey(name: 'workingplace')
  String? workingPlace;
  @JsonKey(name: 'phone')
  String? phone;
  @JsonKey(name: 'job')
  String? job;
  @JsonKey(name: 'image')
  String? image;
  @JsonKey(name: 'registration_number')
  String? registrationNumber;
  @JsonKey(name: 'highestdegree')
  String? highestDegree;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'updated_at')
  String? updatedAt;

  DoctorModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.emailVerifiedAt,
    this.age,
    this.specialty,
    this.passwordConfirmation,
    this.workingPlace,
    this.phone,
    this.job,
    this.image,
    this.highestDegree,
    this.createdAt,
    this.updatedAt,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) =>
      _$DoctorModelFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorModelToJson(this);
}
