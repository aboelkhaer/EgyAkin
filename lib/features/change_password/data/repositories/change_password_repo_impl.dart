import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class ChangePasswordRepositoryImpl extends ChangePasswordRepository {
  final ChangePasswordDataSource changePasswordDataSource;
  final NetworkInfo networkInfo;

  ChangePasswordRepositoryImpl(this.changePasswordDataSource, this.networkInfo);

  @override
  Future<Either<Failure, ChangePasswordModelResponse>> changePassword(
      {required String oldPassword, required String newPassword}) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response = await changePasswordDataSource.changePassword(
            oldPassword: oldPassword, newPassword: newPassword);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }
}
