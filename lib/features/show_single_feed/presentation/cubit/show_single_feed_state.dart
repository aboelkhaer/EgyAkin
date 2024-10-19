import 'package:freezed_annotation/freezed_annotation.dart';
part 'show_single_feed_state.freezed.dart';

@freezed
abstract class ShowSingleFeedState with _$ShowSingleFeedState {
  const factory ShowSingleFeedState.initial() = _Initial;
  const factory ShowSingleFeedState.loading() = _Loading;
  const factory ShowSingleFeedState.loaded() = _Loaded;

  const factory ShowSingleFeedState.error(String message) = _Error;
}
