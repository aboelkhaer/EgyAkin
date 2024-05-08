import 'package:egy_akin/exports.dart';
import 'package:egy_akin/features/authentication/data/models/authentication_model_response.dart';

class AppRoutesArgs {
  static Map<String, dynamic> patientSectionsRouteArguments(
      {required String patientId, required String currentDoctorId}) {
    return {
      'patientId': patientId,
      'currentDoctorId': currentDoctorId,
    };
  }

  static Map<String, dynamic> postDetailsRouteArgs(
      {required PostModel postModel,
      required DoctorModel doctorModel,
      required bool verified}) {
    return {
      'postModel': postModel,
      'doctorModel': doctorModel,
      'accountVerification': verified,
    };
  }

  static String addPatientRouteArgs({required String currentDoctorId}) {
    return currentDoctorId;
  }

  static Map<String, dynamic> patientCommentsRouteArgs(
      {required String patientId,
      required DoctorModel currentDoctorModel,
      required bool verified}) {
    return {
      'patientId': patientId,
      'currentDoctorModel': currentDoctorModel,
      'accountVerification': verified,
    };
  }

  static DoctorModel emailVerificationRouteArgs({
    required DoctorModel currentDoctorModel,
  }) {
    return currentDoctorModel;
  }

  static Map<String, dynamic> searchRouteArgs({
    required DoctorModel currentDoctorModel,
    required bool verified,
  }) {
    return {
      'currentDoctorModel': currentDoctorModel,
      'accountVerification': verified,
    };
  }

  static Map<String, dynamic> outcomeRouteArgs({
    required bool verified,
    required bool outcomeStatus,
    required String patientName,
    required String patientId,
  }) {
    return {
      'accountVerification': verified,
      'outcomeStatus': outcomeStatus,
      'patientName': patientName,
      'patientId': patientId,
    };
  }

  static Map<String, dynamic> currentDoctorPatientsRouteArgs({
    required bool accountVerification,
    required DoctorModel currentDoctorModel,
  }) {
    return {
      'accountVerification': accountVerification,
      'currentDoctorModel': currentDoctorModel,
    };
  }
}
