import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/community/data/models/delete_post_model_response.dart';
import 'package:egy_akin/features/community/domain/repositories/community_repo.dart';
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
