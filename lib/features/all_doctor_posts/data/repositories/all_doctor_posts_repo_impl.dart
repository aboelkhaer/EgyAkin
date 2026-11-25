import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class AllDoctorPostsRepositoryImpl extends AllDoctorPostsRepository {
  final AllDoctorPostsDatasource allDoctorPostsDatasource;
  final NetworkInfo networkInfo;

  AllDoctorPostsRepositoryImpl(this.allDoctorPostsDatasource, this.networkInfo);

  @override
  Future<Either<Failure, GetAllDoctorPostsModelResponse>> getAllDoctorPosts(
      String doctorId, int page) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response =
            await allDoctorPostsDatasource.getAllDoctorPosts(doctorId, page);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }
}
