import 'package:egy_akin/features/show_single_feed/data/models/get_post_by_id_model_response.dart';

import '../../../../exports.dart';
import 'package:dartz/dartz.dart';

abstract class ShowSingleFeedRepository {
  Future<Either<Failure, GetCommentsInCommunityModelResponse>>
      getCommentsInCommunity({
    required String postId,
    required int page,
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
  Future<Either<Failure, GetPostByIdModelResponse>> getPostById({
    required String postId,
  });
}
