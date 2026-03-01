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
    @JsonKey(name: 'is_marked') bool? isMarked,
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
    @JsonKey(name: 'updated_at') dynamic updatedAt,
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
    EquationModel? mdrd,
  }) = _GFRModel;
  factory GFRModel.fromJson(Map<String, dynamic> json) =>
      _$GFRModelFromJson(json);
}

@freezed
class EquationModel with _$EquationModel {
  const factory EquationModel({
    @JsonKey(name: 'current_GFR') EquationDataModel? currentGFR,
    @JsonKey(name: 'basal_creatinine_GFR') EquationDataModel? basalCreatinine,
    @JsonKey(name: 'creatinine_on_discharge_GFR')
    EquationDataModel? creatinineOnDischarge,
  }) = _EquationModel;
  factory EquationModel.fromJson(Map<String, dynamic> json) =>
      _$EquationModelFromJson(json);
}

@freezed
class EquationDataModel with _$EquationDataModel {
  const factory EquationDataModel({
    String? localization,
    String? value,
  }) = _EquationDataModel;
  factory EquationDataModel.fromJson(Map<String, dynamic> json) =>
      _$EquationDataModelFromJson(json);
}
