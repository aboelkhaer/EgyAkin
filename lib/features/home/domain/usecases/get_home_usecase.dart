import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class GetHomeUsecase implements BaseUseCase<NoParams, HomeModelResponse> {
  final HomeRepository repository;

  GetHomeUsecase(this.repository);

  @override
  Future<Either<Failure, HomeModelResponse>> execute(NoParams input) async {
    return await repository.getHome();
  }
}
