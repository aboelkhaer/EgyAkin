import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/post_details/data/models/add_comment_on_post_model_response.dart';
import '../../../../exports.dart';

class PostDetailsRepositoryImpl extends PostDetailsRepository {
  final PostDetailsDataSource postDetailsDataSource;
  final NetworkInfo networkInfo;

  PostDetailsRepositoryImpl(this.postDetailsDataSource, this.networkInfo);

  @override
  Future<Either<Failure, PostCommentsModelResponse>> getPostComments(
      String postId) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response = await postDetailsDataSource.getPostComments(postId);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }

  @override
  Future<Either<Failure, DeletePostCommentModelResponse>> deletePostComment(
      String commentId) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response =
            await postDetailsDataSource.deletePostComment(commentId);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }

  @override
  Future<Either<Failure, AddCommentOnPostModelResponse>> addCommentOnPost(
      String postId, String content) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response =
            await postDetailsDataSource.addCommentOnPost(postId, content);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }
}
