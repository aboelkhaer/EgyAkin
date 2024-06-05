import 'package:egy_akin/features/all_doctors_patients/data/models/get_all_doctors_patients_model_response.dart';

import '../../../../exports.dart';
import 'package:dartz/dartz.dart';

abstract class AllDoctorsPatientsRepository {
  Future<Either<Failure, GetAllDoctorsPatientsModelResponse>>
      getAllDoctorsPatients(int page);
}
