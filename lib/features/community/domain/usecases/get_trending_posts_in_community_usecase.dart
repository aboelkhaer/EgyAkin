import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class GetTrendingPostsInCommunityUsecase
    implements BaseUseCase<int, GetTrendingTabInCommunityModelResponse> {
  final CommunityRepository repository;

  GetTrendingPostsInCommunityUsecase(this.repository);

  @override
  Future<Either<Failure, GetTrendingTabInCommunityModelResponse>> execute(
      int page) async {
    return await repository.getTrendingPostsInCommunity(page);
  }
}
