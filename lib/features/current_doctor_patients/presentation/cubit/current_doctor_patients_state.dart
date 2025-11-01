import 'package:egy_akin/exports.dart';
import 'package:egy_akin/features/all_doctors_patients/data/models/get_filters_options_model_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'current_doctor_patients_state.freezed.dart';

@freezed
abstract class CurrentDoctorPatientsState with _$CurrentDoctorPatientsState {
  const factory CurrentDoctorPatientsState.initial() = _Initial;
  const factory CurrentDoctorPatientsState.loading() = _Loading;

  const factory CurrentDoctorPatientsState.loaded(
      GetDoctorPatientsModelResponse response,
      bool isSeeMore,
      String message,
      bool isApplyFilterLoading,
      bool isApplyFilterLoaded,
      bool isExportLoading,
      bool isExportLoaded,
      String? fileUrl,
      List<GetFiltersOptionsDataModelResponse>? filters,
      int totalPatientInFilter) = _Loaded;
  const factory CurrentDoctorPatientsState.error(String message) = _Error;
}
