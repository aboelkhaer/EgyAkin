import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/patient_sections/data/models/download_patient_report_model_response.dart';
import '../../../../exports.dart';

class DownloadPatientReportUsecase
    implements BaseUseCase<String, DownloadPatientReportModelResponse> {
  final PatientSectionsRepository repository;

  DownloadPatientReportUsecase(this.repository);

  @override
  Future<Either<Failure, DownloadPatientReportModelResponse>> excute(
      String patientId) async {
    return await repository.downloadPatientReport(patientId: patientId);
  }
}
