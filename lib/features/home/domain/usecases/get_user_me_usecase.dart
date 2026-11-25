import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class GetUserMeUsecase implements BaseUseCase<NoParams, UserMeResponse> {
  final HomeRepository repository;

  GetUserMeUsecase(this.repository);

  @override
  Future<Either<Failure, UserMeResponse>> execute(NoParams input) async {
    return await repository.getUserMe();
  }
}
