import 'package:egy_akin/exports.dart';

class AppRoutesArgs {
  static Map<String, dynamic> patientSectionsRouteArguments({
    required String patientId,
    required DoctorModel currentDoctorModel,
    required bool isAllDataOpen,
    required int currentDoctorPoints,
    required String currentDoctorRole,
    required HomeModelResponse homeDataModel,
  }) {
    return {
      'patientId': patientId,
      'currentDoctorModel': currentDoctorModel,
      'currentDoctorRole': currentDoctorRole,
      'currentDoctorPoints': currentDoctorPoints,
      'homeDataModel': homeDataModel,
      'isAllDataOpen': isAllDataOpen,
    };
  }

  static Map<String, dynamic> postDetailsRouteArgs({
    required PostModel postModel,
    required DoctorModel doctorModel,
    required bool verified,
    required String isSyndicateCardRequired,
    required String currentDoctorRole,
    required HomeModelResponse homeDataModel,
  }) {
    return {
      'postModel': postModel,
      'doctorModel': doctorModel,
      'accountVerification': verified,
      'isSyndicateCardRequired': isSyndicateCardRequired,
      'currentDoctorRole': currentDoctorRole,
      'homeDataModel': homeDataModel,
    };
  }

  static Map<String, dynamic> addPatientRouteArgs({
    required DoctorModel currentDoctorModel,
    required String currentDoctorRole,
    required int currentDoctorPoints,
    required HomeModelResponse homeDataModel,
  }) {
    return {
      'currentDoctorModel': currentDoctorModel,
      'currentDoctorRole': currentDoctorRole,
      'currentDoctorPoints': currentDoctorPoints,
      'homeDataModel': homeDataModel,
    };
  }

  static Map<String, dynamic> patientCommentsRouteArgs({
    required String patientId,
    required DoctorModel currentDoctorModel,
    required bool verified,
    required String patientName,
    required String isSyndicateCardRequired,
    required int currentDoctorPoints,
    required String currentDoctorRole,
    required HomeModelResponse homeDataModel,
  }) {
    return {
      'patientId': patientId,
      'currentDoctorModel': currentDoctorModel,
      'accountVerification': verified,
      'patientName': patientName,
      'isSyndicateCardRequired': isSyndicateCardRequired,
      'currentDoctorPoints': currentDoctorPoints,
      'currentDoctorRole': currentDoctorRole,
      'homeDataModel': homeDataModel,
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
    required String currentDoctorRole,
    required int currentDoctorPoints,
    required HomeModelResponse homeDataModel,
  }) {
    return {
      'currentDoctorModel': currentDoctorModel,
      'accountVerification': verified,
      'isSyndicateCardRequired': isSyndicateCardRequired,
      'currentDoctorRole': currentDoctorRole,
      'currentDoctorPoints': currentDoctorPoints,
      'homeDataModel': homeDataModel,
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
    required String currentDoctorRole,
    required int currentDoctorPoints,
    required HomeModelResponse homeDataModel,
  }) {
    return {
      'accountVerification': verified,
      'outcomeStatus': outcomeStatus,
      'patientName': patientName,
      'patientId': patientId,
      'currentDoctorModel': currentDoctorModel,
      'doctorId': doctorId,
      'isSyndicateCardRequired': isSyndicateCardRequired,
      'currentDoctorRole': currentDoctorRole,
      'currentDoctorPoints': currentDoctorPoints,
      'homeDataModel': homeDataModel,
    };
  }

  static Map<String, dynamic> currentDoctorPatientsRouteArgs({
    required bool accountVerification,
    required DoctorModel currentDoctorModel,
    required String isSyndicateCardRequired,
    required String currentDoctorRole,
    required int currentDoctorPoints,
    required HomeModelResponse homeDataModel,
  }) {
    return {
      'accountVerification': accountVerification,
      'currentDoctorModel': currentDoctorModel,
      'isSyndicateCardRequired': isSyndicateCardRequired,
      'currentDoctorRole': currentDoctorRole,
      'currentDoctorPoints': currentDoctorPoints,
      'homeDataModel': homeDataModel,
    };
  }

  static Map<String, dynamic> allDoctorsPatientsRouteArgs({
    required bool accountVerification,
    required DoctorModel currentDoctorModel,
    required String isSyndicateCardRequired,
    required String currentDoctorRole,
    required int currentDoctorPoints,
    required HomeModelResponse homeDataModel,
  }) {
    return {
      'accountVerification': accountVerification,
      'currentDoctorModel': currentDoctorModel,
      'isSyndicateCardRequired': isSyndicateCardRequired,
      'currentDoctorRole': currentDoctorRole,
      'currentDoctorPoints': currentDoctorPoints,
      'homeDataModel': homeDataModel,
    };
  }

