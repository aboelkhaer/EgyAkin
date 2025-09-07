class ApiEndPoint {
  //! test url
  static const baseUrl = 'https://test.egyakin.com';

  //! production url
  // static const baseUrl = 'https://api.egyakin.com';

  // versioning
  static const versioning = 'v1';

  static const home = '$baseUrl/api/$versioning/homeNew';
  static const signIn = '$baseUrl/api/$versioning/login';
  static const register = '$baseUrl/api/$versioning/register';
  static const signOut = '$baseUrl/api/$versioning/logout';
  static const allPatients = '$baseUrl/api/$versioning/allPatientsNew';
  static const currentPatientsHome = '$baseUrl/api/$versioning/currentPatientsNew';
  static const search = '$baseUrl/api/$versioning/searchNew';
  static const updateProfile = '$baseUrl/api/$versioning/users';
  static const sections = '$baseUrl/api/$versioning/showSections';
  static const getPatientSectionDetails = '$baseUrl/api/$versioning/patient';
  static const deletePatient = '$baseUrl/api/$versioning/patient';
  static const updateSectionDetails = '$baseUrl/api/$versioning/patientsection';
  static const getAddPatientsQuestions = '$baseUrl/api/$versioning/questions';
  static const addPatientForFirstTime = '$baseUrl/api/$versioning/patient';
  static const outcome = '$baseUrl/api/$versioning/patient';
  static const submitOutcome = '$baseUrl/api/$versioning/patientsection';
  static const finalSubmit = '$baseUrl/api/$versioning/submitStatus';
  static const comment = '$baseUrl/api/$versioning/comment';
  static const contactUs = '$baseUrl/api/$versioning/contact';
  static const post = '$baseUrl/api/$versioning/post';
  static const postComments = '$baseUrl/api/$versioning/Postcomments';
  static const showNotification = '$baseUrl/api/$versioning/shownotification';
  static const notification = '$baseUrl/api/$versioning/notification';
  static const getAllNotifications = '$baseUrl/api/$versioning/shownotification';
  static const forgetPassword = '$baseUrl/api/$versioning/forgotpassword';
  static const resetPasswordVerification =
      '$baseUrl/api/$versioning/resetpasswordverification';
  static const changePassword = '$baseUrl/api/$versioning/resetpassword';
  static const sendEmailVerification = '$baseUrl/api/$versioning/sendverificationmail';
  static const sendOTPForEmailVerification = '$baseUrl/api/$versioning/emailverification';
  static const uploadProfileImage = '$baseUrl/api/$versioning/upload-profile-image';
  static const getDoctorInfoView = '$baseUrl/api/$versioning/showAnotherProfile';
  static const downloadPatientReport = '$baseUrl/api/$versioning/generatePDF';
  static const appSettings = '$baseUrl/api/$versioning/settings';
  static const uploadSyndicateCard = '$baseUrl/api/$versioning/uploadSyndicateCard';
  static const changePasswordFeature = '$baseUrl/api/$versioning/changePassword';
  static const getPatientForSpecificDoctor =
      '$baseUrl/api/$versioning/doctorProfileGetPatients';
  static const sendFCMToken = '$baseUrl/api/$versioning/storeFCM';
  static const doctorProfileGetPatients =
      '$baseUrl/api/$versioning/doctorProfileGetPatients';
  static const doctorProfileGetScoreHistory =
      '$baseUrl/api/$versioning/doctorProfileGetScoreHistory';
  static const uploadFileNew = '$baseUrl/api/$versioning/uploadFileNew';
  static const consultationDoctorSearch =
      '$baseUrl/api/$versioning/consultationDoctorSearch';
  static const createConsultation = '$baseUrl/api/$versioning/consultations';
  static const getCurrentDoctorConsultation = '$baseUrl/api/$versioning/consultations/sent';
  static const getReceivedConsultation = '$baseUrl/api/$versioning/consultations/received';
  static const getConsultationDetails = '$baseUrl/api/$versioning/consultations';
  static const addConsultationReply = '$baseUrl/api/$versioning/consultations';
  static String getAchievements(String doctorId) {
    return '$baseUrl/api/$versioning/users/$doctorId/achievements';
  }

  static const syndicateCardVerifyRequest = '$baseUrl/api/$versioning/users';
  static const blockDoctor = '$baseUrl/api/$versioning/users';
  static const verifyDoctorEmail = '$baseUrl/api/$versioning/users';
  static const getPatientFilters = '$baseUrl/api/$versioning/patientFilters';
  static const applyPatientsFilter = '$baseUrl/api/$versioning/patientFilters';
  static const getAllFeeds = '$baseUrl/api/$versioning/feed/posts';
  static const addLikeOnPost = '$baseUrl/api/$versioning/feed/posts';
  static const saveOrUnsavePost = '$baseUrl/api/$versioning/feed/posts';
  static const getAIConsultationHistory = '$baseUrl/api/$versioning/AIconsultation-history';
  static const sendAIConsultationRequest = '$baseUrl/api/$versioning/AIconsultation';
  static const deletePostInFeeds = '$baseUrl/api/$versioning/feed/posts';
  static const createPostInCommunity = '$baseUrl/api/$versioning/feed/posts';
  static const getCommentsInCommunity = '$baseUrl/api/$versioning/posts';
  static const addLikeAndUnlikeOnCommentInCommunity = '$baseUrl/api/$versioning/comments';
  static const createCommentOnPostInCommunity = '$baseUrl/api/$versioning/feed/posts';
  static const deleteCommentOnPostInCommunity = '$baseUrl/api/$versioning/feed/comments';
  static const editPostInCommunity = '$baseUrl/api/$versioning/feed/posts';
  static const createReplyOnCommentInCommunity = '$baseUrl/api/$versioning/feed/posts';
  static const getGroupDetailsInCommunity = '$baseUrl/api/$versioning/groups';
  static const getGroupsTab = '$baseUrl/api/$versioning/latest-groups-with-random-posts';
  static const joinGroupInCommunity = '$baseUrl/api/$versioning/groups';
  static const leaveGroupInCommunity = '$baseUrl/api/$versioning/groups';
  static const getGroupMembers = '$baseUrl/api/$versioning/groups';
  static const getPostLikes = '$baseUrl/api/$versioning/posts';
  static const getMyGroups = '$baseUrl/api/$versioning/mygroups';
  static const sendGroupInvitation = '$baseUrl/api/$versioning/groups';
  static const removeMemberFromGroup = '$baseUrl/api/$versioning/groups';
  static const getAllGroups = '$baseUrl/api/$versioning/groups';
  static const createGroupInCommunity = '$baseUrl/api/$versioning/groups';
  static const updateGroupInCommunity = '$baseUrl/api/$versioning/groups';
  static const deleteGroupInCommunity = '$baseUrl/api/$versioning/groups';
  static const getTrendingPostsInCommunity = '$baseUrl/api/$versioning/feed/trendingPosts';
  static const getCommunitySearchResponse = '$baseUrl/api/$versioning/feed/searchPosts';
  static const getAllDoctorPosts = '$baseUrl/api/$versioning/doctorposts';
  static const getSavedPosts = '$baseUrl/api/$versioning/doctorsavedposts';
  static const addVoteForPollInPosts = '$baseUrl/api/$versioning/polls';
  static const addOptionOnPoll = '$baseUrl/api/$versioning/polls';
  static const getPollVoters = '$baseUrl/api/$versioning/polls';
  static const getDoctorInvitationsForGroups =
      '$baseUrl/api/$versioning/groups/invitations';
  static const acceptOrDeclineMemberInGroup = '$baseUrl/api/$versioning/groups';
  static const getPostById = '$baseUrl/api/$versioning/feed/posts';
  static const getRecommendations = '$baseUrl/api/$versioning/recommendations';
  static const createPatientRecommendation = '$baseUrl/api/$versioning/recommendations';
  static const searchForDoseInMedicationSection = '$baseUrl/api/$versioning/dose/search';
  static const deletePatientRecommendation = '$baseUrl/api/$versioning/recommendations';
  static const updatePatientRecommendation = '$baseUrl/api/$versioning/recommendations';
  static const createNewMedicine = '$baseUrl/api/$versioning/dose';
  static const getMembersForConsultation = '$baseUrl/api/$versioning/consultations';
  static const lockOrUnlockConsultation = '$baseUrl/api/$versioning/consultations';
  static const removeMemberFromConsultation = '$baseUrl/api/$versioning/consultations';
  static const addDoctorsForConsultation = '$baseUrl/api/$versioning/consultations';
  
}
