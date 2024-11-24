import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

abstract class PatientCommentsRepository {
  Future<Either<Failure, GetPatientCommentsModelResponse>> getPatientComments(
      String patientId);
  Future<Either<Failure, AddPatientCommentsModelResponse>> addPatientComments(
      String patientId, String content);
  Future<Either<Failure, DeletePatientCommentsModelResponse>>
      deletePatientComments(String commentId);
}
