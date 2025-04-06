import 'dart:developer';

import 'package:egy_akin/features/group_members/data/models/get_post_likes_model_response.dart';

import '../../../../exports.dart';

class GroupMembersCubit extends Cubit<GroupMembersState> {
  GroupMembersCubit(
      this._getGroupMembersUsecase,
      this._getPostLikesUsecase,
      this._removeMemberFromGroupUsecase,
      this._acceptOrDeclineMemberInGroupUsecase)
      : super(const GroupMembersState.initial());
  static GroupMembersCubit get(context) => BlocProvider.of(context);
  final GetGroupMembersUsecase _getGroupMembersUsecase;
  final GetPostLikesUsecase _getPostLikesUsecase;
  final RemoveMemberFromGroupUsecase _removeMemberFromGroupUsecase;
  final AcceptOrDeclineMemberInGroupUsecase
      _acceptOrDeclineMemberInGroupUsecase;

  ScrollController? scrollController;
  bool isLoadingMoreForScroll = false;
  bool isLastPage = false;
  int _currentPage = 1;

  getGroupMembers(String groupId) async {
    _currentPage = 1;
    emit(const GroupMembersState.loading());
    final result = await _getGroupMembersUsecase.execute(
        GetGroupMembersUsecaseInput(
            groupId: groupId, pageNumber: _currentPage));

    result.fold((l) {
      emit(GroupMembersState.error(l.message));
    }, (r) async {
      emit(GroupMembersState.loaded(
        '',
        '',
        r,
        false,
        false,
        false,
        false,
        false,
        const GetPostLikesModelResponse(),
      ));
    });
  }

  getPostLikes(String postId) async {
    _currentPage = 1;
    emit(const GroupMembersState.loading());
    final result = await _getPostLikesUsecase.execute(
        GetPostLikesUsecaseInput(postId: postId, pageNumber: _currentPage));

    result.fold((l) {
      emit(GroupMembersState.error(l.message));
    }, (r) async {
      emit(GroupMembersState.loaded(
        '',
        '',
        const GetGroupMembersModelResponse(),
        false,
        false,
        false,
        false,
        false,
        r,
      ));
    });
  }

