import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/doctor_profile_view/data/datasources/doctor_profile_view_datasource.dart';
import 'package:egy_akin/features/doctor_profile_view/data/models/update_doctor_profile_model_response.dart';
import 'package:egy_akin/features/doctor_profile_view/domain/repositories/doctor_profile_view_repo.dart';
import '../../../../exports.dart';

class DoctorProfileViewRepositoryImpl extends DoctorProfileViewRepository {
  final DoctorProfileViewDataSource doctorProfileViewDataSource;
  final NetworkInfo networkInfo;

  DoctorProfileViewRepositoryImpl(
      this.doctorProfileViewDataSource, this.networkInfo);

  @override
  Future<Either<Failure, UpdateDoctorProfileModelResponse>> updateDoctorProfile(
      {required String firstName,
      required String lastName,
      required String email,
      required String phone,
      required String age,
      required String job,
      required String workplace,
      required String registerationNumber,
      required String specialty,
      required String highestDegree}) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response = await doctorProfileViewDataSource.updateDoctorProfile(
            firstName: firstName,
            lastName: lastName,
            email: email,
            phone: phone,
            age: age,
            job: job,
            workplace: workplace,
            registerationNumber: registerationNumber,
            specialty: specialty,
            highestDegree: highestDegree);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }
}
