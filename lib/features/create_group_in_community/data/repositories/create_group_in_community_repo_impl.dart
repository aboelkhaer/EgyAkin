import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/create_group_in_community/data/datasources/create_group_in_community_datasource.dart';
import 'package:egy_akin/features/create_group_in_community/data/models/create_group_in_community_model_response.dart';
import 'package:egy_akin/features/create_group_in_community/data/models/update_group_in_community_model_response.dart';
import 'package:egy_akin/features/create_group_in_community/domain/repositories/create_group_in_community_repo.dart';
import '../../../../exports.dart';

class CreateGroupInCommunityRepositoryImpl
    extends CreateGroupInCommunityRepository {
  final CreateGroupInCommunityDatasource createGroupInCommunityDatasource;
  final NetworkInfo networkInfo;

  CreateGroupInCommunityRepositoryImpl(
      this.createGroupInCommunityDatasource, this.networkInfo);

  @override
  Future<Either<Failure, CreateGroupInCommunityModelResponse>>
      createGroupInCommunity(File? headerImage, File? groupImage, String name,
          String? description, String privacy) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response =
            await createGroupInCommunityDatasource.createGroupInCommunity(
                headerImage, groupImage, name, description, privacy);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }

  @override
  Future<Either<Failure, UpdateGroupInCommunityModelResponse>>
      updateGroupHeaderImageInCommunity(String groupId, File? headerImage,
          String name, String? description, String privacy) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response = await createGroupInCommunityDatasource
            .updateGroupHeaderImageInCommunity(
                groupId, headerImage, name, description, privacy);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }

  @override
  Future<Either<Failure, UpdateGroupInCommunityModelResponse>>
      updateGroupImageInCommunity(String groupId, File? groupImage, String name,
          String? description, String privacy) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response =
            await createGroupInCommunityDatasource.updateGroupImageInCommunity(
                groupId, groupImage, name, description, privacy);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }

  @override
  Future<Either<Failure, UpdateGroupInCommunityModelResponse>>
      updateGroupTextsInCommunity(String groupId, String name,
          String? description, String privacy) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response = await createGroupInCommunityDatasource
            .updateGroupTextsInCommunity(groupId, name, description, privacy);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }
}
