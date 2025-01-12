import 'package:dartz/dartz.dart';

import '../../../../exports.dart';

class GetCommentsInCommunityUsecase
    implements BaseUseCase<String, GetCommentsInCommunityModelResponse> {
  final ShowSingleFeedRepository repository;

  GetCommentsInCommunityUsecase(this.repository);

  @override
  Future<Either<Failure, GetCommentsInCommunityModelResponse>> execute(
      String postId) async {
    return await repository.getCommentsInCommunity(postId: postId);
  }
}
