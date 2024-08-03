import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class AddCommentOnPostUsecase
    implements
        BaseUseCase<AddCommentOnPostUseCaseInput,
            AddCommentOnPostModelResponse> {
  final PostDetailsRepository repository;

  AddCommentOnPostUsecase(this.repository);

  @override
  Future<Either<Failure, AddCommentOnPostModelResponse>> execute(
      AddCommentOnPostUseCaseInput input) async {
    return await repository.addCommentOnPost(input.postId, input.content);
  }
}

class AddCommentOnPostUseCaseInput {
  final String postId;
  final String content;

  AddCommentOnPostUseCaseInput({required this.postId, required this.content});
}
