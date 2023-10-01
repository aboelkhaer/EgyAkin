import 'package:json_annotation/json_annotation.dart';

part 'doctor_model.g.dart';

@JsonSerializable()
class DoctorModelResponse {
  @JsonKey(name: 'value')
  bool? value;
  @JsonKey(name: 'data')
  DoctorModel? doctorModel;
  @JsonKey(name: 'token')
  String? token;

  DoctorModelResponse({
    this.value,
    this.doctorModel,
    this.token,
  });

  factory DoctorModelResponse.fromJson(Map<String, dynamic> json) =>
      _$DoctorModelResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DoctorModelResponseToJson(this);
}

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
  int? age;
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
    this.highestDegree,
    this.createdAt,
    this.updatedAt,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) =>
      _$DoctorModelFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorModelToJson(this);
}

@JsonSerializable()
class LogoutModel {
  @JsonKey(name: 'value')
  bool? value;
  @JsonKey(name: 'message')
  String? message;
  LogoutModel({required this.value, required this.message});
  factory LogoutModel.fromJson(Map<String, dynamic> json) =>
      _$LogoutModelFromJson(json);

  Map<String, dynamic> toJson() => _$LogoutModelToJson(this);
}
