import 'package:egy_akin/exports.dart';

class AppRoutesArgs {
  static Map<String, dynamic> patientSectionsRouteArguments(
      {required String patientId, required DoctorModel currentDoctorModel}) {
    return {
      'patientId': patientId,
      'currentDoctorModel': currentDoctorModel,
    };
  }

  static Map<String, dynamic> postDetailsRouteArgs({
    required PostModel postModel,
    required DoctorModel doctorModel,
    required bool verified,
    required String isSyndicateCardRequired,
  }) {
    return {
      'postModel': postModel,
      'doctorModel': doctorModel,
      'accountVerification': verified,
      'isSyndicateCardRequired': isSyndicateCardRequired,
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
    required String isSyndicateCardRequired,
  }) {
    return {
      'patientId': patientId,
      'currentDoctorModel': currentDoctorModel,
      'accountVerification': verified,
      'patientName': patientName,
      'isSyndicateCardRequired': isSyndicateCardRequired,
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
    required String isSyndicateCardRequired,
  }) {
    return {
      'currentDoctorModel': currentDoctorModel,
      'accountVerification': verified,
      'isSyndicateCardRequired': isSyndicateCardRequired,
    };
  }

  static Map<String, dynamic> outcomeRouteArgs({
    required bool verified,
    required bool outcomeStatus,
    required String patientName,
    required String patientId,
    required String doctorId,
    required DoctorModel currentDoctorModel,
    required String isSyndicateCardRequired,
  }) {
    return {
      'accountVerification': verified,
      'outcomeStatus': outcomeStatus,
      'patientName': patientName,
      'patientId': patientId,
      'currentDoctorModel': currentDoctorModel,
      'doctorId': doctorId,
      'isSyndicateCardRequired': isSyndicateCardRequired,
    };
  }

  static Map<String, dynamic> currentDoctorPatientsRouteArgs({
    required bool accountVerification,
    required DoctorModel currentDoctorModel,
    required String isSyndicateCardRequired,
  }) {
    return {
      'accountVerification': accountVerification,
      'currentDoctorModel': currentDoctorModel,
      'isSyndicateCardRequired': isSyndicateCardRequired,
    };
  }

  static Map<String, dynamic> allDoctorsPatientsRouteArgs({
    required bool accountVerification,
    required DoctorModel currentDoctorModel,
    required String isSyndicateCardRequired,
  }) {
    return {
      'accountVerification': accountVerification,
      'currentDoctorModel': currentDoctorModel,
      'isSyndicateCardRequired': isSyndicateCardRequired,
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
    required DoctorModel currentDoctorModel,
    required bool accountVerification,
    required String isSyndicateCardRequired,
  }) {
    return {
      'doctorId': doctorId,
      'currentDoctorModel': currentDoctorModel,
      'accountVerification': accountVerification,
      'isSyndicateCardRequired': isSyndicateCardRequired,
    };
  }

  static Map<String, dynamic> profilePatientsRouteArgs({
    required String doctorId,
    required bool accountVerification,
    required String isSyndicateCardRequired,
    required DoctorModel currentDoctorModel,
    required String doctorFirstName,
  }) {
    return {
      'doctorId': doctorId,
      'accountVerification': accountVerification,
      'isSyndicateCardRequired': isSyndicateCardRequired,
      'currentDoctorModel': currentDoctorModel,
      'doctorFirstName': doctorFirstName,
    };
  }
}
