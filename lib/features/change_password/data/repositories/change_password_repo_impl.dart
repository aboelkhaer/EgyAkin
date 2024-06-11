import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/all_doctors_patients/data/models/get_all_doctors_patients_model_response.dart';
import 'package:egy_akin/features/change_password/data/datasources/change_password_datasource.dart';
import 'package:egy_akin/features/change_password/data/models/change_password_model_response.dart';
import 'package:egy_akin/features/change_password/domain/repositories/change_password_repo.dart';
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
