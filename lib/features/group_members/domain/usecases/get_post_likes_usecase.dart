import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/group_members/data/models/get_group_members_model_response.dart';
import 'package:egy_akin/features/group_members/domain/repositories/group_members_repo.dart';
import '../../../../exports.dart';

class GetPostLikesUsecase
    implements
        BaseUseCase<GetPostLikesUsecaseInput, GetGroupMembersModelResponse> {
  final GroupMembersRepository repository;

  GetPostLikesUsecase(this.repository);

  @override
  Future<Either<Failure, GetGroupMembersModelResponse>> execute(
      GetPostLikesUsecaseInput input) async {
    return await repository.getPostLikes(input.postId, input.pageNumber);
  }
}

class GetPostLikesUsecaseInput {
  final String postId;
  final int pageNumber;

  GetPostLikesUsecaseInput({
    required this.postId,
    required this.pageNumber,
  });
}
