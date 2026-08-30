import 'package:dartz/dartz.dart';
import '../../../../exports.dart';
import 'package:egy_akin/features/home/data/models/user_me_response.dart';

class GetUserMeUsecase implements BaseUseCase<NoParams, UserMeResponse> {
  final HomeRepository repository;

  GetUserMeUsecase(this.repository);

  @override
  Future<Either<Failure, UserMeResponse>> execute(NoParams input) async {
    return await repository.getUserMe();
  }
}
