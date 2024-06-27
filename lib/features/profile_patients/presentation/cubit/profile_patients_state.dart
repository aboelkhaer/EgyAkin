import 'package:egy_akin/features/all_doctors_patients/data/models/get_all_doctors_patients_model_response.dart';
import 'package:egy_akin/features/profile_patients/data/models/get_profile_patients_model_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'profile_patients_state.freezed.dart';

@freezed
abstract class ProfilePatientsState with _$ProfilePatientsState {
  const factory ProfilePatientsState.initial() = _Initial;
  const factory ProfilePatientsState.loading() = _Loading;
  const factory ProfilePatientsState.loaded(
      GetProfilePatientsModelResponse response, bool isSeeMore) = _Loaded;
  const factory ProfilePatientsState.error(String message) = _Error;
}
