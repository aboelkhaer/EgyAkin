import 'package:egy_akin/features/all_doctors_patients/domain/usecases/patients_list_page_input.dart';

import '../../../../exports.dart';
import 'package:dartz/dartz.dart';

abstract class CurrentDoctorPatientsRepository {
  Future<Either<Failure, GetDoctorPatientsModelResponse>>
      getCurrentDoctorPatients(PatientsListPageInput input);
}
