import 'package:egy_akin/features/group_details_in_community/data/models/get_group_details_in_community_model_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'group_details_in_community_state.freezed.dart';

@freezed
abstract class GroupDetailsInCommunityState
    with _$GroupDetailsInCommunityState {
  const factory GroupDetailsInCommunityState.initial() = _Initial;
  const factory GroupDetailsInCommunityState.loading() = _Loading;

  const factory GroupDetailsInCommunityState.loaded(
    GetGroupDetailsInCommunityModelResponse groupDetails,
    String snackBarMessage,
    String dialogMessage,
    bool isDeleteGroupLoading,
    bool isDeleteGroupLoaded,
    int changeCounter,
    bool isSeeMore,
  ) = _Loaded;
  const factory GroupDetailsInCommunityState.error(String message) = _Error;
}
