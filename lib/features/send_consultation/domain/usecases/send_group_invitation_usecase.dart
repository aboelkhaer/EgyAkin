import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/send_consultation/data/models/send_invitation_model_response.dart';
import '../../../../exports.dart';

class SendGroupInvitationUsecase
    implements
        BaseUseCase<SendGroupInvitationUsecaseInput,
            SendInvitationModelResponse> {
  final SendConsultationRepository repository;

  SendGroupInvitationUsecase(this.repository);

  @override
  Future<Either<Failure, SendInvitationModelResponse>> execute(
      SendGroupInvitationUsecaseInput input) async {
    return await repository.sendGroupInvitation(
      groupId: input.groupId,
      message: input.message,
      doctorsIDS: input.doctorsIDS,
    );
  }
}

class SendGroupInvitationUsecaseInput {
  final String groupId;
  final String message;
  final List<String> doctorsIDS;

  SendGroupInvitationUsecaseInput({
    required this.groupId,
    required this.message,
    required this.doctorsIDS,
  });
}
