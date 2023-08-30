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
  DoctorModelResponse(this.doctorModel);
  factory DoctorModelResponse.fromJson(Map<String, dynamic> json) =>
      _$DoctorModelResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DoctorModelResponseToJson(this);
}

@JsonSerializable(includeIfNull: false)
class DoctorModel {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'fname')
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
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) =>
      _$DoctorModelFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorModelToJson(this);
}
