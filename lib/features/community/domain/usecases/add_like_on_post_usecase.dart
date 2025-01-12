import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/community/data/models/add_like_on_post_model_response.dart';
import '../../../../exports.dart';

class AddLikeOnPostUsecase
    implements
        BaseUseCase<AddLikeOnPostUsecaseInput, AddLikeOnPostModelResponse> {
  final CommunityRepository repository;

  AddLikeOnPostUsecase(this.repository);

  @override
  Future<Either<Failure, AddLikeOnPostModelResponse>> execute(
    AddLikeOnPostUsecaseInput input,
  ) async {
    return await repository.addLikeOrUnlikeOnPost(
      postId: input.postId,
      likeOrUnlike: input.likeOrUnlike,
    );
  }
}

class AddLikeOnPostUsecaseInput {
  final String postId;
  final String likeOrUnlike;

  AddLikeOnPostUsecaseInput({
    required this.postId,
    required this.likeOrUnlike,
  });
}
