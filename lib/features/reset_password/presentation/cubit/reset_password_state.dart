import 'package:freezed_annotation/freezed_annotation.dart';
part 'reset_password_state.freezed.dart';

@freezed
abstract class ResetPasswordState with _$ResetPasswordState {
  const factory ResetPasswordState.initial() = _Initial;
  const factory ResetPasswordState.loading() = _Loading;
  const factory ResetPasswordState.loaded() = _Loaded;
  const factory ResetPasswordState.countDownInProgress(int remainingSeconds) =
      _CountDownInProgress;
  const factory ResetPasswordState.countDowncompleted() = _CountDownCompleted;
  const factory ResetPasswordState.passwordChagedSuccessfully() =
      _PasswordChagedSuccessfully;
  const factory ResetPasswordState.error(String message) = _Error;
}
