// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
part 'get_patient_sections_model_response.freezed.dart';
part 'get_patient_sections_model_response.g.dart';

@freezed
class GetPatientSectionsModelResponse with _$GetPatientSectionsModelResponse {
  const factory GetPatientSectionsModelResponse({
    bool? value,
    @JsonKey(name: 'submit_status') bool? submitStatus,
    @JsonKey(name: 'patient_name') String? patientName,
    @JsonKey(name: 'doctor_Id') String? doctorId,
    List<SectionModel>? data,
  }) = _GetPatientSectionsModelResponse;
  factory GetPatientSectionsModelResponse.fromJson(Map<String, dynamic> json) =>
      _$GetPatientSectionsModelResponseFromJson(json);
}

@freezed
class SectionModel with _$SectionModel {
  const factory SectionModel({
    @JsonKey(name: 'section_id') int? sectionId,
    @JsonKey(name: 'section_status') bool? sectionStatus,
    @JsonKey(name: 'updated_at') String? updatedAt,
    @JsonKey(name: 'section_name') String? sectionName,
  }) = _SectionModel;
  factory SectionModel.fromJson(Map<String, dynamic> json) =>
      _$SectionModelFromJson(json);
}
