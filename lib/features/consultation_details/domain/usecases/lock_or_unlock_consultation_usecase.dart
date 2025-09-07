import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/consultation_details/data/models/lock_or_unlock_consultation_model_response.dart';
import '../../../../exports.dart';

class LockOrUnlockConsultationUsecase
    implements
        BaseUseCase<LockOrUnlockConsultationUsecaseInput,
            LockOrUnlockConsultationModelResponse> {
  final ConsultationDetailsRepository repository;

  LockOrUnlockConsultationUsecase(this.repository);

  @override
  Future<Either<Failure, LockOrUnlockConsultationModelResponse>> execute(
      LockOrUnlockConsultationUsecaseInput input) async {
    return await repository.lockOrUnlockConsultation(
        input.consultationId, input.isOpen);
  }
}

class LockOrUnlockConsultationUsecaseInput {
  final String consultationId;
  final bool isOpen;

  LockOrUnlockConsultationUsecaseInput(
      {required this.consultationId, required this.isOpen});
}
