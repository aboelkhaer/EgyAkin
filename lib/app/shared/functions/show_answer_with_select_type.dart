import '../../constants/app_strings.dart';
import '../../services/localization_service.dart';

String showAnswerWithSelectType(Map<String, dynamic> answer,
    {LocalizationService? localization}) {
  final String answers = answer[AppStrings.answers] ?? '...';
  final String otherField = answer[AppStrings.otherField] ?? '';

  if (answers == AppStrings.others) {
    final loc = localization ?? LocalizationService.instance;
    final label = loc.translate(AppStrings.yourOtherAnswer);
    return '$answers\n\n$label: $otherField';
  }
  return answers;
}
