import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/community_search/data/models/get_response_of_search_model.dart';
import 'package:egy_akin/features/community_search/domain/repositories/community_search_repo.dart';
import '../../../../exports.dart';

class GetResponseOfSearchInCommunityUsecase
    implements BaseUseCase<String, GetResponseOfSearchModel> {
  final CommunitySearchRepository repository;

  GetResponseOfSearchInCommunityUsecase(this.repository);

  @override
  Future<Either<Failure, GetResponseOfSearchModel>> execute(
    String searchContent,
  ) async {
    return await repository.getCommunitySearchResponse(searchContent);
  }
}
