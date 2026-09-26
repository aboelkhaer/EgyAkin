import '../../constants/app_strings.dart';
import '../../services/localization_service.dart';

String showAnswerWithSelectType(Map<String, dynamic> answer,
    {LocalizationService? localization}) {
  final rawAnswers = answer[AppStrings.answers];
  final String answers =
      rawAnswers == null ? '...' : rawAnswers.toString();
  final rawOther = answer[AppStrings.otherField];
  final String otherField = rawOther == null ? '' : rawOther.toString();

  if (answers == AppStrings.others) {
    final loc = localization ?? LocalizationService.instance;
    final label = loc.translate(AppStrings.yourOtherAnswer);
    return '$answers\n\n$label: $otherField';
  }
  return answers;
}
