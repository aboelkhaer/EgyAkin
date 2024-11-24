import 'package:egy_akin/features/all_doctors_patients/data/models/apply_patient_filters_model_response.dart';

import '../../../../exports.dart';
import 'package:dartz/dartz.dart';

abstract class AllDoctorsPatientsRepository {
  Future<Either<Failure, GetAllDoctorsPatientsModelResponse>>
      getAllDoctorsPatients(int page);
  Future<Either<Failure, ApplyPatientFiltersModelResponse>>
      applyPatientsFilters(
    Map<String, dynamic> map,
    int page,
  );
}
