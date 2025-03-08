import 'package:freezed_annotation/freezed_annotation.dart';
part 'create_group_in_community_state.freezed.dart';

@freezed
abstract class CreateGroupInCommunityState with _$CreateGroupInCommunityState {
  const factory CreateGroupInCommunityState.initial() = _Initial;
  const factory CreateGroupInCommunityState.loading() = _Loading;

  const factory CreateGroupInCommunityState.loaded(
    String snackBarMessage,
    String dialogMessage,
    bool isPickGroupHeaderLoading,
    bool isPickGroupImageLoading,
    int counterChanges,
    bool isCreateGroupLoading,
    bool isCreateGroupLoaded,
  ) = _Loaded;
  const factory CreateGroupInCommunityState.error(String message) = _Error;
}
