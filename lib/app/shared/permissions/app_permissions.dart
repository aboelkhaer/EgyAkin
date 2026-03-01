enum AppPermissions {
  //! Home & Dashboard
  accessHome,

  //! Patient Management
  viewAllPatients,
  viewCurrentPatients,
  searchPatients,
  viewPatientSections,
  viewPatientDetails,
  createPatient,
  updatePatientSection,
  deletePatient,
  getPatientQuestions,
  submitPatientOutcome,
  finalSubmitPatient,
  generatePatientPdf,
  markPatient,
  unmarkPatient,
  applyPatientFilters,
  getPatientFilters,
  exportFilteredPatients,

  //! Patient Comments
  viewPatientComments,
  createPatientComment,
  deletePatientComment,

  //! Recommendations
  viewRecommendations,
  createRecommendation,
  updateRecommendation,
  deleteRecommendation,

  //! Doses / Medications
  searchDoses,
  createDose,

  //! User Profile
  updateProfile,
  uploadProfileImage,
  uploadSyndicateCard,
  changePassword,
  viewDoctorProfile,
  viewDoctorPatients,
  viewDoctorScoreHistory,
  viewDoctorAchievements,

  //! Admin Management
  verifySyndicateCard,
  blockUser,
  verifyUserEmail,

  //! File Uploads
  uploadPatientFiles,

  //! Consultations
  searchConsultationDoctors,
  createConsultation,
  viewSentConsultations,
  viewReceivedConsultations,
  viewConsultationDetails,
  replyConsultation,
  viewConsultationMembers,
  toggleConsultationStatus,
  removeConsultationMember,
  addConsultationDoctors,

  //! AI Consultations
  viewAiConsultationHistory,
  sendAiConsultation,

  //! Feed Posts
  viewFeedPosts,
  createFeedPost,
  editFeedPost,
  deleteFeedPost,
  likeFeedPost,
  saveFeedPost,
  viewFeedPost,
  viewTrendingPosts,
  searchFeedPosts,
  viewDoctorPosts,
  viewSavedPosts,
  viewPostLikes,

  //! Feed Comments
  viewFeedComments,
  createFeedComment,
  deleteFeedComment,
  likeFeedComment,
  replyFeedComment,

  //! Legacy Posts
  viewLegacyPosts,
  viewLegacyPostComments,
  createLegacyPostComment,
  deleteLegacyPostComment,

  //! Groups
  viewGroups,
  viewGroupsTab,
  viewGroupDetails,
  createGroup,
  updateGroup,
  deleteGroup,
  joinGroup,
  leaveGroup,
  viewGroupMembers,
  viewMyGroups,
  sendGroupInvitation,
  removeGroupMember,
  viewGroupInvitations,
  handleGroupInvitation,

  //! Polls
  votePoll,
  addPollOption,
  viewPollVoters,

  //! Others
  viewTopDoctors,
  viewYourPatients,
  viewDoctorInfo,
  viewPatientsName,
  viewExploreCommunityButton,
  viewHomeSlider,
  viewTrendHashtagsInHome,
  viewGroupsInHome,
  viewClearUpdateMessageButtonInMore,
  viewDoctorActivationForAdmin,
  viewAchievementsInHomeProfile,
  addPostInHome,
  addPatientInHome,
  viewNationalIdForAdmin,
  viewSubmitButtonForAdminInPatientSectionDetails,
  deleteGroupForAdmin,
  updateGroupForAdmin,
  viewGroupMembersForAdmin,
  hasPendingInvitationsForAdmin,
  viewEditAndDeletePostForAdmin,
  viewAdminSideInProfiles,
  viewConsultationInHomeProfile,
  viewDoseOptionInHomeSearch,
  viewPatientOptionInHomeSearch,
  viewExportPatientsButtonInAllPatientsForAdmin,
}

