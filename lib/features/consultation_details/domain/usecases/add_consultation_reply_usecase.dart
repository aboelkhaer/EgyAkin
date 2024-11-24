import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class AddConsultationReplyUsecase
    implements
        BaseUseCase<AddConsultationReplyUsecaseInput,
            AddConsultationReplyModelResponse> {
  final ConsultationDetailsRepository repository;

  AddConsultationReplyUsecase(this.repository);

  @override
  Future<Either<Failure, AddConsultationReplyModelResponse>> execute(
      AddConsultationReplyUsecaseInput input) async {
    return await repository.addConsultationReply(
        consultationId: input.consultationId, reply: input.reply);
  }
}

class AddConsultationReplyUsecaseInput {
  final String consultationId;
  final String reply;

  AddConsultationReplyUsecaseInput(
      {required this.consultationId, required this.reply});
}
