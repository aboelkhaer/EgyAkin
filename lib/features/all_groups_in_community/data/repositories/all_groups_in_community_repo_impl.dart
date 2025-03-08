import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/all_doctors_patients/data/models/apply_patient_filters_model_response.dart';
import 'package:egy_akin/features/all_groups_in_community/data/datasources/all_groups_in_community_datasource.dart';
import 'package:egy_akin/features/all_groups_in_community/data/models/get_all_groups_in_community_model_response.dart';
import 'package:egy_akin/features/all_groups_in_community/domain/repositories/all_groups_in_community_repo.dart';
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
}
