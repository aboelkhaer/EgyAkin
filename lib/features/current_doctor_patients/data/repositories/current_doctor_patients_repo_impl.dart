import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class CurrentDoctorPatientsRepositoryImpl
    extends CurrentDoctorPatientsRepository {
  final CurrentDoctorPatientsDataSource currentDoctorPatientsDataSource;
  final NetworkInfo networkInfo;

  CurrentDoctorPatientsRepositoryImpl(
      this.currentDoctorPatientsDataSource, this.networkInfo);

  @override
  Future<Either<Failure, GetDoctorPatientsModelResponse>>
      getCurrentDoctorPatients(int page) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response = await currentDoctorPatientsDataSource
            .getCurrentDoctorPatients(page);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }
}
