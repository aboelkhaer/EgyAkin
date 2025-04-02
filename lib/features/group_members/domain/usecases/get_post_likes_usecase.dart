import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/group_members/data/models/get_post_likes_model_response.dart';
import '../../../../exports.dart';

class GetPostLikesUsecase
    implements
        BaseUseCase<GetPostLikesUsecaseInput, GetPostLikesModelResponse> {
  final GroupMembersRepository repository;

  GetPostLikesUsecase(this.repository);

  @override
  Future<Either<Failure, GetPostLikesModelResponse>> execute(
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
