import 'package:egy_akin/features/all_groups_in_community/domain/usecases/get_my_groups_usecase.dart';
import 'package:egy_akin/features/all_groups_in_community/presentation/cubit/my_groups_cubit/my_groups_in_community_state.dart';
import 'package:egy_akin/features/community/domain/usecases/join_group_in_community_usecase.dart';
import '../../../../../exports.dart';

class MyGroupsInCommunityCubit extends Cubit<MyGroupsInCommunityState> {
  MyGroupsInCommunityCubit(
      this._getMyGroupsUsecase, this._joinGroupInCommunityUsecase)
      : super(const MyGroupsInCommunityState.initial());
  static MyGroupsInCommunityCubit get(context) => BlocProvider.of(context);

  final GetMyGroupsUsecase _getMyGroupsUsecase;
  final JoinGroupInCommunityUsecase _joinGroupInCommunityUsecase;
  int callMyGroups = 0;
  ScrollController? scrollControllerForMyGroups;
  bool isLoadingMoreForScrollForMyGroups = false;
  bool isLastPageForMyGroups = false;
  int _currentPageForMyGroups = 1;

  getMyGroups() async {
    _currentPageForMyGroups = 1;
    emit(const MyGroupsInCommunityState.loading());

    final result = await _getMyGroupsUsecase.execute(_currentPageForMyGroups);
    result.fold(
      (l) {
        emit(MyGroupsInCommunityState.error(l.message));
      },
      (response) async {
        emit(
          MyGroupsInCommunityState.loaded(
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
    _currentPageForMyGroups++;
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) => MyGroupsInCommunityState.loaded(
        value.response,
        '',
        '',
        true,
      ),
    ));
    final result = await _getMyGroupsUsecase.execute(_currentPageForMyGroups);
    result.fold(
      (l) {
        _currentPageForMyGroups--;
        emit(MyGroupsInCommunityState.error(l.message));
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
            if (_currentPageForMyGroups >= response.data!.lastPage!) {
              isLastPageForMyGroups = true;
            } else {
              isLastPageForMyGroups = false;
            }
            isLoadingMoreForScrollForMyGroups = false;
            emit(MyGroupsInCommunityState.loaded(
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
              userStatus: group.privacy == GroupPrivacy.private.name
                  ? GroupInviteStatus.pending.name
                  : GroupInviteStatus.joined.name,
              memberCount: group.privacy == GroupPrivacy.public.name
                  ? (group.memberCount ?? 0) + 1
                  : group.memberCount, // Increment memberCount
            ); // Update userStatus and memberCount
          }
          return group; // Return unchanged group if ID doesn't match
        }).toList();

        // Create a new data object with the updated groups
        final updatedData = response.data!.copyWith(data: updatedGroups);

        // Create a new response object with the updated data
        final updatedResponse = response.copyWith(data: updatedData);

        // Return a new state with the updated response
        return MyGroupsInCommunityState.loaded(
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
          loaded: (value) => MyGroupsInCommunityState.loaded(
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
