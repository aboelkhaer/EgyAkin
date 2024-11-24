import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class GetConsultationSearchUsecase
    implements BaseUseCase<String, GetConsultationSearchModelResponse> {
  final SendConsultationRepository repository;

  GetConsultationSearchUsecase(this.repository);

  @override
  Future<Either<Failure, GetConsultationSearchModelResponse>> execute(
      String searchContent) async {
    return await repository.consultationDoctorSearch(
        searchContent: searchContent);
  }
}
