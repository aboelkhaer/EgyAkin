import 'package:egy_akin/features/group_members/data/models/get_group_members_model_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'group_members_state.freezed.dart';

@freezed
abstract class GroupMembersState with _$GroupMembersState {
  const factory GroupMembersState.initial() = _Initial;
  const factory GroupMembersState.loading() = _Loading;

  const factory GroupMembersState.loaded(
    String snackBarMessage,
    String dialogMessage,
    GetGroupMembersModelResponse response,
    bool isSeeMore,
    bool isRemoveMemberFromGroupLoading,
    bool isRemoveMemberFromGroupLoaded,
  ) = _Loaded;
  const factory GroupMembersState.error(String message) = _Error;
}
