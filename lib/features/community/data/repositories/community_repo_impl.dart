import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/community/data/models/add_like_on_post_model_response.dart';
import 'package:egy_akin/features/community/data/models/delete_post_model_response.dart';
import 'package:egy_akin/features/community/data/models/save_or_unsave_post_model_response.dart';
import '../../../../exports.dart';

class CommunityRepositoryImpl extends CommunityRepository {
  final CommunityDatasource communityDatasource;
  final NetworkInfo networkInfo;

  CommunityRepositoryImpl(this.communityDatasource, this.networkInfo);

  @override
  Future<Either<Failure, GetPostsCommunityModelResponse>> getAllFeeds(
      int page) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response = await communityDatasource.getAllFeeds(page);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }

  @override
  Future<Either<Failure, AddLikeOnPostModelResponse>> addLikeOrUnlikeOnPost(
      {required String postId, required String likeOrUnlike}) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response = await communityDatasource.addLikeOrUnlikeOnPost(
            postId, likeOrUnlike);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }

  @override
  Future<Either<Failure, SaveOrUnsavePostModelResponse>> saveOrUnsavePost(
      {required String postId, required String saveOrUnsave}) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response = await communityDatasource.saveOrUnsavePost(
            postId: postId, saveOrUnsave: saveOrUnsave);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }

  @override
  Future<Either<Failure, DeletePostModelResponse>> deletePostInFeeds(
      {required String postId}) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response =
            await communityDatasource.deletePostInFeeds(postId: postId);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }
}
