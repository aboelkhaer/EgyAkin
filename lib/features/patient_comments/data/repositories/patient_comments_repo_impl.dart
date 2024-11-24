import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class PatientCommentsRepositoryImpl extends PatientCommentsRepository {
  final PatientCommentsDataSource patientCommentsDataSource;
  final NetworkInfo networkInfo;

  PatientCommentsRepositoryImpl(
      this.patientCommentsDataSource, this.networkInfo);

  @override
  Future<Either<Failure, GetPatientCommentsModelResponse>> getPatientComments(
      String patientId) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response =
            await patientCommentsDataSource.getPatientComments(patientId);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }

  @override
  Future<Either<Failure, AddPatientCommentsModelResponse>> addPatientComments(
      String patientId, String content) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response = await patientCommentsDataSource.addPatientComments(
            patientId, content);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }

  @override
  Future<Either<Failure, DeletePatientCommentsModelResponse>>
      deletePatientComments(String commentId) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response =
            await patientCommentsDataSource.deletePatientComments(commentId);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }
}
