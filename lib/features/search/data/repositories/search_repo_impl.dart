import 'package:dartz/dartz.dart';

import '../../../../exports.dart';

class SearchRepositoryImpl extends SearchRepository {
  final SearchDataSource searchDataSource;
  final NetworkInfo networkInfo;

  SearchRepositoryImpl(this.searchDataSource, this.networkInfo);

  @override
  Future<Either<Failure, GetSearchModelResponse>> getSearchHome(
      {required String searchContent, required int page}) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response = await searchDataSource.getSearchHome(
            searchContent: searchContent, page: page);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }
}
