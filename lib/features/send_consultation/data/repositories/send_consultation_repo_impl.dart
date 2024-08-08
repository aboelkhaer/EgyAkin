import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/send_consultation/data/datasources/send_consultation_datasource.dart';
import 'package:egy_akin/features/send_consultation/data/models/get_consultation_search_model_response.dart';
import 'package:egy_akin/features/send_consultation/data/models/send_consultation_model_response.dart';
import 'package:egy_akin/features/send_consultation/domain/repositories/send_consultation_repo.dart';

import '../../../../exports.dart';

class SendConsultationRepositoryImpl extends SendConsultationRepository {
  final SendConsultationDataSource sendConsultationDataSource;
  final NetworkInfo networkInfo;

  SendConsultationRepositoryImpl(
      this.sendConsultationDataSource, this.networkInfo);

  @override
  Future<Either<Failure, GetConsultationSearchModelResponse>>
      consultationDoctorSearch({required String searchContent}) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response = await sendConsultationDataSource
            .consultationDoctorSearch(searchContent: searchContent);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }

  @override
  Future<Either<Failure, SendConsultationModelResponse>> sendConsultation({
    required String patientId,
    required String message,
    required List<String> doctorsIDS,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response = await sendConsultationDataSource.sendConsultation(
            patientId: patientId, message: message, doctorsIDS: doctorsIDS);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }
}
