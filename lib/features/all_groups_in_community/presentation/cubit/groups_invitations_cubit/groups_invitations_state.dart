import 'package:egy_akin/features/all_groups_in_community/data/models/get_doctor_invitation_for_groups_model_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'groups_invitations_state.freezed.dart';

@freezed
abstract class GroupsInvitationsState with _$GroupsInvitationsState {
  const factory GroupsInvitationsState.initial() = _Initial;
  const factory GroupsInvitationsState.loading() = _Loading;

  const factory GroupsInvitationsState.loaded(
    GetDoctorInvitationForGroupsModelResponse response,
    String snackBarMessage,
    String dialogMessage,
    bool isSeeMore,
    bool isAcceptLoading,
    bool isDeclineLoading,
  ) = _Loaded;
  const factory GroupsInvitationsState.error(String message) = _Error;
}
