import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class GetPatientSectionsUsecase
    implements BaseUseCase<String, GetPatientSectionsModelResponse> {
  final PatientSectionsRepository repository;

  GetPatientSectionsUsecase(this.repository);

  @override
  Future<Either<Failure, GetPatientSectionsModelResponse>> execute(
      String patientId) async {
    return await repository.getPatientSections(patientId: patientId);
  }
}
