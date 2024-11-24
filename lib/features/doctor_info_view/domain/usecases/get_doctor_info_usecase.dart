import 'package:dartz/dartz.dart';
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
