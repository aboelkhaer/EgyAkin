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
    GFRModel? gfr,
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

@freezed
class GFRModel with _$GFRModel {
  const factory GFRModel({
    EquationModel? ckd,
    EquationModel? sobh,
  }) = _GFRModel;
  factory GFRModel.fromJson(Map<String, dynamic> json) =>
      _$GFRModelFromJson(json);
}

@freezed
class EquationModel with _$EquationModel {
  const factory EquationModel({
    @JsonKey(name: 'current_GFR') String? currentGFR,
    @JsonKey(name: 'basal_creatinine_GFR') String? basalCreatinine,
    @JsonKey(name: 'creatinine_on_discharge_GFR') String? creatinineOnDischarge,
  }) = _EquationModel;
  factory EquationModel.fromJson(Map<String, dynamic> json) =>
      _$EquationModelFromJson(json);
}
