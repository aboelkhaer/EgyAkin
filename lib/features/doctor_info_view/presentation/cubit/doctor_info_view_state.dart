import 'package:egy_akin/exports.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'doctor_info_view_state.freezed.dart';

@freezed
abstract class DoctorInfoViewState with _$DoctorInfoViewState {
  const factory DoctorInfoViewState.initial() = _Initial;
  const factory DoctorInfoViewState.loading() = _Loading;

  const factory DoctorInfoViewState.loaded(
      DoctorInfoViewModelResponse? doctorInfo,
      bool isLoadingAchievements,
      bool isLoadedAchievements,
      String message,
      List<GetAchievementsModelResponse>? achievements,
      int changesCounter) = _Loaded;
  const factory DoctorInfoViewState.error(String message) = _Error;
}
