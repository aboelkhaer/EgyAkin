import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/patient_sections/data/models/delete_patient_model_response.dart';
import 'package:egy_akin/features/patient_sections/data/models/final_submit_model_response.dart';

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
}
