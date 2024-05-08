import 'package:egy_akin/features/patient_comments/data/models/add_patient_comment_model_response.dart';
import 'package:egy_akin/features/patient_comments/data/models/delete_patient_comment_model_response.dart';

import '../../../../exports.dart';

abstract class PatientCommentsDataSource {
  Future<GetPatientCommentsModelResponse> getPatientComments(String patientId);
  Future<AddPatientCommentsModelResponse> addPatientComments(
      String patientId, String content);
  Future<DeletePatientCommentsModelResponse> deletePatientComments(
      String commentId);
}

class PatientCommentsDataSourceImpl implements PatientCommentsDataSource {
  final ApiServices _apiServices;

  PatientCommentsDataSourceImpl(this._apiServices);

  @override
  Future<GetPatientCommentsModelResponse> getPatientComments(
    String patientId,
  ) async {
    return await _apiServices.getPatientComments(patientId);
  }

  @override
  Future<AddPatientCommentsModelResponse> addPatientComments(
      String patientId, String content) async {
    return await _apiServices.addComment(patientId, content);
  }

  @override
  Future<DeletePatientCommentsModelResponse> deletePatientComments(
      String commentId) async {
    return await _apiServices.deleteComment(commentId);
  }
}
