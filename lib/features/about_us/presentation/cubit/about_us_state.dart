import 'package:freezed_annotation/freezed_annotation.dart';
part 'about_us_state.freezed.dart';

@freezed
abstract class AboutUsState with _$AboutUsState {
  const factory AboutUsState.initial() = _Initial;
  const factory AboutUsState.loading() = _Loading;

  const factory AboutUsState.loaded() = _Loaded;
  const factory AboutUsState.error(String message) = _Error;
}
