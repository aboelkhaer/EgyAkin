import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/group_details_in_community/data/datasources/group_details_in_community_datasource.dart';
import 'package:egy_akin/features/group_details_in_community/data/models/delete_group_in_community_model_response.dart';
import 'package:egy_akin/features/group_details_in_community/data/models/get_group_details_in_community_model_response.dart';
import 'package:egy_akin/features/group_details_in_community/data/models/leave_group_model_response.dart';
import 'package:egy_akin/features/group_details_in_community/domain/repositories/group_details_in_community_repo.dart';
import '../../../../exports.dart';

class GroupDetailsInCommunityRepositoryImpl
    extends GroupDetailsInCommunityRepository {
  final GroupDetailsInCommunityDatasource groupDetailsInCommunityDatasource;
  final NetworkInfo networkInfo;

  GroupDetailsInCommunityRepositoryImpl(
      this.groupDetailsInCommunityDatasource, this.networkInfo);

  @override
  Future<Either<Failure, GetGroupDetailsInCommunityModelResponse>>
      getGroupDetailsInCommunity(String groupId, int page) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response =
            await groupDetailsInCommunityDatasource.getGroupDetailsInCommunity(
          groupId,
          page,
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
  Future<Either<Failure, LeaveGroupModelResponse>> leaveGroupInCommunity(
      String groupId) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response = await groupDetailsInCommunityDatasource
            .leaveGroupInCommunity(groupId);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }

  @override
  Future<Either<Failure, DeleteGroupInCommunityModelResponse>>
      deleteGroupInCommunity(String groupId) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response = await groupDetailsInCommunityDatasource
            .deleteGroupInCommunity(groupId);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }
}
