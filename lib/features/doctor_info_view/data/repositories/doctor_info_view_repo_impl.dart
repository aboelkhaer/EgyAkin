import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/doctor_info_view/data/models/block_user_model_response.dart';
import 'package:egy_akin/features/doctor_info_view/data/models/verify_user_email_model_response.dart';
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

  @override
  Future<Either<Failure, List<GetAchievementsModelResponse>>> getAchievements(
      String doctorId) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response =
            await doctorInfoViewDataSource.getAchievements(doctorId);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }

  @override
  Future<Either<Failure, SyndicateCardVerifyModelResponse>>
      changeSyndicateCardStatus(
          {required String status, required String doctorId}) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response = await doctorInfoViewDataSource
            .changeSyndicateCardStatus(status: status, doctorId: doctorId);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }

  @override
  Future<Either<Failure, BlockUserModelResponse>> blockUser(
      {required bool status, required String doctorId}) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response = await doctorInfoViewDataSource.blockUser(
            status: status, doctorId: doctorId);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }

  @override
  Future<Either<Failure, VerifyUserEmailModelResponse>> verifyDoctorEmail(
      {required String doctorId, required String? timestamp}) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response = await doctorInfoViewDataSource.verifyDoctorEmail(
            timestamp: timestamp, doctorId: doctorId);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }
}
