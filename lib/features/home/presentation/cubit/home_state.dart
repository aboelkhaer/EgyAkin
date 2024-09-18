import 'package:egy_akin/exports.dart';
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
      int homeIndex,
      bool isUploadingSyndicateCard,
      bool isUploadedSyndicateCard,
      String message,
      int checkUpdateMessageCounter) = _Loaded;
  const factory HomeState.error(String message) = _Error;
}
