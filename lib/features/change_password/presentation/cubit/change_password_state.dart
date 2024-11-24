import 'package:freezed_annotation/freezed_annotation.dart';
part 'change_password_state.freezed.dart';

@freezed
abstract class ChangePasswordState with _$ChangePasswordState {
  const factory ChangePasswordState.initial() = _Initial;
  const factory ChangePasswordState.loading() = _Loading;
  const factory ChangePasswordState.loaded(String message) = _Loaded;
  const factory ChangePasswordState.error(String message) = _Error;
}
