import 'package:egy_akin/exports.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'patient_comments_state.freezed.dart';

@freezed
abstract class PatientCommentsState with _$PatientCommentsState {
  const factory PatientCommentsState.initial() = _Initial;
  const factory PatientCommentsState.loading() = _Loading;
  const factory PatientCommentsState.loaded(
      List<CommentModel> comments,
      String newComment,
      bool isLoading,
      bool isCommentSuccess,
      String message) = _Loaded;
  const factory PatientCommentsState.error(String message) = _Error;
}
