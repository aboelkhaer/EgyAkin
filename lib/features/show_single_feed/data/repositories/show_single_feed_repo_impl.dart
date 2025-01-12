import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/show_single_feed/data/models/add_like_or_unlike_on_comment_in_community_model_response.dart';
import 'package:egy_akin/features/show_single_feed/data/models/create_comment_on_post_in_community_model_response.dart';
import 'package:egy_akin/features/show_single_feed/data/models/create_reply_on_comment_in_community_model_response.dart';
import 'package:egy_akin/features/show_single_feed/data/models/delete_comment_on_post_in_community_model_response.dart';

import '../../../../exports.dart';

class ShowSingleFeedRepositoryImpl extends ShowSingleFeedRepository {
  final ShowSingleFeedDatasource showSingleFeedDatasource;
  final NetworkInfo networkInfo;

  ShowSingleFeedRepositoryImpl(this.showSingleFeedDatasource, this.networkInfo);

  @override
  Future<Either<Failure, GetCommentsInCommunityModelResponse>>
      getCommentsInCommunity({required String postId}) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response = await showSingleFeedDatasource.getCommentsInCommunity(
            postId: postId);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }

  @override
  Future<Either<Failure, AddLikeOrUnlikeOnCommentInCommunityModelResponse>>
      addLikeOrUnlikeOnCommentInCommunity(
          {required String commentId, required String status}) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response =
            await showSingleFeedDatasource.addLikeOrUnlikeOnCommentInCommunity(
                commentId: commentId, status: status);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }

  @override
  Future<Either<Failure, CreateCommentOnPostInCommunityModelResponse>>
      createCommentOnPostInCommunity({
    required String postId,
    required String comment,
    required int? parentId,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response =
            await showSingleFeedDatasource.createCommentOnPostInCommunity(
          postId: postId,
          comment: comment,
          parentId: parentId,
        );
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }

  @override
  Future<Either<Failure, DeleteCommentOnPostInCommunityModelResponse>>
      deleteCommentOnPostInCommunity({required String commentId}) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response = await showSingleFeedDatasource
            .deleteCommentOnPostInCommunity(commentId: commentId);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }

  @override
  Future<Either<Failure, CreateReplyOnCommentInCommunityModelResponse>>
      createReplyOnCommentInCommunity(
          {required String postId,
          required String comment,
          required int? parentId}) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response =
            await showSingleFeedDatasource.createReplyOnCommentInCommunity(
                postId: postId, comment: comment, parentId: parentId);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }
}
