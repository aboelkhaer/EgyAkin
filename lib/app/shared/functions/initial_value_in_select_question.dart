dynamic initialValueInSelectQuestion(
    {required dynamic questionAnswer, required dynamic selectedValue}) {
  if ((questionAnswer == null || questionAnswer == '') &&
      (selectedValue == null || selectedValue == '')) {
    return null;
  }
  if (selectedValue != null && selectedValue != '') {
    return selectedValue;
  }
  if (questionAnswer != null && questionAnswer != '') {
    return questionAnswer;
  }
  return null;
}
