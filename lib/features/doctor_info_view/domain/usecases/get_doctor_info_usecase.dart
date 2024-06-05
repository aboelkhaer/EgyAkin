import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/doctor_info_view/data/models/doctor_info_view_model_response.dart';
import 'package:egy_akin/features/doctor_info_view/domain/repositories/doctor_info_view_repo.dart';
import '../../../../exports.dart';

class GetDoctorInfoViewUsecase
    implements BaseUseCase<String, DoctorInfoViewModelResponse> {
  final DoctorInfoViewRepository repository;

  GetDoctorInfoViewUsecase(this.repository);

  @override
  Future<Either<Failure, DoctorInfoViewModelResponse>> excute(
      String doctorId) async {
    return await repository.getDoctorInfo(doctorId);
  }
}
