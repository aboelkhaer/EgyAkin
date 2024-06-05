import 'package:egy_akin/exports.dart';

String initialValueInQuestions({
  required String question,
  required dynamic answer,
  required String currentDoctorId,
  required String doctorId,
  required dynamic questionAnswerInForm,
}) {
  if (answer == null) return '';
  if (question == AppStrings.nationalID) {
    if (currentDoctorId.trim() == doctorId.trim()) {
      return questionAnswerInForm ?? answer;
    }
    if (currentDoctorId.trim() != doctorId.trim()) {
      return hideNationalId(answer);
    }
  }
  if (questionAnswerInForm != null) {
    return questionAnswerInForm;
  }
  return answer;
}
