import 'package:egy_akin/features/all_doctor_posts/data/models/get_all_doctor_posts_model_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'all_doctor_posts_state.freezed.dart';

@freezed
abstract class AllDoctorPostsState with _$AllDoctorPostsState {
  const factory AllDoctorPostsState.initial() = _Initial;
  const factory AllDoctorPostsState.loading() = _Loading;

  const factory AllDoctorPostsState.loaded(
    GetAllDoctorPostsModelResponse response,
    String snackBarMessage,
    String dialogMessage,
    bool isDeletePostLoading,
    bool isDeletePostLoaded,
    bool isSeeMore,
    int changeCounter,
  ) = _Loaded;
  const factory AllDoctorPostsState.error(String message) = _Error;
}
