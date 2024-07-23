import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/doctor_info_view/data/models/doctor_info_view_model_response.dart';
import 'package:egy_akin/features/doctor_info_view/data/models/get_doctor_profile_score_history_model_response.dart';
import '../../../../exports.dart';

class DoctorInfoViewRepositoryImpl extends DoctorInfoViewRepository {
  final DoctorInfoViewDataSource doctorInfoViewDataSource;
  final NetworkInfo networkInfo;

  DoctorInfoViewRepositoryImpl(this.doctorInfoViewDataSource, this.networkInfo);

  @override
  Future<Either<Failure, DoctorInfoViewModelResponse>> getDoctorInfo(
      String doctorId) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response =
            await doctorInfoViewDataSource.getDoctorInfoView(doctorId);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }

  @override
  Future<Either<Failure, GetDoctorProfileScoreModelResponse>> getScoreHistory(
      {required int page, required String doctorId}) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response =
            await doctorInfoViewDataSource.getScoreHistory(page, doctorId);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }
}
