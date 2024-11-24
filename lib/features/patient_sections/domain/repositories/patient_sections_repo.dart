import 'package:dartz/dartz.dart';

import '../../../../exports.dart';

abstract class PatientSectionsRepository {
  Future<Either<Failure, GetPatientSectionsModelResponse>> getPatientSections({
    required String patientId,
  });
  Future<Either<Failure, DeletePatientModelResponse>> deletePatient({
    required String patientId,
  });
  Future<Either<Failure, FinalSubmitModelResponse>> finalSubmit({
    required String patientId,
  });
  Future<Either<Failure, DownloadPatientReportModelResponse>>
      downloadPatientReport({
    required String patientId,
  });
}
