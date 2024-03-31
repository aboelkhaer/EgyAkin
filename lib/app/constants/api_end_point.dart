class ApiEndPoint {
  static const baseUrl = 'https://egyakin.com';
  static const home = '$baseUrl/api/home';
  static const signIn = '$baseUrl/api/login';
  static const register = '$baseUrl/api/register';
  static const logout = '$baseUrl/api/logout';
  static const allPatients = '$baseUrl/api/allPatients';
  static const currentPatientsHome = '$baseUrl/api/currentPatients';
  static const search = '$baseUrl/api/patient/search';
  static const updateProfile = '$baseUrl/api/users';
  static const sections = '$baseUrl/api/section';
  static const question = '$baseUrl/api/questions';
  static const deletePatient = '$baseUrl/api/patientHistory';
  static const updateSectionDetails = '$baseUrl/api/section';
  static const getAddPatientsQuestions = '$baseUrl/api/questions';
  static const addPatientForFirstTime = '$baseUrl/api/patientHistory';
  static const outcome = '$baseUrl/api/outcome';
  static const finalSubmit = '$baseUrl/api/section';
  static const comment = '$baseUrl/api/comment';
  static const contactUs = '$baseUrl/api/contact';
  static const post = '$baseUrl/api/post';
  static const postComments = '$baseUrl/api/Postcomments';
  static const notification = '$baseUrl/api/notification';
  static const getAllNotifications = '$baseUrl/api/shownotification';
  static const forgetPassword = '$baseUrl/api/forgotpassword';
  static const resetPasswordVerification =
      '$baseUrl/api/resetpasswordverification';
  static const changePassword = '$baseUrl/api/resetpassword';
  static const sendEmailVerification = '$baseUrl/api/sendverificationmail';
  static const emailVerificationOTP = '$baseUrl/api/emailverification';
}
