import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class ConsultationFromAIRepositoryImpl extends ConsultationFromAIRepository {
  final ConsultationFromAIDatasource consultationFromAIDatasource;
  final NetworkInfo networkInfo;

  ConsultationFromAIRepositoryImpl(
      this.consultationFromAIDatasource, this.networkInfo);

  @override
  Future<Either<Failure, GetAiConsultationHistoryModelResponse>>
      getAIConsultationHistory({
    required String patientId,
    required int page,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await consultationFromAIDatasource.getAIConsultationHistory(
          patientId: patientId,
          page: page,
        );

        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }

  @override
  Future<Either<Failure, SendAIConsultationRequestModelResponse>>
      sendAIConsultationRequest({required String patientId}) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await consultationFromAIDatasource.sendAIConsultationRequest(
          patientId: patientId,
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
