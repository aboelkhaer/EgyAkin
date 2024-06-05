import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/all_doctors_patients/data/datasources/all_doctors_patients_datasource.dart';
import 'package:egy_akin/features/all_doctors_patients/data/models/get_all_doctors_patients_model_response.dart';
import 'package:egy_akin/features/all_doctors_patients/domain/repositories/all_doctors_patients_repo.dart';
import '../../../../exports.dart';

class AllDoctorsPatientsRepositoryImpl extends AllDoctorsPatientsRepository {
  final AllDoctorsPatientsDataSource allDoctorsPatientsDataSource;
  final NetworkInfo networkInfo;

  AllDoctorsPatientsRepositoryImpl(
      this.allDoctorsPatientsDataSource, this.networkInfo);

  @override
  Future<Either<Failure, GetAllDoctorsPatientsModelResponse>>
      getAllDoctorsPatients(int page) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response =
            await allDoctorsPatientsDataSource.getAllDoctorPatients(page);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }
}
