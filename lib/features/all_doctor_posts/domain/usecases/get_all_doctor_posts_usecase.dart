import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class GetAllDoctorPostsUsecase
    implements
        BaseUseCase<GetAllDoctorPostsUsecaseInput,
            GetAllDoctorPostsModelResponse> {
  final AllDoctorPostsRepository repository;

  GetAllDoctorPostsUsecase(this.repository);

  @override
  Future<Either<Failure, GetAllDoctorPostsModelResponse>> execute(
      GetAllDoctorPostsUsecaseInput input) async {
    return await repository.getAllDoctorPosts(input.doctorId, input.page);
  }
}

class GetAllDoctorPostsUsecaseInput {
  final String doctorId;
  final int page;

  GetAllDoctorPostsUsecaseInput({required this.doctorId, required this.page});
}
