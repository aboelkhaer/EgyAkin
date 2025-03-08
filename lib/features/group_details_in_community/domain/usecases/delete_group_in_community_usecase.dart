import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/group_details_in_community/data/models/delete_group_in_community_model_response.dart';
import 'package:egy_akin/features/group_details_in_community/domain/repositories/group_details_in_community_repo.dart';
import '../../../../exports.dart';

class DeleteGroupInCommunityUsecase
    implements BaseUseCase<String, DeleteGroupInCommunityModelResponse> {
  final GroupDetailsInCommunityRepository repository;

  DeleteGroupInCommunityUsecase(this.repository);

  @override
  Future<Either<Failure, DeleteGroupInCommunityModelResponse>> execute(
      String groupId) async {
    return await repository.deleteGroupInCommunity(groupId);
  }
}
