import '../../../../exports.dart';
import 'package:dartz/dartz.dart';

abstract class OutcomeRepository {
  Future<Either<Failure, GetOutcomeModelResponse>> getOutcome(
      String sectionId, String patientId);
  Future<Either<Failure, SubmitOutcomeModelResponse>> submitOutcome(
    String patientId,
    String sectionId,
    Map<String, dynamic> map,
  );
}
