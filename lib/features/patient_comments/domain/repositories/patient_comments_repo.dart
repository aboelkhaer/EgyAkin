import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/patient_comments/data/models/add_patient_comment_model_response.dart';
import 'package:egy_akin/features/patient_comments/data/models/delete_patient_comment_model_response.dart';
import '../../../../exports.dart';

abstract class PatientCommentsRepository {
  Future<Either<Failure, GetPatientCommentsModelResponse>> getPatientComments(
      String patientId);
  Future<Either<Failure, AddPatientCommentsModelResponse>> addPatientComments(
      String patientId, String content);
  Future<Either<Failure, DeletePatientCommentsModelResponse>>
      deletePatientComments(String commentId);
}
