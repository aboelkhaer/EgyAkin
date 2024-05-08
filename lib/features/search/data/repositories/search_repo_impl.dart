import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/search/data/datasources/search_datasourch.dart';
import 'package:egy_akin/features/search/domain/repositories/search_repo.dart';
import '../../../../exports.dart';

class SearchRepositoryImpl extends SearchRepository {
  final SearchDataSource searchDataSource;
  final NetworkInfo networkInfo;

  SearchRepositoryImpl(this.searchDataSource, this.networkInfo);

  @override
  Future<Either<Failure, GetSearchModelResponse>> getSearchHome(
      {required String searchContent}) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response =
            await searchDataSource.getSearchHome(searchContent: searchContent);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }
}
