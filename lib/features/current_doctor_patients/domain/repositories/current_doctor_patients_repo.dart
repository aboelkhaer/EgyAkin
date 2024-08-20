import 'package:egy_akin/features/doctor_info_view/data/models/get_achievements_model_response.dart';
import 'package:egy_akin/features/current_doctor_patients/data/models/get_current_doctor_patients_model_response.dart';

import '../../../../exports.dart';
import 'package:dartz/dartz.dart';

abstract class CurrentDoctorPatientsRepository {
  Future<Either<Failure, GetDoctorPatientsModelResponse>>
      getCurrentDoctorPatients(int page);
}
