import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/community/data/models/get_posts_community_model_response.dart';
import 'package:egy_akin/features/community/domain/repositories/community_repo.dart';
import '../../../../exports.dart';

class GetAllFeedsUsecase
    implements BaseUseCase<int, GetPostsCommunityModelResponse> {
  final CommunityRepository repository;

  GetAllFeedsUsecase(this.repository);

  @override
  Future<Either<Failure, GetPostsCommunityModelResponse>> execute(
      int page) async {
    return await repository.getAllFeeds(page);
  }
}
