// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
part 'get_patient_sections_model_response.freezed.dart';
part 'get_patient_sections_model_response.g.dart';

bool? alwaysOpenFromJson(Object? value) {
  if (value == null) return null;
  if (value is bool) return value;
  if (value is num) return value != 0;
  if (value is String) {
    final normalized = value.trim().toLowerCase();
    if (normalized == 'true' || normalized == '1') return true;
    if (normalized == 'false' || normalized == '0') return false;
  }
  return null;
}

bool? flexibleBoolFromJson(Object? value) => alwaysOpenFromJson(value);

String? doctorIdFromJson(Object? value) {
  if (value == null) return null;
  if (value is num) return value.toInt().toString();
  final asString = value.toString().trim();
  if (asString.isEmpty || asString == 'null') return null;
  return asString;
}

Map<String, dynamic> normalizePatientSectionsJson(Map<String, dynamic> json) {
  final normalized = Map<String, dynamic>.from(json);
  // API may send doctor_id or doctor_Id.
  normalized['doctor_Id'] ??= json['doctor_id'];
  return normalized;
}

@freezed
class GetPatientSectionsModelResponse with _$GetPatientSectionsModelResponse {
  const factory GetPatientSectionsModelResponse({
    bool? value,
    @JsonKey(name: 'submit_status', fromJson: flexibleBoolFromJson)
    bool? submitStatus,
    @JsonKey(name: 'patient_name') String? patientName,
    @JsonKey(name: 'doctor_Id', fromJson: doctorIdFromJson) String? doctorId,
    @JsonKey(name: 'is_marked', fromJson: flexibleBoolFromJson) bool? isMarked,
    num? bmi,
    @JsonKey(name: 'bmi_category') String? bmiCategory,
    GFRModel? gfr,
    List<SectionModel>? data,
  }) = _GetPatientSectionsModelResponse;

  factory GetPatientSectionsModelResponse.fromJson(Map<String, dynamic> json) =>
      _$GetPatientSectionsModelResponseFromJson(
        normalizePatientSectionsJson(json),
      );
}

@freezed
class SectionModel with _$SectionModel {
  const factory SectionModel({
    @JsonKey(name: 'section_id') int? sectionId,
    @JsonKey(name: 'section_status', fromJson: flexibleBoolFromJson)
    bool? sectionStatus,
    @JsonKey(name: 'updated_at') dynamic updatedAt,
    @JsonKey(name: 'section_name') String? sectionName,
    @JsonKey(name: 'always_open', fromJson: alwaysOpenFromJson)
    bool? alwaysOpen,
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
