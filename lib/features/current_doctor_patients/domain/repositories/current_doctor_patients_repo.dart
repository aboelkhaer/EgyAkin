import '../../../../exports.dart';
import 'package:dartz/dartz.dart';

abstract class CurrentDoctorPatientsRepository {
  Future<Either<Failure, GetDoctorPatientsModelResponse>>
      getCurrentDoctorPatients(int page);
}
