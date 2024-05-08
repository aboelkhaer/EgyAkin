import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/search/domain/repositories/search_repo.dart';
import '../../../../exports.dart';

class GetSearchHomeUsecase
    implements BaseUseCase<String, GetSearchModelResponse> {
  final SearchRepository repository;

  GetSearchHomeUsecase(this.repository);

  @override
  Future<Either<Failure, GetSearchModelResponse>> excute(
      String searchContent) async {
    return await repository.getSearchHome(searchContent: searchContent);
  }
}
