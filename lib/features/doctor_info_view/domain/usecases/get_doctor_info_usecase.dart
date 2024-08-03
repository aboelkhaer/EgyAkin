import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/doctor_info_view/data/models/doctor_info_view_model_response.dart';
import '../../../../exports.dart';

class GetDoctorInfoViewUsecase
    implements BaseUseCase<String, DoctorInfoViewModelResponse> {
  final DoctorInfoViewRepository repository;

  GetDoctorInfoViewUsecase(this.repository);

  @override
  Future<Either<Failure, DoctorInfoViewModelResponse>> execute(
      String doctorId) async {
    return await repository.getDoctorInfo(doctorId);
  }
}
