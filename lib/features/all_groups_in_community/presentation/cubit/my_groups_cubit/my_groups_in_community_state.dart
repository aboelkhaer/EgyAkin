import 'package:egy_akin/features/all_groups_in_community/data/models/get_all_groups_in_community_model_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'my_groups_in_community_state.freezed.dart';

@freezed
abstract class MyGroupsInCommunityState with _$MyGroupsInCommunityState {
  const factory MyGroupsInCommunityState.initial() = _Initial;
  const factory MyGroupsInCommunityState.loading() = _Loading;

  const factory MyGroupsInCommunityState.loaded(
    GetAllGroupsInCommunityModelResponse response,
    String snackBarMessage,
    String dialogMessage,
    bool isSeeMore,
  ) = _Loaded;
  const factory MyGroupsInCommunityState.error(String message) = _Error;
}
