import 'package:egy_akin/exports.dart';
import 'package:egy_akin/features/doctor_info_view/data/models/doctor_info_view_model_response.dart';
import 'package:egy_akin/features/doctor_info_view/data/models/get_achievements_model_response.dart';
import 'package:egy_akin/features/doctor_info_view/data/models/get_doctor_profile_score_history_model_response.dart';
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
      List<GetAchievementsModelResponse>? achievements) = _Loaded;
  const factory DoctorInfoViewState.error(String message) = _Error;
}
