import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/consultation_details/data/datasources/consultation_details_datasource.dart';
import '../../../../exports.dart';

class ConsultationDetailsRepositoryImpl extends ConsultationDetailsRepository {
  final ConsultationDetailsDataSource consultationDetailsDataSource;
  final NetworkInfo networkInfo;

  ConsultationDetailsRepositoryImpl(
      this.consultationDetailsDataSource, this.networkInfo);

  @override
  Future<Either<Failure, List<GetConsultationDetailsModelResponse>>>
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
}
