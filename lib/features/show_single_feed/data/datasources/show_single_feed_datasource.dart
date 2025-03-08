import 'package:egy_akin/features/show_single_feed/data/models/add_like_or_unlike_on_comment_in_community_model_response.dart';
import 'package:egy_akin/features/show_single_feed/data/models/create_comment_on_post_in_community_model_response.dart';
import 'package:egy_akin/features/show_single_feed/data/models/create_reply_on_comment_in_community_model_response.dart';
import 'package:egy_akin/features/show_single_feed/data/models/delete_comment_on_post_in_community_model_response.dart';
import 'package:egy_akin/features/show_single_feed/data/models/delete_reply_on_comment_in_community_model_response.dart';

import '../../../../exports.dart';

abstract class ShowSingleFeedDatasource {
  Future<GetCommentsInCommunityModelResponse> getCommentsInCommunity({
    required String postId,
  });
  Future<AddLikeOrUnlikeOnCommentInCommunityModelResponse>
      addLikeOrUnlikeOnCommentInCommunity({
    required String commentId,
    required String status,
  });
  Future<CreateCommentOnPostInCommunityModelResponse>
      createCommentOnPostInCommunity({
    required String postId,
    required String comment,
    required int? parentId,
  });
  Future<DeleteCommentOnPostInCommunityModelResponse>
      deleteCommentOnPostInCommunity({
    required String commentId,
  });
  Future<CreateReplyOnCommentInCommunityModelResponse>
      createReplyOnCommentInCommunity({
    required String postId,
    required String comment,
    required int? parentId,
  });
}

class ShowSingleFeedDatasourceImpl implements ShowSingleFeedDatasource {
  final ApiServices _apiServices;

  ShowSingleFeedDatasourceImpl(this._apiServices);

  @override
  Future<GetCommentsInCommunityModelResponse> getCommentsInCommunity(
      {required String postId}) async {
    return await _apiServices.getCommentsInCommunity(postId);
  }

  @override
  Future<AddLikeOrUnlikeOnCommentInCommunityModelResponse>
      addLikeOrUnlikeOnCommentInCommunity(
          {required String commentId, required String status}) async {
    return await _apiServices.addLikeAndUnlikeOnCommentInCommunity(
        commentId, status);
  }

  @override
  Future<CreateCommentOnPostInCommunityModelResponse>
      createCommentOnPostInCommunity({
    required String postId,
    required String comment,
    required int? parentId,
  }) async {
    return _apiServices.createCommentOnPostInCommunity(
      postId,
      comment,
      parentId,
    );
  }

  @override
  Future<DeleteCommentOnPostInCommunityModelResponse>
      deleteCommentOnPostInCommunity({required String commentId}) async {
    return await _apiServices.deleteCommentOnPostInCommunity(commentId);
  }

  @override
  Future<CreateReplyOnCommentInCommunityModelResponse>
      createReplyOnCommentInCommunity(
          {required String postId,
          required String comment,
          required int? parentId}) async {
    return await _apiServices.createReplyOnCommentInCommunity(
        postId, comment, parentId);
  }
}
