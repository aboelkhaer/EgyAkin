import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class ResetPasswordRepositoryImpl extends ResetPasswordRepository {
  final ResetPasswordDataSource resetPasswordDataSource;
  final NetworkInfo networkInfo;

  ResetPasswordRepositoryImpl(this.resetPasswordDataSource, this.networkInfo);

  @override
  Future<Either<Failure, ResetPasswordModelResponse>> sendEmailForResetPassword(
      {required String email}) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response = await resetPasswordDataSource
            .sendEmailForResetPassword(email: email);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }

  @override
  Future<Either<Failure, ResetPasswordModelResponse>> verifyOTPForResetPassword(
      {required String email, required String otp}) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response = await resetPasswordDataSource
            .verifyOTPForResetPassword(email: email, otp: otp);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }

  @override
  Future<Either<Failure, ResetPasswordModelResponse>>
      changePasswordForResetPassword({
    required String email,
    required String password,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response = await resetPasswordDataSource
            .changePasswordForResetPassword(email: email, password: password);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }
}
