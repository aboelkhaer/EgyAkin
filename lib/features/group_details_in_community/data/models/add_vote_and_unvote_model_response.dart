// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_vote_and_unvote_model_response.freezed.dart';
part 'add_vote_and_unvote_model_response.g.dart';

@freezed
class AddVoteAndUnvoteModelResponse with _$AddVoteAndUnvoteModelResponse {
  const factory AddVoteAndUnvoteModelResponse({
    String? message,
  }) = _AddVoteAndUnvoteModelResponse;
  factory AddVoteAndUnvoteModelResponse.fromJson(Map<String, dynamic> json) =>
      _$AddVoteAndUnvoteModelResponseFromJson(json);
}
