import 'package:egy_akin/exports.dart';

class AppRoutesArgs {
  static Map<String, dynamic> patientSectionsRouteArguments(
      {required String patientId, required DoctorModel currentDoctorModel}) {
    return {
      'patientId': patientId,
      'currentDoctorModel': currentDoctorModel,
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

  static DoctorModel addPatientRouteArgs(
      {required DoctorModel currentDoctorModel}) {
    return currentDoctorModel;
  }

  static Map<String, dynamic> patientCommentsRouteArgs({
    required String patientId,
    required DoctorModel currentDoctorModel,
    required bool verified,
    required String patientName,
  }) {
    return {
      'patientId': patientId,
      'currentDoctorModel': currentDoctorModel,
      'accountVerification': verified,
      'patientName': patientName,
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
    required String doctorId,
    required String currentDoctorId,
  }) {
    return {
      'accountVerification': verified,
      'outcomeStatus': outcomeStatus,
      'patientName': patientName,
      'patientId': patientId,
      'currentDoctorId': currentDoctorId,
      'doctorId': doctorId,
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

  static Map<String, dynamic> allDoctorsPatientsRouteArgs({
    required bool accountVerification,
    required DoctorModel currentDoctorModel,
  }) {
    return {
      'accountVerification': accountVerification,
      'currentDoctorModel': currentDoctorModel,
    };
  }

  static Map<String, dynamic> patientSectionDetailsRouteArgs({
    required SectionModel sectionModel,
    required DoctorModel currentDoctorModel,
    required bool finalSubmitStatus,
    required String patientId,
    required String doctorId,
  }) {
    return {
      'sectionModel': sectionModel,
      'currentDoctorModel': currentDoctorModel,
      'finalSubmitStatus': finalSubmitStatus,
      'patientId': patientId,
      'doctorId': doctorId,
    };
  }

  static Map<String, dynamic> doctorInfoViewRouteArgs({
    required String doctorId,
    required String currentDoctorId,
  }) {
    return {
      'doctorId': doctorId,
      'currentDoctorId': currentDoctorId,
    };
  }
}
