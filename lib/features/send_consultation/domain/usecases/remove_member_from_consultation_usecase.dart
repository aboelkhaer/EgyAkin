import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/send_consultation/data/models/remove_member_from_consultation_model_response.dart';
import '../../../../exports.dart';

class RemoveMemberFromConsultationUsecase
    implements BaseUseCase<RemoveMemberFromConsultationUsecaseInput, RemoveMemberFromConsultationModelResponse> {
  final SendConsultationRepository repository;

  RemoveMemberFromConsultationUsecase(this.repository);

  @override
  Future<Either<Failure, RemoveMemberFromConsultationModelResponse>> execute(
      RemoveMemberFromConsultationUsecaseInput input) async {
    return await repository.removeMemberFromConsultation(
        consultationId: input.consultationId, doctorId: input.doctorId);
  }
}
class RemoveMemberFromConsultationUsecaseInput{
  final String consultationId;
  final String doctorId;

  RemoveMemberFromConsultationUsecaseInput({required this.consultationId, required this.doctorId});
}