import 'package:egy_akin/exports.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'doctor_profile_view_state.freezed.dart';

@freezed
abstract class DoctorProfileViewState with _$DoctorProfileViewState {
  const factory DoctorProfileViewState.initial() = _Initial;
  const factory DoctorProfileViewState.loading() = _Loading;

  const factory DoctorProfileViewState.loaded(
      DoctorModel currentDoctorModel,
      bool isProfileHasChanged,
      String message,
      bool isUpdateing,
      bool isSubmit,
      bool isMedicalStatistics) = _Loaded;
  const factory DoctorProfileViewState.error(String message) = _Error;
}
