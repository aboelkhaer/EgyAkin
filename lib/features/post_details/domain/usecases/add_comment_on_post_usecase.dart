import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/post_details/data/models/add_comment_on_post_model_response.dart';
import '../../../../exports.dart';

class AddCommentOnPostUsecase
    implements
        BaseUseCase<AddCommentOnPostUseCaseInput,
            AddCommentOnPostModelResponse> {
  final PostDetailsRepository repository;

  AddCommentOnPostUsecase(this.repository);

  @override
  Future<Either<Failure, AddCommentOnPostModelResponse>> excute(
      AddCommentOnPostUseCaseInput input) async {
    return await repository.addCommentOnPost(input.postId, input.content);
  }
}

class AddCommentOnPostUseCaseInput {
  final String postId;
  final String content;

  AddCommentOnPostUseCaseInput({required this.postId, required this.content});
}
