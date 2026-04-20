import '../../../../exports.dart';
import '../../../../app/services/localization_service.dart';

String convertDynamicToString(QuestionModel question,
    {LocalizationService? localization}) {
  if (question.answer[AppStrings.answers] is String) {
    return question.answer[AppStrings.answers];
  } else {
    List<dynamic>? dynamicList = question.answer[AppStrings.answers];

    if (dynamicList == null) return '...';

    // Create a new list to avoid modifying the original one
    List<dynamic> resultList = List.from(dynamicList);

    // Localized "Your other answer" label
    final loc = localization ?? LocalizationService.instance;
    final otherLabel = loc.translate(AppStrings.yourOtherAnswer);

    // Add "Your other answer" only once when "Others" is selected
    if (resultList.contains(AppStrings.others) &&
        !resultList.any((item) => item.toString().contains(otherLabel))) {
      resultList.add(
        '\n$otherLabel: ${question.answer[AppStrings.otherField] ?? '...'}',
      );
    }

    return resultList.map((item) => item.toString()).join(',\n');
  }
}
