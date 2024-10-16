import 'package:egy_akin/features/community/data/models/get_posts_community_model_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'community_state.freezed.dart';

@freezed
abstract class CommunityState with _$CommunityState {
  const factory CommunityState.initial() = _Initial;
  const factory CommunityState.loading() = _Loading;

  const factory CommunityState.loaded(
      GetPostsCommunityModelResponse feedsResponse) = _Loaded;
  const factory CommunityState.error(String message) = _Error;
}
