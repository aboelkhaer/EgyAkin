// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientModel _$PatientModelFromJson(Map<String, dynamic> json) => PatientModel(
      doctorId: (json['doctor_id'] as num?)?.toInt(),
      collectedDataFrom: json['collected_data_from'] as String?,
      nID: json['NID'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      age: json['age'] as String?,
      gender: json['gender'] as String?,
      occupation: json['occupation'] as String?,
      residency: json['residency'] as String?,
      governorate: json['governorate'] as String?,
      maritalStatus: json['marital_status'] as String?,
      educationalLevel: json['educational_level'] as String?,
      specialHabitsOfThePatient:
          json['special_habits_of_the_patient'] as List<dynamic>?,
      dM: json['DM'] as String?,
      dMDuration: json['DM_duration'] as String?,
      hTN: json['HTN'] as String?,
      hTNDuration: json['HTN_duration'] as String?,
    )
      ..id = (json['id'] as num?)?.toInt()
      ..name = json['name'] as String?
      ..hospital = json['hospital'] as String?
      ..updatedAt = json['updated_at'] as String?
      ..doctorModel = json['doctor'] == null
          ? null
          : BaseDoctorModel.fromJson(json['doctor'] as Map<String, dynamic>)
      ..sections = json['sections'] == null
          ? null
          : SimpleSectionModel.fromJson(
              json['sections'] as Map<String, dynamic>);

Map<String, dynamic> _$PatientModelToJson(PatientModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'hospital': instance.hospital,
      'updated_at': instance.updatedAt,
      'doctor': instance.doctorModel,
      'sections': instance.sections,
      'doctor_id': instance.doctorId,
      'collected_data_from': instance.collectedDataFrom,
      'NID': instance.nID,
      'phone': instance.phone,
      'email': instance.email,
      'age': instance.age,
      'gender': instance.gender,
      'occupation': instance.occupation,
      'residency': instance.residency,
      'governorate': instance.governorate,
      'marital_status': instance.maritalStatus,
      'educational_level': instance.educationalLevel,
      'special_habits_of_the_patient': instance.specialHabitsOfThePatient,
      'DM': instance.dM,
      'DM_duration': instance.dMDuration,
      'HTN': instance.hTN,
      'HTN_duration': instance.hTNDuration,
    };
