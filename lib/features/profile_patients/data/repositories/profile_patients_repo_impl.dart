import 'package:dartz/dartz.dart';

import '../../../../exports.dart';

class ProfilePatientsRepositoryImpl extends ProfilePatientsRepository {
  final ProfilePatientsDataSource profilePatientsDataSource;
  final NetworkInfo networkInfo;

  ProfilePatientsRepositoryImpl(
      this.profilePatientsDataSource, this.networkInfo);

  @override
  Future<Either<Failure, GetProfilePatientsModelResponse>> getProfilePatients(
      {required int page, required String doctorId}) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response = await profilePatientsDataSource.getProfilePatients(
            pageNumber: page, doctorId: doctorId);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }
}
