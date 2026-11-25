import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class GetResponseOfSearchInCommunityUsecase
    implements
        BaseUseCase<GetResponseOfSearchInCommunityUsecaseInput,
            GetResponseOfSearchModel> {
  final CommunitySearchRepository repository;

  GetResponseOfSearchInCommunityUsecase(this.repository);

  @override
  Future<Either<Failure, GetResponseOfSearchModel>> execute(
    GetResponseOfSearchInCommunityUsecaseInput input,
  ) async {
    return await repository.getCommunitySearchResponse(
        input.page, input.searchContent);
  }
}

class GetResponseOfSearchInCommunityUsecaseInput {
  final int page;
  final String searchContent;

  GetResponseOfSearchInCommunityUsecaseInput(
      {required this.page, required this.searchContent});
}
