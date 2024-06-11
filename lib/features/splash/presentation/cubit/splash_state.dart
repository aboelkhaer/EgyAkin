import 'package:freezed_annotation/freezed_annotation.dart';
part 'splash_state.freezed.dart';

@freezed
abstract class SplashState with _$SplashState {
  const factory SplashState.loading() = _Loading;
  const factory SplashState.loaded(bool isAuthentication, bool isWelcomed,
      bool isAppFreeze, bool isForceUpdate) = _Loaded;
}
