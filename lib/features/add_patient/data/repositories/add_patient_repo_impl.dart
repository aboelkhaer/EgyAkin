import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class AddPatientRepositoryImpl extends AddPatientRepository {
  final AddPatientDataSource addPatientDataSource;
  final NetworkInfo networkInfo;

  AddPatientRepositoryImpl(this.addPatientDataSource, this.networkInfo);

  @override
  Future<Either<Failure, GetPatientHistoryForAddPatientModelResponse>>
      getPatientHistoryForAddPatient({
    required String sectionId,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await addPatientDataSource
            .getPatientHistoryForAddPatient(sectionId: sectionId);

        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }

  @override
  Future<Either<Failure, AddPatientForFirstTimeModelResponse>>
      addPatientForFirstTime({required Map<String, dynamic> map}) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await addPatientDataSource.addPatientForFirstTime(map: map);

        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }
}
