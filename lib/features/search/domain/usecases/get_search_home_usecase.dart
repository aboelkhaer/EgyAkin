import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/search/domain/repositories/search_repo.dart';
import '../../../../exports.dart';

class GetSearchHomeUsecase
    implements BaseUseCase<GetSearchHomeUsecaseInput, GetSearchModelResponse> {
  final SearchRepository repository;

  GetSearchHomeUsecase(this.repository);

  @override
  Future<Either<Failure, GetSearchModelResponse>> excute(
      GetSearchHomeUsecaseInput input) async {
    return await repository.getSearchHome(
        searchContent: input.searchContent, page: input.page);
  }
}

class GetSearchHomeUsecaseInput {
  final String searchContent;
  final int page;

  GetSearchHomeUsecaseInput({required this.searchContent, required this.page});
}
