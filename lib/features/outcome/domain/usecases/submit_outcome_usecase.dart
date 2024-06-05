import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/outcome/data/models/sumbit_outcome_model_response.dart';
import '../../../../exports.dart';

class SubmitOutcomeUsecase
    implements BaseUseCase<SubmitUseCaseInput, SubmitOutcomeModelResponse> {
  final OutcomeRepository repository;

  SubmitOutcomeUsecase(this.repository);

  @override
  Future<Either<Failure, SubmitOutcomeModelResponse>> excute(
      SubmitUseCaseInput input) async {
    return await repository.submitOutcome(
      input.patientId,
      input.sectionId,
      input.map,
    );
  }
}

class SubmitUseCaseInput {
  final String patientId;
  final String sectionId;
  final Map<String, dynamic> map;
  const SubmitUseCaseInput({
    required this.patientId,
    required this.sectionId,
    required this.map,
  });
}
