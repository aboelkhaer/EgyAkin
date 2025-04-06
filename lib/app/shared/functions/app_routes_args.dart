import 'package:egy_akin/exports.dart';
import 'package:egy_akin/features/community/data/models/get_groups_tab_model_response.dart';

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
    required bool isSendConsultation,
    required String groupId,
  }) {
    return {
      'homeDataModel': homeDataModel,
      'currentDoctorModel': currentDoctorModel,
      'patientId': patientId,
      'isSendConsultation': isSendConsultation,
      'groupId': groupId,
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
    required int initialTab,
  }) {
    return {
      'homeDataModel': homeDataModel,
      'currentDoctorModel': currentDoctorModel,
      'initialTab': initialTab,
    };
  }

  static Map<String, dynamic> showSingleFeedRouteArgs({
    required HomeModelResponse homeDataModel,
    required DoctorModel currentDoctorModel,
    required PostCommunityModel feed,
    required bool isComeFromNotification,
    required String feedId,
    required String showPostFrom,
  }) {
    return {
      'homeDataModel': homeDataModel,
      'currentDoctorModel': currentDoctorModel,
      'feed': feed,
      'isComeFromNotification': isComeFromNotification,
      'feedId': feedId,
      'showPostFrom': showPostFrom,
    };
  }

  static Map<String, dynamic> consultationFromAiRouteArgs({
    required String patientId,
  }) {
    return {
      'patientId': patientId,
    };
  }

  static Map<String, dynamic> createPostInCommunityRouteArgs({
    required DoctorModel currentDoctorModel,
    required HomeModelResponse homeDataModel,
    PostCommunityModel? feed,
    String? groupId,
    VoidCallback? onPostUploaded,
  }) {
    return {
      'currentDoctorModel': currentDoctorModel,
      'homeDataModel': homeDataModel,
      'feed': feed,
      'groupId': groupId,
      'onPostUploaded': onPostUploaded,
    };
  }

  static Map<String, dynamic> groupDetailsInCommunityRouteArgs({
    required DoctorModel currentDoctorModel,
    required HomeModelResponse homeDataModel,
    required String groupId,
  }) {
    return {
      'currentDoctorModel': currentDoctorModel,
      'homeDataModel': homeDataModel,
      'groupId': groupId,
    };
  }

  static Map<String, dynamic> allGroupsInCommunityRouteArgs({
    required DoctorModel currentDoctorModel,
    required HomeModelResponse homeDataModel,
  }) {
    return {
      'currentDoctorModel': currentDoctorModel,
      'homeDataModel': homeDataModel,
    };
  }

  static Map<String, dynamic> inviteMemberToGroupInCommunityRouteArgs({
    required DoctorModel currentDoctorModel,
    required HomeModelResponse homeDataModel,
  }) {
    return {
      'currentDoctorModel': currentDoctorModel,
      'homeDataModel': homeDataModel,
    };
  }

  static Map<String, dynamic> createGroupInCommunityRouteArgs({
    required DoctorModel currentDoctorModel,
    required HomeModelResponse homeDataModel,
    required bool isCreateNewGroup,
    GroupModel? groupModel,
  }) {
    return {
      'currentDoctorModel': currentDoctorModel,
      'homeDataModel': homeDataModel,
      'isCreateNewGroup': isCreateNewGroup,
      'groupModel': groupModel,
    };
  }

  static Map<String, dynamic> communitySearchRouteArgs({
    required DoctorModel currentDoctorModel,
    required HomeModelResponse homeDataModel,
    required String? initialValueInSearch,
  }) {
    return {
      'currentDoctorModel': currentDoctorModel,
      'homeDataModel': homeDataModel,
      'initialValueInSearch': initialValueInSearch,
    };
  }

  static Map<String, dynamic> savedPostsRouteArgs({
    required DoctorModel currentDoctorModel,
    required HomeModelResponse homeDataModel,
    required String doctorId,
    required String doctorName,
  }) {
    return {
      'currentDoctorModel': currentDoctorModel,
      'homeDataModel': homeDataModel,
      'doctorId': doctorId,
      'doctorName': doctorName,
    };
  }

  static Map<String, dynamic> allDoctorPostsRouteArgs({
    required DoctorModel currentDoctorModel,
    required HomeModelResponse homeDataModel,
    required String doctorId,
    required String doctorName,
  }) {
    return {
      'currentDoctorModel': currentDoctorModel,
      'homeDataModel': homeDataModel,
      'doctorId': doctorId,
      'doctorName': doctorName,
    };
  }
}
