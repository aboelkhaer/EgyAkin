import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/outcome/data/models/sumbit_outcome_model_response.dart';
import '../../../../exports.dart';

class OutcomeRepositoryImpl extends OutcomeRepository {
  final OutcomeDataSource outcomeDataSource;
  final NetworkInfo networkInfo;

  OutcomeRepositoryImpl(this.outcomeDataSource, this.networkInfo);

  @override
  Future<Either<Failure, GetOutcomeModelResponse>> getOutcome(
      String patientId) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response = await outcomeDataSource.getOutcome(patientId);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }

  @override
  Future<Either<Failure, SubmitOutcomeModelResponse>> submitOutcome(
      String patientId,
      String outcomeOfThePatient,
      String creatinineOnDischarge,
      String durationField,
      String finalStatus,
      String other) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response = await outcomeDataSource.submitOutcome(
            patientId,
            outcomeOfThePatient,
            creatinineOnDischarge,
            durationField,
            finalStatus,
            other);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }
}
