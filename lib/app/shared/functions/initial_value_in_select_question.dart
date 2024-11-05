dynamic initialValueInSelectQuestion({
  required dynamic questionAnswer,
  required dynamic selectedValue,
  required List<dynamic> values,
}) {
  if (selectedValue != null &&
      selectedValue != '' &&
      values.contains(selectedValue)) {
    return selectedValue;
  }
  if (questionAnswer != null &&
      questionAnswer != '' &&
      values.contains(questionAnswer)) {
    return questionAnswer;
  }
  return null;
}
