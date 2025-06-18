// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
part 'create_new_medicine_model_response.freezed.dart';
part 'create_new_medicine_model_response.g.dart';

@freezed
class CreateNewMedicineModelResponse with _$CreateNewMedicineModelResponse {
  const factory CreateNewMedicineModelResponse({
   String? message,
  }) = _CreateNewMedicineModelResponse;
  factory CreateNewMedicineModelResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateNewMedicineModelResponseFromJson(json);
}
