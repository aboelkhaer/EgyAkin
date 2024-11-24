import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class DownloadPatientReportUsecase
    implements BaseUseCase<String, DownloadPatientReportModelResponse> {
  final PatientSectionsRepository repository;

  DownloadPatientReportUsecase(this.repository);

  @override
  Future<Either<Failure, DownloadPatientReportModelResponse>> execute(
      String patientId) async {
    return await repository.downloadPatientReport(patientId: patientId);
  }
}
