import '../../../../exports.dart';

String convertDynamicToString(QuestionModel question) {
  if (question.answer[AppStrings.answers] is String) {
    return question.answer[AppStrings.answers];
  } else {
    List<dynamic>? dynamicList = question.answer[AppStrings.answers];

    if (dynamicList == null) return '...';

    // Create a new list to avoid modifying the original one
    List<dynamic> resultList = List.from(dynamicList);

    // Add "Other answer:" only once
    if (resultList.contains('Others') &&
        !resultList.any((item) => item.toString().contains('Other answer:'))) {
      resultList.add(
          '\nOther answer: ${question.answer[AppStrings.otherField] ?? '...'}');
    }

    return resultList
        .map((item) =>
            item.toString().contains('Other answer:') ? item : '$item')
        .join(',\n');
  }
}