extension PermissionMapper on String {
  AppPermissions? toPermission() {
    switch (this) {
      //! Home
      case 'access-home':
        return AppPermissions.accessHome;

      //! Patients
      case 'view-all-patients':
        return AppPermissions.viewAllPatients;
      case 'view-current-patients':
        return AppPermissions.viewCurrentPatients;
      case 'search-patients':
        return AppPermissions.searchPatients;
      case 'view-patient-sections':
        return AppPermissions.viewPatientSections;
      case 'view-patient-details':
        return AppPermissions.viewPatientDetails;
      case 'create-patient':
        return AppPermissions.createPatient;
      case 'update-patient-section':
        return AppPermissions.updatePatientSection;
      case 'delete-patient':
        return AppPermissions.deletePatient;
      case 'get-patient-questions':
        return AppPermissions.getPatientQuestions;
      case 'submit-patient-outcome':
        return AppPermissions.submitPatientOutcome;
      case 'final-submit-patient':
        return AppPermissions.finalSubmitPatient;
      case 'generate-patient-pdf':
        return AppPermissions.generatePatientPdf;
      case 'mark-patient':
        return AppPermissions.markPatient;
      case 'unmark-patient':
        return AppPermissions.unmarkPatient;
      case 'apply-patient-filters':
        return AppPermissions.applyPatientFilters;
      case 'get-patient-filters':
        return AppPermissions.getPatientFilters;
      case 'export-filtered-patients':
        return AppPermissions.exportFilteredPatients;

      //! Patient Comments
      case 'view-patient-comments':
        return AppPermissions.viewPatientComments;
      case 'create-patient-comment':
        return AppPermissions.createPatientComment;
      case 'delete-patient-comment':
        return AppPermissions.deletePatientComment;

      //! Recommendations
      case 'view-recommendations':
        return AppPermissions.viewRecommendations;
      case 'create-recommendation':
        return AppPermissions.createRecommendation;
      case 'update-recommendation':
        return AppPermissions.updateRecommendation;
      case 'delete-recommendation':
        return AppPermissions.deleteRecommendation;

      //! Doses
      case 'search-doses':
        return AppPermissions.searchDoses;
      case 'create-dose':
        return AppPermissions.createDose;

      //! Profile
      case 'update-profile':
        return AppPermissions.updateProfile;
      case 'upload-profile-image':
        return AppPermissions.uploadProfileImage;
      case 'upload-syndicate-card':
        return AppPermissions.uploadSyndicateCard;
      case 'change-password':
        return AppPermissions.changePassword;
      case 'view-doctor-profile':
        return AppPermissions.viewDoctorProfile;
      case 'view-doctor-patients':
        return AppPermissions.viewDoctorPatients;
      case 'view-doctor-score-history':
        return AppPermissions.viewDoctorScoreHistory;
      case 'view-doctor-achievements':
        return AppPermissions.viewDoctorAchievements;

      //! Admin
      case 'verify-syndicate-card':
        return AppPermissions.verifySyndicateCard;
      case 'block-user':
        return AppPermissions.blockUser;
      case 'verify-user-email':
        return AppPermissions.verifyUserEmail;

      //! Files
      case 'upload-patient-files':
        return AppPermissions.uploadPatientFiles;

      //! Consultations
      case 'search-consultation-doctors':
        return AppPermissions.searchConsultationDoctors;
      case 'create-consultation':
        return AppPermissions.createConsultation;
      case 'view-sent-consultations':
        return AppPermissions.viewSentConsultations;
      case 'view-received-consultations':
        return AppPermissions.viewReceivedConsultations;
      case 'view-consultation-details':
        return AppPermissions.viewConsultationDetails;
      case 'reply-consultation':
        return AppPermissions.replyConsultation;
      case 'view-consultation-members':
        return AppPermissions.viewConsultationMembers;
      case 'toggle-consultation-status':
        return AppPermissions.toggleConsultationStatus;
      case 'remove-consultation-member':
        return AppPermissions.removeConsultationMember;
      case 'add-consultation-doctors':
        return AppPermissions.addConsultationDoctors;

      //! AI
      case 'view-ai-consultation-history':
        return AppPermissions.viewAiConsultationHistory;
      case 'send-ai-consultation':
        return AppPermissions.sendAiConsultation;

      //! Feed
      case 'view-feed-posts':
        return AppPermissions.viewFeedPosts;
      case 'create-feed-post':
        return AppPermissions.createFeedPost;
      case 'edit-feed-post':
        return AppPermissions.editFeedPost;
      case 'delete-feed-post':
        return AppPermissions.deleteFeedPost;
      case 'like-feed-post':
        return AppPermissions.likeFeedPost;
      case 'save-feed-post':
        return AppPermissions.saveFeedPost;
      case 'view-feed-post':
        return AppPermissions.viewFeedPost;
      case 'view-trending-posts':
        return AppPermissions.viewTrendingPosts;
      case 'search-feed-posts':
        return AppPermissions.searchFeedPosts;
      case 'view-doctor-posts':
        return AppPermissions.viewDoctorPosts;
      case 'view-saved-posts':
        return AppPermissions.viewSavedPosts;
      case 'view-post-likes':
        return AppPermissions.viewPostLikes;

      //! Feed Comments
      case 'view-feed-comments':
        return AppPermissions.viewFeedComments;
      case 'create-feed-comment':
        return AppPermissions.createFeedComment;
      case 'delete-feed-comment':
        return AppPermissions.deleteFeedComment;
      case 'like-feed-comment':
        return AppPermissions.likeFeedComment;
      case 'reply-feed-comment':
        return AppPermissions.replyFeedComment;

      //! Legacy
      case 'view-legacy-posts':
        return AppPermissions.viewLegacyPosts;
      case 'view-legacy-post-comments':
        return AppPermissions.viewLegacyPostComments;
      case 'create-legacy-post-comment':
        return AppPermissions.createLegacyPostComment;
      case 'delete-legacy-post-comment':
        return AppPermissions.deleteLegacyPostComment;

      //! Groups
      case 'view-groups':
        return AppPermissions.viewGroups;
      case 'view-groups-tab':
        return AppPermissions.viewGroupsTab;
      case 'view-group-details':
        return AppPermissions.viewGroupDetails;
      case 'create-group':
        return AppPermissions.createGroup;
      case 'update-group':
        return AppPermissions.updateGroup;
      case 'delete-group':
        return AppPermissions.deleteGroup;
      case 'join-group':
        return AppPermissions.joinGroup;
      case 'leave-group':
        return AppPermissions.leaveGroup;
      case 'view-group-members':
        return AppPermissions.viewGroupMembers;
      case 'view-my-groups':
        return AppPermissions.viewMyGroups;
      case 'send-group-invitation':
        return AppPermissions.sendGroupInvitation;
      case 'remove-group-member':
        return AppPermissions.removeGroupMember;
      case 'view-group-invitations':
        return AppPermissions.viewGroupInvitations;
      case 'handle-group-invitation':
        return AppPermissions.handleGroupInvitation;

      //! Polls
      case 'vote-poll':
        return AppPermissions.votePoll;
      case 'add-poll-option':
        return AppPermissions.addPollOption;
      case 'view-poll-voters':
        return AppPermissions.viewPollVoters;

      //! Others
      case 'view-top-doctors':
        return AppPermissions.viewTopDoctors;
      case 'view-your-patients':
        return AppPermissions.viewYourPatients;
      case 'view-doctor-info':
        return AppPermissions.viewDoctorInfo;
      case 'view-patients-name':
        return AppPermissions.viewPatientsName;
      case 'view-explore-community-button':
        return AppPermissions.viewExploreCommunityButton;
      case 'view-home-slider':
        return AppPermissions.viewHomeSlider;
      case 'view-trend-hashtags-in-home':
        return AppPermissions.viewTrendHashtagsInHome;
      case 'view-groups-in-home':
        return AppPermissions.viewGroupsInHome;
      case 'view-clear-update-message-button-in-more':
        return AppPermissions.viewClearUpdateMessageButtonInMore;
      case 'view-doctor-activation-for-admin':
        return AppPermissions.viewDoctorActivationForAdmin;
      case 'view-achievements-in-home-profile':
        return AppPermissions.viewAchievementsInHomeProfile;
      case 'add-post-in-home':
        return AppPermissions.addPostInHome;
      case 'add-patient-in-home':
        return AppPermissions.addPatientInHome;
      case 'view-national-id-for-admin':
        return AppPermissions.viewNationalIdForAdmin;
      case 'view-submit-button-for-admin-in-patient-section-details':
        return AppPermissions.viewSubmitButtonForAdminInPatientSectionDetails;
      case 'delete-group-for-admin':
        return AppPermissions.deleteGroupForAdmin;

      case 'update-group-for-admin':
        return AppPermissions.updateGroupForAdmin;
      case 'view-group-members-for-admin':
        return AppPermissions.viewGroupMembersForAdmin;

      case 'has-pending-invitations-for-admin':
        return AppPermissions.hasPendingInvitationsForAdmin;

      case 'view-edit-and-delete-post-for-admin':
        return AppPermissions.viewEditAndDeletePostForAdmin;
      case 'view-admin-side-in-profiles':
        return AppPermissions.viewAdminSideInProfiles;

      case 'view-consultation-in-home-profile':
        return AppPermissions.viewConsultationInHomeProfile;

      case 'view-dose-option-in-home-search':
        return AppPermissions.viewDoseOptionInHomeSearch;

      case 'view-patient-option-in-home-search':
        return AppPermissions.viewPatientOptionInHomeSearch;

      case 'view-export-patients-report-in-all-patients-button-for-admin':
        return AppPermissions.viewExportPatientsButtonInAllPatientsForAdmin;



      default:
        return null;
    }
  }
}
