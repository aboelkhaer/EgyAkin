import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/send_consultation/data/models/get_consultation_search_model_response.dart';
import 'package:egy_akin/features/send_consultation/domain/repositories/send_consultation_repo.dart';
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
