class ApiEndPoint {
  //! test url
  // static const baseUrl = 'https://test.egyakin.com';

  //! production url
  static const baseUrl = 'https://api.egyakin.com';

  static const home = '$baseUrl/api/homeNew';
  static const signIn = '$baseUrl/api/login';
  static const register = '$baseUrl/api/register';
  static const signOut = '$baseUrl/api/logout';
  static const allPatients = '$baseUrl/api/allPatientsNew';
  static const currentPatientsHome = '$baseUrl/api/currentPatientsNew';
  static const search = '$baseUrl/api/searchNew';
  static const updateProfile = '$baseUrl/api/users';
  static const sections = '$baseUrl/api/showSections';
  static const getPatientSectionDetails = '$baseUrl/api/patient';
  static const deletePatient = '$baseUrl/api/patient';
  static const updateSectionDetails = '$baseUrl/api/patientsection';
  static const getAddPatientsQuestions = '$baseUrl/api/questions';
  static const addPatientForFirstTime = '$baseUrl/api/patient';
  static const outcome = '$baseUrl/api/patient';
  static const submitOutcome = '$baseUrl/api/patientsection';
  static const finalSubmit = '$baseUrl/api/submitStatus';
  static const comment = '$baseUrl/api/comment';
  static const contactUs = '$baseUrl/api/contact';
  static const post = '$baseUrl/api/post';
  static const postComments = '$baseUrl/api/Postcomments';
  static const showNotification = '$baseUrl/api/shownotification';
  static const notification = '$baseUrl/api/notification';
  static const getAllNotifications = '$baseUrl/api/shownotification';

  static const forgetPassword = '$baseUrl/api/forgotpassword';
  static const resetPasswordVerification =
      '$baseUrl/api/resetpasswordverification';
  static const changePassword = '$baseUrl/api/resetpassword';
  static const sendEmailVerification = '$baseUrl/api/sendverificationmail';
  static const sendOTPForEmailVerification = '$baseUrl/api/emailverification';
  static const uploadProfileImage = '$baseUrl/api/upload-profile-image';
  static const getDoctorInfoView = '$baseUrl/api/showAnotherProfile';
  static const downloadPatientReport = '$baseUrl/api/generatePDF';
  static const appSettings = '$baseUrl/api/settings';
  static const uploadSyndicateCard = '$baseUrl/api/uploadSyndicateCard';
  static const changePasswordFeature = '$baseUrl/api/changePassword';
  static const getPatientForSpecificDoctor =
      '$baseUrl/api/doctorProfileGetPatients';
  static const sendFCMToken = '$baseUrl/api/storeFCM';
  static const doctorProfileGetPatients =
      '$baseUrl/api/doctorProfileGetPatients';
  static const doctorProfileGetScoreHistory =
      '$baseUrl/api/doctorProfileGetScoreHistory';
  static const uploadFileNew = '$baseUrl/api/uploadFileNew';
  static const consultationDoctorSearch =
      '$baseUrl/api/consultationDoctorSearch';
  static const createConsultation = '$baseUrl/api/consultations';
  static const getCurrentDoctorConsultation = '$baseUrl/api/consultations/sent';
  static const getReceivedConsultation = '$baseUrl/api/consultations/received';
  static const getConsultationDetails = '$baseUrl/api/consultations';
  static const addConsultationReply = '$baseUrl/api/consultations';
  static String getAchievements(String doctorId) {
    return '$baseUrl/api/users/$doctorId/achievements';
  }

  static const syndicateCardVerifyRequest = '$baseUrl/api/users';
  static const blockDoctor = '$baseUrl/api/users';
  static const verifyDoctorEmail = '$baseUrl/api/users';
  static const getPatientFilters = '$baseUrl/api/patientFilters';
  static const applyPatientsFilter = '$baseUrl/api/patientFilters';
  static const getAllFeeds = '$baseUrl/api/feed/posts';
  static const addLikeOnPost = '$baseUrl/api/feed/posts';
  static const saveOrUnsavePost = '$baseUrl/api/feed/posts';
  static const getAIConsultationHistory = '$baseUrl/api/AIconsultation-history';
  static const sendAIConsultationRequest = '$baseUrl/api/AIconsultation';
  static const deletePostInFeeds = '$baseUrl/api/feed/posts';
  static const createPostInCommunity = '$baseUrl/api/feed/posts';
  static const getCommentsInCommunity = '$baseUrl/api/posts';
  static const addLikeAndUnlikeOnCommentInCommunity = '$baseUrl/api/comments';
  static const createCommentOnPostInCommunity = '$baseUrl/api/feed/posts';
  static const deleteCommentOnPostInCommunity = '$baseUrl/api/feed/comments';
  static const editPostInCommunity = '$baseUrl/api/feed/posts';
  static const createReplyOnCommentInCommunity = '$baseUrl/api/feed/posts';
  static const getGroupDetailsInCommunity = '$baseUrl/api/groups';
  static const getGroupsTab = '$baseUrl/api/latest-groups-with-random-posts';
  static const joinGroupInCommunity = '$baseUrl/api/groups';
  static const leaveGroupInCommunity = '$baseUrl/api/groups';
  static const getGroupMembers = '$baseUrl/api/groups';
  static const getPostLikes = '$baseUrl/api/posts';
  static const getMyGroups = '$baseUrl/api/mygroups';
  static const sendGroupInvitation = '$baseUrl/api/groups';
  static const removeMemberFromGroup = '$baseUrl/api/groups';
  static const getAllGroups = '$baseUrl/api/groups';
  static const createGroupInCommunity = '$baseUrl/api/groups';
  static const updateGroupInCommunity = '$baseUrl/api/groups';
  static const deleteGroupInCommunity = '$baseUrl/api/groups';
  static const getTrendingPostsInCommunity = '$baseUrl/api/feed/trendingPosts';
  static const getCommunitySearchResponse = '$baseUrl/api/feed/searchPosts';
  static const getAllDoctorPosts = '$baseUrl/api/doctorposts';
  static const getSavedPosts = '$baseUrl/api/doctorsavedposts';
  static const addVoteForPollInPosts = '$baseUrl/api/polls';
  static const addOptionOnPoll = '$baseUrl/api/polls';
  static const getPollVoters = '$baseUrl/api/polls';
  static const getDoctorInvitationsForGroups =
      '$baseUrl/api/groups/invitations';
  static const acceptOrDeclineMemberInGroup = '$baseUrl/api/groups';
  static const getPostById = '$baseUrl/api/feed/posts';
  static const getRecommendations = '$baseUrl/api/recommendations';
  static const createPatientRecommendation = '$baseUrl/api/recommendations';
  static const searchForDoseInMedicationSection = '$baseUrl/api/dose/search';
  static const deletePatientRecommendation = '$baseUrl/api/recommendations';
  static const updatePatientRecommendation = '$baseUrl/api/recommendations';
  static const createNewMedicine = '$baseUrl/api/dose';
}
