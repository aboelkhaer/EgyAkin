import 'package:freezed_annotation/freezed_annotation.dart';
part 'create_post_in_community_state.freezed.dart';

@freezed
abstract class CreatePostInCommunityState with _$CreatePostInCommunityState {
  const factory CreatePostInCommunityState.initial() = _Initial;
  const factory CreatePostInCommunityState.loading(int tabIndex) = _Loading;

  const factory CreatePostInCommunityState.loaded(
    int postLength,
    int changeCounter,
    bool isImagePick,
    bool isUploadPostLoading,
    bool isUploadPostLoaded,
    String message,
  ) = _Loaded;
  const factory CreatePostInCommunityState.error(String message) = _Error;
}
