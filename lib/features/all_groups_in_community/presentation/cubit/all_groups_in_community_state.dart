import 'package:egy_akin/features/all_groups_in_community/data/models/get_all_groups_in_community_model_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'all_groups_in_community_state.freezed.dart';

@freezed
abstract class AllGroupsInCommunityState with _$AllGroupsInCommunityState {
  const factory AllGroupsInCommunityState.initial() = _Initial;
  const factory AllGroupsInCommunityState.loading() = _Loading;

  const factory AllGroupsInCommunityState.loaded(
    GetAllGroupsInCommunityModelResponse response,
    String snackBarMessage,
    String dialogMessage,
    bool isSeeMore,
  ) = _Loaded;
  const factory AllGroupsInCommunityState.error(String message) = _Error;
}
