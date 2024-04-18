import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class GetPostCommentsUsecase
    implements BaseUseCase<String, PostCommentsModelResponse> {
  final PostDetailsRepository repository;

  GetPostCommentsUsecase(this.repository);

  @override
  Future<Either<Failure, PostCommentsModelResponse>> excute(
      String postId) async {
    return await repository.getPostComments(postId);
  }
}
