import 'package:egy_akin/features/community_search/data/models/get_response_of_search_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'community_search_state.freezed.dart';

@freezed
abstract class CommunitySearchState with _$CommunitySearchState {
  const factory CommunitySearchState.initial() = _Initial;
  const factory CommunitySearchState.loading() = _Loading;

  const factory CommunitySearchState.loaded(
    String snackBarMessage,
    String dialogMessage,
    GetResponseOfSearchModel response,
  ) = _Loaded;
  const factory CommunitySearchState.error(String message) = _Error;
}
