import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class OutcomeRepositoryImpl extends OutcomeRepository {
  final OutcomeDataSource outcomeDataSource;
  final NetworkInfo networkInfo;

  OutcomeRepositoryImpl(this.outcomeDataSource, this.networkInfo);

  @override
  Future<Either<Failure, GetOutcomeModelResponse>> getOutcome(
      String sectionId, String patientId) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response =
            await outcomeDataSource.getOutcome(sectionId, patientId);
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
    String sectionId,
    Map<String, dynamic> map,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response = await outcomeDataSource.submitOutcome(
          patientId,
          sectionId,
          map,
        );
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }
}
