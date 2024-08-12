import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class GetConsultationDetailsUsecase
    implements BaseUseCase<String, List<GetConsultationDetailsModelResponse>> {
  final ConsultationDetailsRepository repository;

  GetConsultationDetailsUsecase(this.repository);

  @override
  Future<Either<Failure, List<GetConsultationDetailsModelResponse>>> execute(
      String consultationId) async {
    return await repository.getConsultationDetails(consultationId);
  }
}
