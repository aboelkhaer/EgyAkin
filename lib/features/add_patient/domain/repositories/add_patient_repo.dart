import 'package:egy_akin/features/add_patient/data/models/get_patient_history_for_add_patient.dart';

import '../../../../exports.dart';
import 'package:dartz/dartz.dart';

abstract class AddPatientRepository {
  Future<Either<Failure, GetPatientHistoryForAddPatientModelResponse>>
      getPatientHistoryForAddPatient({
    required String sectionId,
  });
}
