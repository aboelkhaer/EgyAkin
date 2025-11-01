import 'package:egy_akin/exports.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'all_doctors_patients_state.freezed.dart';

@freezed
abstract class AllDoctorsPatientsState with _$AllDoctorsPatientsState {
  const factory AllDoctorsPatientsState.initial() = _Initial;
  const factory AllDoctorsPatientsState.loading() = _Loading;

  const factory AllDoctorsPatientsState.loaded(
    GetAllDoctorsPatientsModelResponse response,
    bool isSeeMore,
    String message,
    bool isApplyFilterLoading,
    bool isApplyFilterLoaded,
    bool isExportLoading,
    bool isExportLoaded,
    String? fileUrl,
  ) = _Loaded;
  const factory AllDoctorsPatientsState.error(String message) = _Error;
}
