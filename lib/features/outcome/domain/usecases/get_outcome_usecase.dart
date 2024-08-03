import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class GetOutcomeUsecase
    implements BaseUseCase<GetOutcomeUsecaseInput, GetOutcomeModelResponse> {
  final OutcomeRepository repository;

  GetOutcomeUsecase(this.repository);

  @override
  Future<Either<Failure, GetOutcomeModelResponse>> execute(
      GetOutcomeUsecaseInput input) async {
    return await repository.getOutcome(input.sectionId, input.patientId);
  }
}

class GetOutcomeUsecaseInput {
  final String sectionId;
  final String patientId;

  GetOutcomeUsecaseInput({required this.sectionId, required this.patientId});
}
