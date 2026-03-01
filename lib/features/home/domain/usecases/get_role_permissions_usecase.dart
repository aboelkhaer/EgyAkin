import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class GetRolePermissionsUsecase implements BaseUseCase<NoParams, GetPermissionsModelResponse> {
  final HomeRepository repository;

  GetRolePermissionsUsecase(this.repository);

  @override
  Future<Either<Failure, GetPermissionsModelResponse>> execute(NoParams input) async {
    return await repository.getRolePermissions();
  }
}

