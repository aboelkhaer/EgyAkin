class ApiEndPoint {
  // static const baseUrl = 'https://egyakin.com';
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
  // Todo: return to patientsection ,    uploadFileNew
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
}
