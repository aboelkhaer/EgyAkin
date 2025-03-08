import 'package:egy_akin/features/community/data/models/get_groups_tab_model_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'groups_state.freezed.dart';

@freezed
abstract class GroupsState with _$GroupsState {
  const factory GroupsState.initial() = _Initial;
  const factory GroupsState.loading() = _Loading;

  const factory GroupsState.loaded(
    GetGroupsTabModelResponse response,
    String snackBarMessage,
    String dialogMessage,
  ) = _Loaded;
  const factory GroupsState.error(String message) = _Error;
}
