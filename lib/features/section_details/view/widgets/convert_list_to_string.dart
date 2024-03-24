import '../../../../exports.dart';

String convertDynamicToString(BaseQuestionModel question) {
  List<dynamic>? dynamicList = question.answer[AppStrings.answers];

  if (dynamicList == null) return '...';

  if (dynamicList.contains('Others') &&
      !dynamicList.contains('Other answer:')) {
    dynamicList.remove('Others');
    dynamicList
        .add('\nOther answer: ${question.answer[AppStrings.otherField]}');
  }

  return dynamicList
      .map((item) => item.toString().contains('Other answer:') ? item : '$item')
      .join(',\n');
}