  static Map<String, dynamic> patientSectionDetailsRouteArgs({
    required SectionModel sectionModel,
    required DoctorModel currentDoctorModel,
    required bool finalSubmitStatus,
    required String patientId,
    required String currentDoctorRole,
    required String doctorId,
    required int currentDoctorPoints,
    required HomeModelResponse homeDataModel,
    required bool isAllDataOpen,
  }) {
    return {
      'sectionModel': sectionModel,
      'currentDoctorModel': currentDoctorModel,
      'finalSubmitStatus': finalSubmitStatus,
      'patientId': patientId,
      'doctorId': doctorId,
      'currentDoctorRole': currentDoctorRole,
      'currentDoctorPoints': currentDoctorPoints,
      'homeDataModel': homeDataModel,
      'isAllDataOpen': isAllDataOpen,
    };
  }

  static Map<String, dynamic> doctorInfoViewRouteArgs({
    required String doctorId,
    required DoctorModel currentDoctorModel,
    required bool accountVerification,
    required String isSyndicateCardRequired,
    required String currentDoctorRole,
    required int currentDoctorPoints,
    required HomeModelResponse homeDataModel,
    required int initialIndex,
    required bool isNavigateToTheButtonOfInformationTab,
  }) {
    return {
      'doctorId': doctorId,
      'currentDoctorModel': currentDoctorModel,
      'accountVerification': accountVerification,
      'isSyndicateCardRequired': isSyndicateCardRequired,
      'currentDoctorRole': currentDoctorRole,
      'currentDoctorPoints': currentDoctorPoints,
      'homeDataModel': homeDataModel,
      'initialIndex': initialIndex,
      'isNavigateToTheButtonOfInformationTab':
          isNavigateToTheButtonOfInformationTab,
    };
  }

  static Map<String, dynamic> profilePatientsRouteArgs({
    required String doctorId,
    required bool accountVerification,
    required String isSyndicateCardRequired,
    required DoctorModel currentDoctorModel,
    required String doctorFirstName,
    required String currentDoctorRole,
    required int currentDoctorPoints,
    required HomeModelResponse homeDataModel,
  }) {
    return {
      'doctorId': doctorId,
      'accountVerification': accountVerification,
      'isSyndicateCardRequired': isSyndicateCardRequired,
      'currentDoctorModel': currentDoctorModel,
      'doctorFirstName': doctorFirstName,
      'currentDoctorRole': currentDoctorRole,
      'currentDoctorPoints': currentDoctorPoints,
      'homeDataModel': homeDataModel,
    };
  }

  static Map<String, dynamic> gfrCalculatorRouteArgs({
    required HomeModelResponse homeDataModel,
  }) {
    return {
      'homeDataModel': homeDataModel,
    };
  }

  static Map<String, dynamic> sendConsultationRouteArgs({
    required HomeModelResponse homeDataModel,
    required DoctorModel currentDoctorModel,
    required String patientId,
  }) {
    return {
      'homeDataModel': homeDataModel,
      'currentDoctorModel': currentDoctorModel,
      'patientId': patientId,
    };
  }

  static Map<String, dynamic> consultationRouteArgs({
    required HomeModelResponse homeDataModel,
    required DoctorModel currentDoctorModel,
    required int initialTab,
  }) {
    return {
      'homeDataModel': homeDataModel,
      'currentDoctorModel': currentDoctorModel,
      'initialTab': initialTab,
    };
  }

  static Map<String, dynamic> consultationDetailsRouteArgs({
    required HomeModelResponse homeDataModel,
    required DoctorModel currentDoctorModel,
    required bool isReceivedConsultation,
    required String consultationId,
    required String patientName,
  }) {
    return {
      'homeDataModel': homeDataModel,
      'currentDoctorModel': currentDoctorModel,
      'consultationId': consultationId,
      'patientName': patientName,
      'isReceivedConsultation': isReceivedConsultation,
    };
  }

  static Map<String, dynamic> communityRouteArgs({
    required HomeModelResponse homeDataModel,
    required DoctorModel currentDoctorModel,
  }) {
    return {
      'homeDataModel': homeDataModel,
      'currentDoctorModel': currentDoctorModel,
    };
  }
}
