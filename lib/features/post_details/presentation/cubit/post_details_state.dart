import 'package:egy_akin/exports.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'post_details_state.freezed.dart';

@freezed
abstract class PostDetailsState with _$PostDetailsState {
  const factory PostDetailsState.initial() = _Initial;
  const factory PostDetailsState.loading() = _Loading;
  const factory PostDetailsState.loaded(List<CommentModel> comments) = _Loaded;
  const factory PostDetailsState.error(String message) = _Error;
}
