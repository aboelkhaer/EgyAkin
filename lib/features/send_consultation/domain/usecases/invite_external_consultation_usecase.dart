import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/send_consultation/data/models/invite_external_model_response.dart';
import '../../../../exports.dart';

class InviteExternalConsultationUsecase
    implements
        BaseUseCase<InviteExternalConsultationUsecaseInput,
            InviteExternalModelResponse> {
  final SendConsultationRepository repository;

  InviteExternalConsultationUsecase(this.repository);

  @override
  Future<Either<Failure, InviteExternalModelResponse>> execute(
      InviteExternalConsultationUsecaseInput input) async {
    return await repository.inviteExternalConsultation(
      consultationId: input.consultationId,
      email: input.email,
      inviteMessage: input.inviteMessage,
    );
  }
}

class InviteExternalConsultationUsecaseInput {
  final String consultationId;
  final String email;
  final String? inviteMessage;

  InviteExternalConsultationUsecaseInput({
    required this.consultationId,
    required this.email,
    this.inviteMessage,
  });
}
