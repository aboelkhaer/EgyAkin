import 'package:freezed_annotation/freezed_annotation.dart';
part 'email_verification_state.freezed.dart';

@freezed
abstract class EmailVerificationState with _$EmailVerificationState {
  const factory EmailVerificationState.initial() = _Initial;
  const factory EmailVerificationState.loading() = _Loading;

  const factory EmailVerificationState.loaded() = _Loaded;
  const factory EmailVerificationState.error(String message) = _Error;
}
