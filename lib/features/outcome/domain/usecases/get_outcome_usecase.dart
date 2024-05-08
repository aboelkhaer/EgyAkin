import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class GetOutcomeUsecase
    implements BaseUseCase<String, GetOutcomeModelResponse> {
  final OutcomeRepository repository;

  GetOutcomeUsecase(this.repository);

  @override
  Future<Either<Failure, GetOutcomeModelResponse>> excute(
      String patientId) async {
    return await repository.getOutcome(patientId);
  }
}
