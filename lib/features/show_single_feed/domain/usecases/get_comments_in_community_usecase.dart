import 'package:dartz/dartz.dart';

import '../../../../exports.dart';

class GetCommentsInCommunityUsecase
    implements
        BaseUseCase<GetCommentsInCommunityUsecaseInput,
            GetCommentsInCommunityModelResponse> {
  final ShowSingleFeedRepository repository;

  GetCommentsInCommunityUsecase(this.repository);

  @override
  Future<Either<Failure, GetCommentsInCommunityModelResponse>> execute(
      GetCommentsInCommunityUsecaseInput input) async {
    return await repository.getCommentsInCommunity(
      postId: input.postId,
      page: input.page,
    );
  }
}

class GetCommentsInCommunityUsecaseInput {
  final String postId;
  final int page;

  GetCommentsInCommunityUsecaseInput(
      {required this.postId, required this.page});
}
