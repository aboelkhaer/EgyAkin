import 'package:egy_akin/features/community/data/models/get_groups_tab_model_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'invite_member_to_group_in_community_state.freezed.dart';

@freezed
abstract class InviteMemberToGroupInCommunityState
    with _$InviteMemberToGroupInCommunityState {
  const factory InviteMemberToGroupInCommunityState.initial() = _Initial;
  const factory InviteMemberToGroupInCommunityState.loading() = _Loading;

  const factory InviteMemberToGroupInCommunityState.loaded(
    String snackBarMessage,
    String dialogMessage,
  ) = _Loaded;
  const factory InviteMemberToGroupInCommunityState.error(String message) =
      _Error;
}