  void loadMoreMembers(String groupId) async {
    _currentPage++;

    // Show loading more state
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) => GroupMembersState.loaded(
        '',
        '',
        value.response,
        true,
        value.isRemoveMemberFromGroupLoading,
        value.isRemoveMemberFromGroupLoaded,
        value.isAcceptLoading,
        value.isDeclineLoading,
        value.postLikesResponse,
      ),
    ));

    final result = await _getGroupMembersUsecase.execute(
      GetGroupMembersUsecaseInput(groupId: groupId, pageNumber: _currentPage),
    );

    result.fold(
      (l) {
        _currentPage--;
        emit(GroupMembersState.error(l.message));
      },
      (loadMoreMembers) {
        final currentState = state;
        currentState.when(
          initial: () {},
          loading: () {},
          error: (_) {},
          loaded: (
            snackBarMessage,
            dialogMessage,
            response,
            isSeeMore,
            isRemoveMemberFromGroupLoading,
            isRemoveMemberFromGroupLoaded,
            isAcceptLoading,
            isDeclineLoading,
            postLikesResponse,
          ) {
            final oldMembers = response.data!.members!;
            final newMembers = loadMoreMembers.data!.members!;

            final mergedMembers = oldMembers.copyWith(
              data: [...?oldMembers.data, ...?newMembers.data],
              currentPage: newMembers.currentPage,
              lastPage: newMembers.lastPage,
              nextPageUrl: newMembers.nextPageUrl,
            );

            final updatedResponse = response.copyWith(
              data: response.data!.copyWith(
                members: mergedMembers,
              ),
            );

            isLastPage =
                _currentPage >= (mergedMembers.lastPage ?? _currentPage);
            isLoadingMoreForScroll = false;

            emit(
              GroupMembersState.loaded(
                '', // snackBarMessage
                '', // dialogMessage
                updatedResponse,
                false, // isSeeMore
                false, // isRemoveMemberFromGroupLoading
                false, // isRemoveMemberFromGroupLoaded
                false,
                false,
                const GetPostLikesModelResponse(),
              ),
            );
          },
        );
      },
    );
  }

  String doctorIdForLoading = '';
  void removeMemberFromGroup(String groupId, String doctorId) async {
    // Set loading state for removal
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) => GroupMembersState.loaded(
        '',
        '',
        value.response,
        false,
        true,
        false,
        value.isAcceptLoading,
        value.isDeclineLoading,
        value.postLikesResponse,
      ),
    ));

    final result = await _removeMemberFromGroupUsecase.execute(
      RemoveMemberFromGroupUsecaseInput(
        groupId: groupId,
        doctorId: doctorId,
      ),
    );

    result.fold(
      (l) {
        emit(state.maybeMap(
          orElse: () => state,
          loaded: (value) => GroupMembersState.loaded(
            l.message,
            '',
            value.response,
            false,
            false,
            false,
            value.isAcceptLoading,
            value.isDeclineLoading,
            value.postLikesResponse,
          ),
        ));
      },
      (r) async {
        emit(state.maybeMap(
          orElse: () => state,
          loaded: (value) {
            final currentMembers = value.response.data?.members;

            // Filter out the removed member
            final updatedDoctors = currentMembers?.data
                ?.where((doctor) => doctor.id.toString() != doctorId)
                .toList();

            // Create updated members list
            final updatedMembers = currentMembers?.copyWith(
              data: updatedDoctors,
            );

            // Update the full response
            final updatedResponse = value.response.copyWith(
              data: value.response.data?.copyWith(
                members: updatedMembers,
              ),
            );
            sl<GroupDetailsInCommunityCubit>().increaseOrDecreaseMembers(false);

            return GroupMembersState.loaded(
              '', // snackBarMessage
              '', // dialogMessage
              updatedResponse,
              false,
              false,
              true, // isRemoveMemberFromGroupLoaded
              value.isAcceptLoading,
              value.isDeclineLoading, value.postLikesResponse,
            );
          },
        ));
      },
    );

    doctorIdForLoading = '';
  }

  String doctorIdForAcceptOrDeclineMember = '';
  acceptOrDeclineMemberInGroup({
    required String groupId,
    required int invitationId,
    required String status,
    required String doctorId,
  }) async {
    // First emit loading state
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) => GroupMembersState.loaded(
        '',
        '',
        value.response,
        value.isSeeMore,
        value.isRemoveMemberFromGroupLoading,
        value.isRemoveMemberFromGroupLoaded,
        status == AcceptOrDeclineMemberInGroup.accepted.name,
        status == AcceptOrDeclineMemberInGroup.declined.name,
        value.postLikesResponse,
      ),
    ));

    doctorIdForAcceptOrDeclineMember = doctorId;

    final result = await _acceptOrDeclineMemberInGroupUsecase.execute(
      AcceptOrDeclineMemberInGroupUsecaseInput(
          groupId: groupId, status: status, invitationId: invitationId),
    );

    result.fold(
      (failure) {
        emit(state.maybeMap(
          orElse: () => state,
          loaded: (value) => GroupMembersState.loaded(
            failure.message,
            '',
            value.response,
            value.isSeeMore,
            value.isRemoveMemberFromGroupLoading,
            value.isRemoveMemberFromGroupLoaded,
            false,
            false,
            value.postLikesResponse,
          ),
        ));
      },
      (success) async {
        // Update the state by moving the doctor between lists
        emit(state.maybeMap(
          orElse: () => state,
          loaded: (value) {
            // Find the doctor in pending invitations
            final pendingDoctor = value.response.data?.pendingInvitations
                ?.firstWhere((doc) => doc.id.toString() == doctorId);

            if (pendingDoctor == null) return value;

            // Create updated lists
            final updatedPending = List<DoctorModel>.from(
                value.response.data?.pendingInvitations ?? [])
              ..removeWhere((doc) => doc.id.toString() == doctorId);

            final updatedMembers = List<DoctorModel>.from(
                value.response.data?.members?.data ?? []);

            if (status == AcceptOrDeclineMemberInGroup.accepted.name) {
              updatedMembers.add(pendingDoctor);
              sl<GroupDetailsInCommunityCubit>()
                  .increaseOrDecreaseMembers(true);
            }

            // Create updated response
            final updatedResponse = GetGroupMembersModelResponse(
              data: GetGroupMembersDataModelResponse(
                members: value.response.data?.members?.copyWith(
                  data: updatedMembers,
                ),
                pendingInvitations: updatedPending,
              ),
            );

            // Check if no pending invitations left
            if (updatedPending.isEmpty) {
              // Call the function to update hasPendingInvitations flag
              sl<GroupDetailsInCommunityCubit>().changeIsHasInvitationsValue();
            }

            return GroupMembersState.loaded(
              success.message.toString(),
              '',
              updatedResponse,
              value.isSeeMore,
              value.isRemoveMemberFromGroupLoading,
              value.isRemoveMemberFromGroupLoaded,
              false,
              false,
              value.postLikesResponse,
            );
          },
        ));
      },
    );

    doctorIdForAcceptOrDeclineMember = '';
  }
}
