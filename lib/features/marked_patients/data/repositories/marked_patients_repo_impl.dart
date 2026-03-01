import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/marked_patients/data/datasources/marked_patients_datasource.dart';
import 'package:egy_akin/features/marked_patients/data/models/get_marked_patients_model_response.dart';
import 'package:egy_akin/features/marked_patients/domain/repositories/marked_patients_repo.dart';
import '../../../../exports.dart';

class MarkedPatientsRepositoryImpl extends MarkedPatientsRepository {
  final MarkedPatientsDataSource markedPatientsDataSource;
  final NetworkInfo networkInfo;

  MarkedPatientsRepositoryImpl(this.markedPatientsDataSource, this.networkInfo);

  @override
  Future<Either<Failure, GetMarkedPatientsModelResponse>> getMarkedPatients(
      int page) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response = await markedPatientsDataSource.getMarkedPatients(page);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }
}
