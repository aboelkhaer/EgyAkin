import 'package:dartz/dartz.dart';

import '../../../../exports.dart';

class EmailVerificationRepositoryImpl extends EmailVerificationRepository {
  final EmailVerificationDataSource emailVerificationDataSource;
  final NetworkInfo networkInfo;

  EmailVerificationRepositoryImpl(
      this.emailVerificationDataSource, this.networkInfo);

  @override
  Future<Either<Failure, SendEmailForVerificationModelResponse>>
      sendEmailForVerification() async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response =
            await emailVerificationDataSource.sendEmailForVerification();
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }

  @override
  Future<Either<Failure, SendOTPForEmailVerificationModelResponse>>
      sendOTPForEmailVerification(String otp) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response =
            await emailVerificationDataSource.sendOTPForEmailVerification(otp);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }
}
