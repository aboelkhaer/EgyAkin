import 'package:egy_akin/features/all_doctor_posts/data/models/get_all_doctor_posts_model_response.dart';
import 'package:egy_akin/features/saved_posts/data/models/get_saved_posts_model_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'saved_posts_state.freezed.dart';

@freezed
abstract class SavedPostsState with _$SavedPostsState {
  const factory SavedPostsState.initial() = _Initial;
  const factory SavedPostsState.loading() = _Loading;
  const factory SavedPostsState.loaded(
    GetSavedPostsModelResponse response,
    String snackBarMessage,
    String dialogMessage,
    bool isDeletePostLoading,
    bool isDeletePostLoaded,
    bool isSeeMore,
    int changeCounter,
  ) = _Loaded;

  const factory SavedPostsState.error(String message) = _Error;
}
