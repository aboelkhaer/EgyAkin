import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/community/data/models/get_trending_tab_in_community_model_response.dart';
import '../../../../exports.dart';

class GetTrendingPostsInCommunityUsecase
    implements BaseUseCase<NoParams, GetTrendingTabInCommunityModelResponse> {
  final CommunityRepository repository;

  GetTrendingPostsInCommunityUsecase(this.repository);

  @override
  Future<Either<Failure, GetTrendingTabInCommunityModelResponse>> execute(
      NoParams input) async {
    return await repository.getTrendingPostsInCommunity();
  }
}
