import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class AllGroupsInCommunityRepositoryImpl
    extends AllGroupsInCommunityRepository {
  final AllGroupsInCommunityDatasource allGroupsInCommunityDatasource;
  final NetworkInfo networkInfo;

  AllGroupsInCommunityRepositoryImpl(
      this.allGroupsInCommunityDatasource, this.networkInfo);

  @override
  Future<Either<Failure, GetAllGroupsInCommunityModelResponse>> getMyGroups(
      int page) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response = await allGroupsInCommunityDatasource.getMyGroups(page);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }

  @override
  Future<Either<Failure, GetAllGroupsInCommunityModelResponse>> getAllGroups(
      int page) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response =
            await allGroupsInCommunityDatasource.getAllGroups(page);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }

  @override
  Future<Either<Failure, GetDoctorInvitationForGroupsModelResponse>>
      getDoctorInvitationsForGroups(String doctorId, int page) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response = await allGroupsInCommunityDatasource
            .getDoctorInvitationsForGroups(doctorId, page);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }
}
