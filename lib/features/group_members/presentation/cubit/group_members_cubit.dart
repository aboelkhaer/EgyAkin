import 'package:egy_akin/features/group_members/domain/usecases/get_group_members_usecase.dart';
import 'package:egy_akin/features/group_members/domain/usecases/get_post_likes_usecase.dart';
import 'package:egy_akin/features/group_members/domain/usecases/remove_member_from_group_usecase.dart';
import 'package:egy_akin/features/group_members/presentation/cubit/group_members_state.dart';

import '../../../../exports.dart';

class GroupMembersCubit extends Cubit<GroupMembersState> {
  GroupMembersCubit(this._getGroupMembersUsecase, this._getPostLikesUsecase,
      this._removeMemberFromGroupUsecase)
      : super(const GroupMembersState.initial());
  static GroupMembersCubit get(context) => BlocProvider.of(context);
  final GetGroupMembersUsecase _getGroupMembersUsecase;
  final GetPostLikesUsecase _getPostLikesUsecase;
  final RemoveMemberFromGroupUsecase _removeMemberFromGroupUsecase;

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
        r,
        false,
        false,
        false,
      ));
    });
  }

  void loadMoreMembers(String groupId) async {
    _currentPage++;
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) => GroupMembersState.loaded(
        '',
        '',
        value.response,
        true,
        value.isRemoveMemberFromGroupLoading,
        value.isRemoveMemberFromGroupLoaded,
      ),
    ));
    final result = await _getGroupMembersUsecase.execute(
        GetGroupMembersUsecaseInput(
            groupId: groupId, pageNumber: _currentPage));
    result.fold(
      (l) {
        _currentPage--;

        emit(GroupMembersState.error(l.message));
      },
      (loadMoreMembers) async {
        final currentState = state;
        currentState.when(
          initial: () {},
          loading: () {},
          loaded: (
            snackBarMessage,
            dialogMessage,
            response,
            isSeeMore,
            isRemoveMemberFromGroupLoading,
            isRemoveMemberFromGroupLoaded,
          ) {
            final updatedData = response.copyWith(
              data: response.data!.copyWith(data: [
                ...response.data!.data!,
                ...loadMoreMembers.data!.data!,
              ]),
            );
            if (_currentPage >= response.data!.lastPage!) {
              isLastPage = true;
            } else {
              isLastPage = false;
            }
            isLoadingMoreForScroll = false;
            emit(GroupMembersState.loaded(
              '',
              '',
              updatedData,
              false,
              false,
              false,
            ));
          },
          error: (error) {},
        );
      },
    );
  }

  String doctorIdForLoading = '';
  removeMemberFromGroup(String groupId, String doctorId) async {
    // Emit a loading state or any initial state if needed
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) => GroupMembersState.loaded(
        '',
        '',
        value.response,
        false,
        true,
        false,
      ),
    ));

    // Execute the use case to remove the member
    final result = await _removeMemberFromGroupUsecase.execute(
      RemoveMemberFromGroupUsecaseInput(
        groupId: groupId,
        doctorId: doctorId,
      ),
    );

    result.fold((l) {
      // Handle the failure case
      emit(state.maybeMap(
        orElse: () => state,
        loaded: (value) => GroupMembersState.loaded(
          l.message,
          '',
          value.response,
          false,
          false,
          false,
        ),
      ));
    }, (r) async {
      // Handle the success case
      emit(state.maybeMap(
        orElse: () => state,
        loaded: (value) {
          // Filter out the member with the specified doctorId
          final updatedData = value.response.data?.data
              ?.where((doctor) => doctor.id.toString() != doctorId)
              .toList();

          // Create a new response with the updated data
          final updatedResponse = value.response.copyWith(
            data: value.response.data?.copyWith(data: updatedData),
          );

          // Emit the updated state
          return GroupMembersState.loaded(
            '',
            '',
            updatedResponse,
            false,
            false,
            true,
          );
        },
      ));
    });
    doctorIdForLoading = '';
  }
}
