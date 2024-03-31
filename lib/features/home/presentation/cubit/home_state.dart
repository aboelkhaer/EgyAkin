import 'package:egy_akin/exports.dart';
import 'package:egy_akin/features/home/data/models/notification_model_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'home_state.freezed.dart';

@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState.initial() = _Initial;
  const factory HomeState.loading() = _Loading;

  const factory HomeState.loaded(
      HomeModelResponse homeData,
      DoctorModel currentDoctorModel,
      int dotsPosition,
      NotificationModelResponse notificationDataModel) = _Loaded;
  const factory HomeState.error(String message) = _Error;
}
