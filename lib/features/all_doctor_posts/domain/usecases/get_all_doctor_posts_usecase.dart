import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/all_doctor_posts/data/models/get_all_doctor_posts_model_response.dart';
import 'package:egy_akin/features/all_doctor_posts/domain/repositories/all_doctor_posts_repo.dart';
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
