import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class GetAiConsultationHistoryUsecase
    implements
        BaseUseCase<GetAiConsultationHistoryUsecaseInput,
            GetAiConsultationHistoryModelResponse> {
  final ConsultationFromAIRepository repository;

  GetAiConsultationHistoryUsecase(this.repository);

  @override
  Future<Either<Failure, GetAiConsultationHistoryModelResponse>> execute(
    GetAiConsultationHistoryUsecaseInput input,
  ) async {
    return await repository.getAIConsultationHistory(
      patientId: input.patientId,
      page: input.page,
    );
  }
}

class GetAiConsultationHistoryUsecaseInput {
  final String patientId;
  final int page;

  GetAiConsultationHistoryUsecaseInput(
      {required this.patientId, required this.page});
}
