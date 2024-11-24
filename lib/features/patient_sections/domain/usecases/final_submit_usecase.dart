import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class FinalSubmitUsecase
    implements BaseUseCase<String, FinalSubmitModelResponse> {
  final PatientSectionsRepository repository;

  FinalSubmitUsecase(this.repository);

  @override
  Future<Either<Failure, FinalSubmitModelResponse>> execute(
      String patientId) async {
    return await repository.finalSubmit(patientId: patientId);
  }
}
