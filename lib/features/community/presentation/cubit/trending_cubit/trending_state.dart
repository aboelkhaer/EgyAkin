import 'package:egy_akin/features/community/data/models/get_trending_tab_in_community_model_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'trending_state.freezed.dart';

@freezed
abstract class TrendingState with _$TrendingState {
  const factory TrendingState.initial() = _Initial;
  const factory TrendingState.loading() = _Loading;

  const factory TrendingState.loaded(
    String snackBarMessage,
    String dialogMessage,
    GetTrendingTabInCommunityModelResponse response,
    bool isSeeMore,
  ) = _Loaded;
  const factory TrendingState.error(String message) = _Error;
}
