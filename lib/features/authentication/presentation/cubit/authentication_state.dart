import 'package:egy_akin/exports.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'authentication_state.freezed.dart';

@freezed
abstract class AuthenticationState with _$AuthenticationState {
  const factory AuthenticationState.initial() = _Initial;
  const factory AuthenticationState.loading() = _Loading;
  const factory AuthenticationState.changePasswordVisibility(
          bool signInObscureText, bool signInVisiblePasswordIcon) =
      _ChangePasswordVisibility;
  const factory AuthenticationState.loaded(
      AuthenticationModelResponse doctorData) = _Loaded;
  const factory AuthenticationState.error(String message) = _Error;
}
