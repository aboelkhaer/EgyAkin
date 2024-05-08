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
      input.outcomeOfThePatient,
      input.creatinineOnDischarge,
      input.durationField,
      input.finalStatus,
      input.other,
    );
  }
}

class SubmitUseCaseInput {
  final String patientId;
  final String outcomeOfThePatient;
  final String creatinineOnDischarge;
  final String durationField;
  final String finalStatus;
  final String other;
  const SubmitUseCaseInput({
    required this.patientId,
    required this.outcomeOfThePatient,
    required this.creatinineOnDischarge,
    required this.durationField,
    required this.finalStatus,
    required this.other,
  });
}
