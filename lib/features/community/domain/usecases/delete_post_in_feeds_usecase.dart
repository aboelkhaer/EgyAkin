import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class DeletePostInFeedsUsecase
    implements BaseUseCase<String, DeletePostModelResponse> {
  final CommunityRepository repository;

  DeletePostInFeedsUsecase(this.repository);

  @override
  Future<Either<Failure, DeletePostModelResponse>> execute(
    String postId,
  ) async {
    return await repository.deletePostInFeeds(postId: postId);
  }
}
