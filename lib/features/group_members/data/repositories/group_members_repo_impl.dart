import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/group_members/data/datasources/group_members_datasource.dart';
import 'package:egy_akin/features/group_members/data/models/get_group_members_model_response.dart';
import 'package:egy_akin/features/group_members/data/models/remove_member_from_group_model_response.dart';
import 'package:egy_akin/features/group_members/domain/repositories/group_members_repo.dart';
import '../../../../exports.dart';

class GroupMembersRepositoryImpl extends GroupMembersRepository {
  final GroupMembersDatasource groupMembersDatasource;
  final NetworkInfo networkInfo;

  GroupMembersRepositoryImpl(this.groupMembersDatasource, this.networkInfo);

  @override
  Future<Either<Failure, GetGroupMembersModelResponse>> getGroupMembers(
      String groupId, int pageNumber) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response =
            await groupMembersDatasource.getGroupMembers(groupId, pageNumber);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }

  @override
  Future<Either<Failure, GetGroupMembersModelResponse>> getPostLikes(
      String postId, int pageNumber) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response =
            await groupMembersDatasource.getPostLikes(postId, pageNumber);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }

  @override
  Future<Either<Failure, RemoveMemberFromGroupModelResponse>>
      removeMemberFromGroup(String groupId, String doctorId) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response = await groupMembersDatasource.removeMemberFromGroup(
            groupId, doctorId);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }
}
