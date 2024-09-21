import 'package:egy_akin/features/current_doctor_patients/data/models/get_current_doctor_patients_model_response.dart';

import '../../../../exports.dart';
import 'package:dartz/dartz.dart';

abstract class CurrentDoctorPatientsRepository {
  Future<Either<Failure, GetDoctorPatientsModelResponse>>
      getCurrentDoctorPatients(int page);
}
