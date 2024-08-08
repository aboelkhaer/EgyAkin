import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class GetCurrentDoctorConsultationUsecase
    implements
        BaseUseCase<NoParams, GetCurrentDoctorConsultationModelResponse> {
  final ConsultationRepository repository;

  GetCurrentDoctorConsultationUsecase(this.repository);

  @override
  Future<Either<Failure, GetCurrentDoctorConsultationModelResponse>> execute(
      NoParams input) async {
    return await repository.getCurrentDoctorConsultation();
  }
}
