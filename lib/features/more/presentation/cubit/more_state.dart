import 'package:freezed_annotation/freezed_annotation.dart';
part 'more_state.freezed.dart';

@freezed
abstract class MoreState with _$MoreState {
  const factory MoreState.initial() = _Initial;
  const factory MoreState.loading() = _Loading;

  const factory MoreState.loaded() = _Loaded;
  const factory MoreState.error(String message) = _Error;
}
