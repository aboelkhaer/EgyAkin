import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class ConsultationRepositoryImpl extends ConsultationRepository {
  final ConsultationDataSource consultationDataSource;
  final NetworkInfo networkInfo;

  ConsultationRepositoryImpl(this.consultationDataSource, this.networkInfo);

  @override
  Future<Either<Failure, List<GetCurrentDoctorConsultationModelResponse>>>
      getCurrentDoctorConsultation() async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response =
            await consultationDataSource.getCurrentDoctorConsultation();
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }

  @override
  Future<Either<Failure, List<GetCurrentDoctorConsultationModelResponse>>>
      getReceivedConsultation() async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response = await consultationDataSource.getReceivedConsultation();
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }
}
