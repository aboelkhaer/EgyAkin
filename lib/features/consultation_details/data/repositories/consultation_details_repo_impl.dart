import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/consultation_details/data/models/lock_or_unlock_consultation_model_response.dart';
import '../../../../exports.dart';

class ConsultationDetailsRepositoryImpl extends ConsultationDetailsRepository {
  final ConsultationDetailsDataSource consultationDetailsDataSource;
  final NetworkInfo networkInfo;

  ConsultationDetailsRepositoryImpl(
      this.consultationDetailsDataSource, this.networkInfo);

  @override
  Future<Either<Failure, GetConsultationDetailsModelResponse>>
      getConsultationDetails(String consultationId) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response = await consultationDetailsDataSource
            .getConsultationDetails(consultationId);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }

  @override
  Future<Either<Failure, AddConsultationReplyModelResponse>>
      addConsultationReply(
          {required String consultationId, required String reply}) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response = await consultationDetailsDataSource
            .addConsultationReply(consultationId: consultationId, reply: reply);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }

   @override
  Future<Either<Failure, LockOrUnlockConsultationModelResponse>>
      lockOrUnlockConsultation(
          String consultationId, bool isOpen) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response = await consultationDetailsDataSource
            .lockOrUnlockConsultation(consultationId, isOpen);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }


 
}
