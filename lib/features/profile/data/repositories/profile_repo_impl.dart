import 'dart:io';

import 'package:dartz/dartz.dart';

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
