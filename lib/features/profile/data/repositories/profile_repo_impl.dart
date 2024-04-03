import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/profile/data/datasources/profile_datasource.dart';
import 'package:egy_akin/features/profile/data/models/sign_out_model_response.dart';
import 'package:egy_akin/features/profile/data/models/upload_profile_image_model_response.dart';
import 'package:egy_akin/features/profile/domain/repositories/profile_repo.dart';

import '../../../../exports.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final ProfileDataSource profileDataSource;
  final NetworkInfo networkInfo;

  ProfileRepositoryImpl(this.profileDataSource, this.networkInfo);

  @override
  Future<Either<Failure, UploadProfileImageModelResponse>> uploadProfileImage(
      {required File image}) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response =
            await profileDataSource.uploadProfileImage(image: image);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }

  @override
  Future<Either<Failure, SignOutModelResponse>> signOut() async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response = await profileDataSource.signOut();
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }
}
