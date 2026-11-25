import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class CommunitySearchRepositoryImpl extends CommunitySearchRepository {
  final CommunitySearchDatasource communitySearchDatasource;
  final NetworkInfo networkInfo;

  CommunitySearchRepositoryImpl(
      this.communitySearchDatasource, this.networkInfo);

  @override
  Future<Either<Failure, GetResponseOfSearchModel>> getCommunitySearchResponse(
    int page,
    String searchContent,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response =
            await communitySearchDatasource.getCommunitySearchResponse(
          page,
          searchContent,
        );
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }
}
