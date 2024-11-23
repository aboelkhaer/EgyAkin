String showAnswerWithSelectType(Map<String, dynamic> answer) {
  final String answers = answer['answers'] ?? '...';
  final String otherField = answer['other_field'] ?? '';

  if (answers == 'Others') {
    return '$answers\n\nOther Answer: $otherField';
  }
  return answers;
}
