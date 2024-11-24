import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class SplashRepositoryImpl extends SplashRepository {
  final SplashDataSource splashDataSource;
  final NetworkInfo networkInfo;

  SplashRepositoryImpl(this.splashDataSource, this.networkInfo);

  @override
  Future<Either<Failure, GetAppSettingsModelResponse>> getAppSettings() async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response = await splashDataSource.getAppSettings();
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }
}
