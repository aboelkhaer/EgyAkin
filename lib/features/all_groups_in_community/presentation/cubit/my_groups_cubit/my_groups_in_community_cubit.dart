import 'package:egy_akin/app/shared/functions/community_groups_local_sync.dart';
import 'package:egy_akin/features/all_groups_in_community/domain/usecases/get_my_groups_usecase.dart';
import 'package:egy_akin/features/all_groups_in_community/presentation/cubit/my_groups_cubit/my_groups_in_community_state.dart';
import 'package:egy_akin/features/community/domain/usecases/join_group_in_community_usecase.dart';
import 'package:egy_akin/features/inbox/presentation/cubit/inbox_cubit.dart';
import 'package:get_it/get_it.dart';
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

  Future<void> getMyGroups({bool showLoading = true}) async {
    _currentPageForMyGroups = 1;
    isLastPageForMyGroups = false;
    if (showLoading) {
      emit(const MyGroupsInCommunityState.loading());
    }

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

    state.maybeWhen(
      orElse: () {},
      loaded: (response, _, __, ___) {
        GroupModel? updated;
        for (final group in response.data?.data ?? const <GroupModel>[]) {
          if (group.id.toString() == groupId) {
            updated = group;
            break;
          }
        }
        if (updated != null) {
          CommunityGroupsLocalSync.syncGroup(updated);
        }
      },
    );

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
        try {
          final id = int.tryParse(groupId);
          if (id != null &&
              id > 0 &&
              GetIt.I.isRegistered<InboxCubit>()) {
            GetIt.I<InboxCubit>().notifySocialGroupJoined(groupId: id);
          }
        } catch (_) {}
      },
    );
  }

  void applyGroupUpdate(GroupModel group) {
    final groupId = group.id?.toString();
    if (groupId == null) return;
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) {
        final groups = value.response.data?.data;
        if (groups == null) return value;
        final index = groups.indexWhere((g) => g.id?.toString() == groupId);
        if (index < 0) return value;
        final updated = [...groups];
        updated[index] = group;
        return MyGroupsInCommunityState.loaded(
          value.response.copyWith(
            data: value.response.data!.copyWith(data: updated),
          ),
          '',
          '',
          false,
        );
      },
    ));
  }

  void upsertGroup(GroupModel group) {
    final groupId = group.id?.toString();
    if (groupId == null) return;
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) {
        final nested = value.response.data;
        final groups = [...(nested?.data ?? const <GroupModel>[])];
        final index = groups.indexWhere((g) => g.id?.toString() == groupId);
        if (index >= 0) {
          groups[index] = group;
        } else {
          groups.insert(0, group);
        }
        final previousTotal = nested?.total;
        return MyGroupsInCommunityState.loaded(
          value.response.copyWith(
            data: nested?.copyWith(
              data: groups,
              total: previousTotal == null
                  ? groups.length
                  : index >= 0
                      ? previousTotal
                      : previousTotal + 1,
            ),
          ),
          '',
          '',
          false,
        );
      },
    ));
  }

  void removeGroupFromList(String groupId) {
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) {
        final nested = value.response.data;
        final groups = nested?.data;
        if (groups == null) return value;
        final updated =
            groups.where((g) => g.id?.toString() != groupId).toList();
        if (updated.length == groups.length) return value;
        final previousTotal = nested?.total;
        return MyGroupsInCommunityState.loaded(
          value.response.copyWith(
            data: nested!.copyWith(
              data: updated,
              total: previousTotal == null
                  ? updated.length
                  : (previousTotal - 1).clamp(0, previousTotal),
            ),
          ),
          '',
          '',
          false,
        );
      },
    ));
  }
}
