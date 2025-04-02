import 'package:egy_akin/features/all_groups_in_community/data/models/get_all_groups_in_community_model_response.dart';
import 'package:egy_akin/features/all_groups_in_community/data/models/get_doctor_invitation_for_groups_model_response.dart';
import 'package:egy_akin/features/all_groups_in_community/presentation/cubit/groups_invitations_cubit/groups_invitations_state.dart';

import '../../../../../exports.dart';

class GroupsInvitationsCubit extends Cubit<GroupsInvitationsState> {
  GroupsInvitationsCubit(
      this._getDoctorInvitationsForGroupsUsecase,
      this._acceptOrDeclineMemberInGroupUsecase,
      this._joinGroupInCommunityUsecase)
      : super(const GroupsInvitationsState.initial());
  static GroupsInvitationsCubit get(context) => BlocProvider.of(context);
  final GetDoctorInvitationsForGroupsUsecase
      _getDoctorInvitationsForGroupsUsecase;
  final AcceptOrDeclineMemberInGroupUsecase
      _acceptOrDeclineMemberInGroupUsecase;
  final JoinGroupInCommunityUsecase _joinGroupInCommunityUsecase;
  int callGroupsInvitations = 0;

  getGroupsInvitations(
    String doctorId,
  ) async {
    // _currentPageForAllGroups = 1;
    emit(const GroupsInvitationsState.loading());

    final result = await _getDoctorInvitationsForGroupsUsecase.execute(
      GetDoctorInvitationsForGroupsUsecaseInput(
        doctorId: doctorId,
        page: 1,
      ),
    );
    result.fold(
      (l) {
        emit(GroupsInvitationsState.error(l.message));
      },
      (response) async {
        emit(
          GroupsInvitationsState.loaded(
            response,
            '',
            '',
            false,
            false,
            false,
          ),
        );
      },
    );
  }

  String groupIdForAcceptOrDeclineMember = '';
  acceptOrDeclineMemberInGroup({
    required String groupId,
    required int invitationId,
    required String status,
  }) async {
    // First emit loading state
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) => GroupsInvitationsState.loaded(
        value.response,
        '',
        '',
        value.isSeeMore,
        status == AcceptOrDeclineMemberInGroup.accepted.name,
        status == AcceptOrDeclineMemberInGroup.declined.name,
      ),
    ));

    groupIdForAcceptOrDeclineMember = groupId;

    final result = await _acceptOrDeclineMemberInGroupUsecase.execute(
      AcceptOrDeclineMemberInGroupUsecaseInput(
        groupId: groupId,
        status: status,
        invitationId: invitationId,
      ),
    );

    result.fold(
      (failure) {
        emit(state.maybeMap(
          orElse: () => state,
          loaded: (value) => GroupsInvitationsState.loaded(
            value.response,
            failure.message,
            '',
            value.isSeeMore,
            false,
            false,
          ),
        ));
      },
      (success) async {
        emit(state.maybeMap(
          orElse: () => state,
          loaded: (value) {
            // Update the group's userStatus based on the action
            final updatedGroups = value.response.data?.data?.map((group) {
              if (group.id.toString() == groupId) {
                return group.copyWith(
                  userStatus:
                      status == AcceptOrDeclineMemberInGroup.accepted.name
                          ? 'joined'
                          : 'declined',
                  isHasPendingInvitations: false,
                  // Only increase memberCount if the status is accepted
                  memberCount:
                      status == AcceptOrDeclineMemberInGroup.accepted.name
                          ? (group.memberCount ?? 0) + 1
                          : group.memberCount,
                );
              }
              return group;
            }).toList();

            // Create updated response
            final updatedResponse = GetDoctorInvitationForGroupsModelResponse(
              data: GetAllGroupsInCommunityDataModelResponse(
                data: updatedGroups,
                currentPage: value.response.data?.currentPage,
                firstPageUrl: value.response.data?.firstPageUrl,
                from: value.response.data?.from,
                lastPage: value.response.data?.lastPage,
                lastPageUrl: value.response.data?.lastPageUrl,
                nextPageUrl: value.response.data?.nextPageUrl,
                path: value.response.data?.path,
                perPage: value.response.data?.perPage,
                prevPageUrl: value.response.data?.prevPageUrl,
                to: value.response.data?.to,
                total: value.response.data?.total,
              ),
            );

            return GroupsInvitationsState.loaded(
              updatedResponse,
              success.message.toString(),
              '',
              value.isSeeMore,
              false,
              false,
            );
          },
        ));
      },
    );

    groupIdForAcceptOrDeclineMember = '';
  }

  void joinGroup(String groupId) async {
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) {
        // Final update after API success
        final updatedGroups = value.response.data?.data?.map((group) {
          if (group.id.toString() == groupId) {
            return group.copyWith(
              // For private groups, keep as pending until approved
              // For public groups, confirm as joined
              userStatus: group.privacy == GroupPrivacy.private.name
                  ? GroupInviteStatus.pending.name
                  : GroupInviteStatus.joined.name,

              memberCount: group.privacy == 'private'
                  ? group.memberCount
                  : (group.memberCount ?? 0) + 1,
              isHasPendingInvitations: false,
            );
          }
          return group;
        }).toList();

        final updatedResponse = GetDoctorInvitationForGroupsModelResponse(
          data: GetAllGroupsInCommunityDataModelResponse(
            data: updatedGroups,
            // Preserve pagination data
            currentPage: value.response.data?.currentPage,
            firstPageUrl: value.response.data?.firstPageUrl,
            from: value.response.data?.from,
            lastPage: value.response.data?.lastPage,
            lastPageUrl: value.response.data?.lastPageUrl,
            nextPageUrl: value.response.data?.nextPageUrl,
            path: value.response.data?.path,
            perPage: value.response.data?.perPage,
            prevPageUrl: value.response.data?.prevPageUrl,
            to: value.response.data?.to,
            total: value.response.data?.total,
          ),
        );

        return GroupsInvitationsState.loaded(
          updatedResponse,
          '',
          '',
          value.isSeeMore,
          false,
          false,
        );
      },
    ));

    final result = await _joinGroupInCommunityUsecase.execute(groupId);
    result.fold(
      (failure) {
        emit(state.maybeMap(
          orElse: () => state,
          loaded: (value) => GroupsInvitationsState.loaded(
            value.response,
            failure.message,
            '',
            value.isSeeMore,
            false,
            false,
          ),
        ));
      },
      (success) async {},
    );
  }
}
