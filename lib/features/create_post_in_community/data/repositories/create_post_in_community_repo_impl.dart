import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/create_post_in_community/data/datasources/create_post_in_community_datasource.dart';
import 'package:egy_akin/features/create_post_in_community/data/models/create_post_in_community_model_response.dart';
import 'package:egy_akin/features/create_post_in_community/domain/repositories/create_post_in_community_repo.dart';
import '../../../../exports.dart';

class CreatePostInCommunityRepositoryImpl
    extends CreatePostInCommunityRepository {
  final CreatePostInCommunityDatasource createPostInCommunityDatasource;
  final NetworkInfo networkInfo;

  CreatePostInCommunityRepositoryImpl(
      this.createPostInCommunityDatasource, this.networkInfo);

  @override
  Future<Either<Failure, CreatePostInCommunityModelResponse>>
      createPostWithImageInCommunity(
          {required File image,
          required String? postContent,
          required String mediaType,
          required String visibility,
          required String? groupId}) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response = await createPostInCommunityDatasource
            .createPostWithImageInCommunity(
          image: image,
          postContent: postContent,
          mediaType: mediaType,
          visibility: visibility,
          groupId: groupId,
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
  Future<Either<Failure, CreatePostInCommunityModelResponse>>
      createPostWithTextInCommunity(
          {required String postContent,
          required String mediaType,
          required String visibility,
          required String? groupId}) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response =
            await createPostInCommunityDatasource.createPostWithTextInCommunity(
          postContent: postContent,
          mediaType: mediaType,
          visibility: visibility,
          groupId: groupId,
        );
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }
}
