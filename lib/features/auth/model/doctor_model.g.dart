// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorModelResponse _$DoctorModelResponseFromJson(Map<String, dynamic> json) =>
    DoctorModelResponse(
      json['data'] == null
          ? null
          : DoctorModel.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..value = json['value'] as bool?
      ..token = json['token'] as String?;

Map<String, dynamic> _$DoctorModelResponseToJson(
        DoctorModelResponse instance) =>
    <String, dynamic>{
      'value': instance.value,
      'data': instance.doctorModel,
      'token': instance.token,
    };

DoctorModel _$DoctorModelFromJson(Map<String, dynamic> json) => DoctorModel(
      id: json['id'] as int?,
      firstName: json['fname'] as String?,
    )
      ..lastName = json['lname'] as String?
      ..email = json['email'] as String?
      ..emailVerifiedAt = json['emailVerifiedAt'] as String?
      ..age = json['age'] as int?
      ..specialty = json['specialty'] as String?
      ..workingPlace = json['workingplace'] as String?
      ..phone = json['phone'] as String?
      ..job = json['job'] as String?
      ..highestDegree = json['highestdegree'] as String?
      ..createdAt = json['created_at'] as String?
      ..updatedAt = json['updated_at'] as String?;

Map<String, dynamic> _$DoctorModelToJson(DoctorModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('fname', instance.firstName);
  writeNotNull('lname', instance.lastName);
  writeNotNull('email', instance.email);
  writeNotNull('emailVerifiedAt', instance.emailVerifiedAt);
  writeNotNull('age', instance.age);
  writeNotNull('specialty', instance.specialty);
  writeNotNull('workingplace', instance.workingPlace);
  writeNotNull('phone', instance.phone);
  writeNotNull('job', instance.job);
  writeNotNull('highestdegree', instance.highestDegree);
  writeNotNull('created_at', instance.createdAt);
  writeNotNull('updated_at', instance.updatedAt);
  return val;
}
