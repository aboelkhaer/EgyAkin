import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/saved_posts/data/datasources/saved_posts_datasource.dart';
import 'package:egy_akin/features/saved_posts/data/models/get_saved_posts_model_response.dart';
import 'package:egy_akin/features/saved_posts/domain/repositories/saved_posts_repo.dart';

import '../../../../exports.dart';

class SavedPostsRepositoryImpl extends SavedPostsRepository {
  final SavedPostsDataSource savedPostsDataSource;
  final NetworkInfo networkInfo;

  SavedPostsRepositoryImpl(this.savedPostsDataSource, this.networkInfo);

  @override
  Future<Either<Failure, GetSavedPostsModelResponse>> getSavedPosts(
      String doctorId, int page) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response =
            await savedPostsDataSource.getSavedPosts(doctorId, page);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }
}
