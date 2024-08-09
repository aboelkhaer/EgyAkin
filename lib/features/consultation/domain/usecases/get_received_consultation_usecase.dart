import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class GetReceivedConsultationUsecase
    implements
        BaseUseCase<NoParams, List<GetCurrentDoctorConsultationModelResponse>> {
  final ConsultationRepository repository;

  GetReceivedConsultationUsecase(this.repository);

  @override
  Future<Either<Failure, List<GetCurrentDoctorConsultationModelResponse>>>
      execute(NoParams input) async {
    return await repository.getReceivedConsultation();
  }
}
