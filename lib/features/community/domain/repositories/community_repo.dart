import 'package:egy_akin/features/community/data/models/add_like_on_post_model_response.dart';
import 'package:egy_akin/features/community/data/models/delete_post_model_response.dart';
import 'package:egy_akin/features/community/data/models/get_posts_community_model_response.dart';
import 'package:egy_akin/features/community/data/models/save_or_unsave_post_model_response.dart';

import '../../../../exports.dart';
import 'package:dartz/dartz.dart';

abstract class CommunityRepository {
  Future<Either<Failure, GetPostsCommunityModelResponse>> getAllFeeds(int page);
  Future<Either<Failure, AddLikeOnPostModelResponse>> addLikeOrUnlikeOnPost({
    required String postId,
    required String likeOrUnlike,
  });

  Future<Either<Failure, SaveOrUnsavePostModelResponse>> saveOrUnsavePost({
    required String postId,
    required String saveOrUnsave,
  });
  Future<Either<Failure, DeletePostModelResponse>> deletePostInFeeds({
    required String postId,
  });
}
