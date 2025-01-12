import 'package:dartz/dartz.dart';
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
