import 'package:egy_akin/features/community/data/models/get_posts_community_model_response.dart';
import 'package:egy_akin/features/show_single_feed/data/models/get_comments_in_community_model_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'show_single_feed_state.freezed.dart';

@freezed
abstract class ShowSingleFeedState with _$ShowSingleFeedState {
  const factory ShowSingleFeedState.initial() = _Initial;
  const factory ShowSingleFeedState.loading() = _Loading;
  const factory ShowSingleFeedState.loaded(
    GetCommentsInCommunityModelResponse commentsResponse,
    int changeCounter,
    PostCommunityModel feed,
    bool isSendCommentLoading,
    bool isSendCommentLoaded,
    String message,
    String? highlightedCommentId,
    bool isDeleteCommentLoading,
    bool isDeleteCommentLoaded,
    bool isSendReplyLoading,
    bool isSendReplyLoaded,
    bool isSeeMore,
  ) = _Loaded;

  const factory ShowSingleFeedState.error(String message) = _Error;
}
