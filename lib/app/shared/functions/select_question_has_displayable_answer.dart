import 'package:egy_akin/app/constants/app_strings.dart';

/// True when a select question has a choice that the dropdown can show: [answers]
/// must match an option in [optionValues], and if it is [AppStrings.others] then
/// [other_field] must be non-empty.
bool selectQuestionHasDisplayableAnswer({
  required List<dynamic>? optionValues,
  required dynamic storedAnswer,
}) {
  if (optionValues == null || optionValues.isEmpty) return false;

  dynamic chosen;
  if (storedAnswer is Map) {
    chosen = storedAnswer[AppStrings.answers];
  } else {
    chosen = storedAnswer;
  }

  if (chosen == null || chosen == '' || chosen == AppStrings.empty) {
    return false;
  }

  if (!optionValues.contains(chosen)) {
    return false;
  }

  if (chosen == AppStrings.others) {
    dynamic other;
    if (storedAnswer is Map) {
      other = storedAnswer[AppStrings.otherField];
    }
    if (other == null ||
        other == '' ||
        other == AppStrings.empty ||
        other.toString().trim().isEmpty) {
      return false;
    }
  }

  return true;
}
