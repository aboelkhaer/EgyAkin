import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/send_consultation/data/models/get_members_for_consultation_model_response.dart';
import '../../../../exports.dart';

class GetMembersForConsultationUsecase
    implements BaseUseCase<String, GetMembersForConsultationModelResponse> {
  final SendConsultationRepository repository;

  GetMembersForConsultationUsecase(this.repository);

  @override
  Future<Either<Failure, GetMembersForConsultationModelResponse>> execute(
      String consultationId) async {
    return await repository.getMembersForConsultation(
        consultationId: consultationId);
  }
}
