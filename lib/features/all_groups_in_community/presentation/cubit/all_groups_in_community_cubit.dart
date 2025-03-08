import 'package:egy_akin/features/all_groups_in_community/domain/usecases/get_all_groups_usecase.dart';
import 'package:egy_akin/features/all_groups_in_community/presentation/cubit/all_groups_in_community_state.dart';
import 'package:egy_akin/features/community/domain/usecases/join_group_in_community_usecase.dart';

import '../../../../exports.dart';

class AllGroupsInCommunityCubit extends Cubit<AllGroupsInCommunityState> {
  AllGroupsInCommunityCubit(
      this._getAllGroupsUsecase, this._joinGroupInCommunityUsecase)
      : super(const AllGroupsInCommunityState.initial());
  static AllGroupsInCommunityCubit get(context) => BlocProvider.of(context);
  final GetAllGroupsUsecase _getAllGroupsUsecase;

  final JoinGroupInCommunityUsecase _joinGroupInCommunityUsecase;
  int callAllGroups = 0;
  ScrollController? scrollControllerForAllGroups;
  bool isLoadingMoreForScrollForAllGroups = false;
  bool isLastPageForAllGroups = false;
  int _currentPageForAllGroups = 1;

  getAllGroups() async {
    _currentPageForAllGroups = 1;
    emit(const AllGroupsInCommunityState.loading());

    final result = await _getAllGroupsUsecase.execute(_currentPageForAllGroups);
    result.fold(
      (l) {
        emit(AllGroupsInCommunityState.error(l.message));
      },
      (response) async {
        emit(
          AllGroupsInCommunityState.loaded(
            response,
            '',
            '',
            false,
          ),
        );
      },
    );
  }

  void loadMoreGroups() async {
    _currentPageForAllGroups++;
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) => AllGroupsInCommunityState.loaded(
        value.response,
        '',
        '',
        true,
      ),
    ));
    final result = await _getAllGroupsUsecase.execute(_currentPageForAllGroups);
    result.fold(
      (l) {
        _currentPageForAllGroups--;
        emit(AllGroupsInCommunityState.error(l.message));
      },
      (loadMoreGroups) async {
        final currentState = state;
        currentState.when(
          initial: () {},
          loading: () {},
          loaded: (
            response,
            snackBarMessage,
            dialogMessage,
            isSeeMore,
          ) {
            final updatedData = response.copyWith(
              data: response.data!.copyWith(
                data: [
                  ...response.data!.data!,
                  ...loadMoreGroups.data!.data!,
                ],
              ),
            );
            if (_currentPageForAllGroups >= response.data!.lastPage!) {
              isLastPageForAllGroups = true;
            } else {
              isLastPageForAllGroups = false;
            }
            isLoadingMoreForScrollForAllGroups = false;
            emit(AllGroupsInCommunityState.loaded(
              updatedData,
              '',
              '',
              false,
            ));
          },
          error: (error) {},
        );
      },
    );
  }

  void joinGroup(String groupId) async {
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) {
        final response = value.response;
        if (response.data == null || response.data!.data == null) {
          return value; // Return unchanged state if data or latestGroups is null
        }

        // Find the group with the matching groupId and update its userStatus and memberCount
        final updatedGroups = response.data!.data!.map((group) {
          if (group.id.toString() == groupId) {
            return group.copyWith(
              userStatus: GroupInviteStatus.invited.name,
              memberCount:
                  (group.memberCount ?? 0) + 1, // Increment memberCount
            ); // Update userStatus and memberCount
          }
          return group; // Return unchanged group if ID doesn't match
        }).toList();

        // Create a new data object with the updated groups
        final updatedData = response.data!.copyWith(data: updatedGroups);

        // Create a new response object with the updated data
        final updatedResponse = response.copyWith(data: updatedData);

        // Return a new state with the updated response
        return AllGroupsInCommunityState.loaded(
          updatedResponse,
          '',
          '',
          false,
        );
      },
    ));

    final result = await _joinGroupInCommunityUsecase.execute(groupId);
    result.fold(
      (failure) {
        emit(state.maybeMap(
          orElse: () => state,
          loaded: (value) => AllGroupsInCommunityState.loaded(
            value.response,
            '',
            failure.message,
            false,
          ),
        ));
      },
      (success) {
        // Optionally handle success case if needed
      },
    );
  }
}
