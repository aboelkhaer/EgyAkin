import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../exports.dart';
part 'profile_state.freezed.dart';

@freezed
abstract class ProfileState with _$ProfileState {
  const factory ProfileState.initial() = _Initial;
  const factory ProfileState.loading() = _Loading;
  const factory ProfileState.signOutLoading() = _SignOutLoading;
  const factory ProfileState.signOutLoaded() = _SignOutLoaded;
  const factory ProfileState.loaded(DoctorModel doctorModel) = _Loaded;

  const factory ProfileState.error(String message) = _Error;
}
