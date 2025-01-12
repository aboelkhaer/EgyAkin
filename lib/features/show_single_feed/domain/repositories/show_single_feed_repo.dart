import 'package:egy_akin/features/show_single_feed/data/models/add_like_or_unlike_on_comment_in_community_model_response.dart';
import 'package:egy_akin/features/show_single_feed/data/models/create_comment_on_post_in_community_model_response.dart';
import 'package:egy_akin/features/show_single_feed/data/models/create_reply_on_comment_in_community_model_response.dart';
import 'package:egy_akin/features/show_single_feed/data/models/delete_comment_on_post_in_community_model_response.dart';

import '../../../../exports.dart';
import 'package:dartz/dartz.dart';

abstract class ShowSingleFeedRepository {
  Future<Either<Failure, GetCommentsInCommunityModelResponse>>
      getCommentsInCommunity({
    required String postId,
  });
  Future<Either<Failure, AddLikeOrUnlikeOnCommentInCommunityModelResponse>>
      addLikeOrUnlikeOnCommentInCommunity({
    required String commentId,
    required String status,
  });
  Future<Either<Failure, CreateCommentOnPostInCommunityModelResponse>>
      createCommentOnPostInCommunity({
    required String postId,
    required String comment,
    required int? parentId,
  });
  Future<Either<Failure, DeleteCommentOnPostInCommunityModelResponse>>
      deleteCommentOnPostInCommunity({
    required String commentId,
  });

  Future<Either<Failure, CreateReplyOnCommentInCommunityModelResponse>>
      createReplyOnCommentInCommunity({
    required String postId,
    required String comment,
    required int? parentId,
  });
}
