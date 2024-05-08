import 'package:egy_akin/exports.dart';
import 'package:egy_akin/features/current_doctor_patients/data/models/get_current_doctor_patients_model_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'current_doctor_patients_state.freezed.dart';

@freezed
abstract class CurrentDoctorPatientsState with _$CurrentDoctorPatientsState {
  const factory CurrentDoctorPatientsState.initial() = _Initial;
  const factory CurrentDoctorPatientsState.loading() = _Loading;

  const factory CurrentDoctorPatientsState.loaded(
      GetDoctorPatientsModelResponse response, bool isSeeMore) = _Loaded;
  const factory CurrentDoctorPatientsState.error(String message) = _Error;
}
