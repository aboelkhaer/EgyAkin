import 'package:egy_akin/app/shared/functions/hide_email.dart';
import 'package:egy_akin/exports.dart';

String initialValueInQuestions({
  required String question,
  required dynamic answer,
  required String currentDoctorId,
  required String doctorId,
  required bool isAllDataOpen,
  required dynamic questionAnswerInForm,
  required String currentDoctorRole,
}) {
  if (answer == null) return '';
  if (question == AppStrings.nationalID) {
    if (currentDoctorId.trim() == doctorId.trim() ||
        currentDoctorRole == AppStrings.roleAdmin) {
      return questionAnswerInForm ?? answer;
    }
    if (currentDoctorId.trim() != doctorId.trim()) {
      return hideNationalId(answer);
    }
  }
  if (question == 'Name') {
    if (currentDoctorId.trim() != doctorId.trim() &&
        currentDoctorRole != AppStrings.roleAdmin &&
        isAllDataOpen == false) {
      return convertTextToSymbols(answer);
    }
  }
  if (question == 'Phone') {
    if (currentDoctorId.trim() != doctorId.trim() &&
        currentDoctorRole != AppStrings.roleAdmin &&
        isAllDataOpen == false) {
      return hideNationalId(answer);
    }
  }
  if (question == 'Email') {
    if (currentDoctorId.trim() != doctorId.trim() &&
        currentDoctorRole != AppStrings.roleAdmin &&
        isAllDataOpen == false) {
      return hideEmail(answer);
    }
  }

  if (questionAnswerInForm != null) {
    return questionAnswerInForm;
  }
  return answer;
}
