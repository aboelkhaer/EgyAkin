import '../../../../exports.dart';

dynamic _readOtherFieldFromMap(Map map) {
  return map[AppStrings.otherField] ?? map['otherField'] ?? map['other_field'];
}

Map<String, dynamic> multipleAnswerPayload({
  required List<dynamic> answers,
  required dynamic otherText,
}) {
  final answersList = List<dynamic>.from(answers);
  final hasOthers = answersList.contains(AppStrings.others);
  return {
    AppStrings.answers: answersList,
    AppStrings.otherField:
        hasOthers ? (otherText?.toString() ?? AppStrings.empty) : AppStrings.empty,
  };
}

/// Merges saved [questionAnswer] with in-session [formEntry] (form wins when non-empty).
Map<String, dynamic> resolveMultipleAnswerMap({
  required dynamic questionAnswer,
  required dynamic formEntry,
}) {
  final saved = normalizeMultipleQuestionAnswer(questionAnswer);
  if (formEntry == null) return saved;

  final edited = normalizeMultipleQuestionAnswer(formEntry);

  final savedAnswers = saved[AppStrings.answers];
  final editedAnswers = edited[AppStrings.answers];

  List<dynamic> answers;
  if (editedAnswers is List && editedAnswers.isNotEmpty) {
    answers = List<dynamic>.from(editedAnswers);
  } else if (savedAnswers is List && savedAnswers.isNotEmpty) {
    answers = List<dynamic>.from(savedAnswers);
  } else {
    answers = <dynamic>[];
  }

  final savedOther = (saved[AppStrings.otherField] ?? '').toString();
  final editedOther = (edited[AppStrings.otherField] ?? '').toString();
  final otherText = editedOther.isNotEmpty ? editedOther : savedOther;

  return {
    AppStrings.answers: answers,
    AppStrings.otherField: otherText,
  };
}

Map<String, dynamic> normalizeMultipleQuestionAnswer(dynamic rawAnswer) {
  if (rawAnswer is Map) {
    final map = Map<String, dynamic>.from(
      rawAnswer.map((key, value) => MapEntry(key.toString(), value)),
    );
    return {
      AppStrings.answers: map[AppStrings.answers] ?? <dynamic>[],
      AppStrings.otherField:
          _readOtherFieldFromMap(map)?.toString() ?? AppStrings.empty,
    };
  }

  if (rawAnswer is List) {
    return {
      AppStrings.answers: List<dynamic>.from(rawAnswer),
      AppStrings.otherField: AppStrings.empty,
    };
  }

  if (rawAnswer is String) {
    return {
      AppStrings.answers: rawAnswer,
      AppStrings.otherField: AppStrings.empty,
    };
  }

  return {
    AppStrings.answers: <dynamic>[],
    AppStrings.otherField: AppStrings.empty,
  };
}

bool multipleAnswerHasSelections(Map<String, dynamic> normalized) {
  final answers = normalized[AppStrings.answers];
  if (answers is List) return answers.isNotEmpty;
  if (answers is String) return answers.trim().isNotEmpty;
  return false;
}

bool multipleAnswerNeedsOtherText(Map<String, dynamic> normalized) {
  final answers = normalized[AppStrings.answers];
  final Iterable<dynamic> selected;
  if (answers is List) {
    selected = answers;
  } else if (answers is String && answers.isNotEmpty) {
    selected = [answers];
  } else {
    return false;
  }

  if (!selected.contains(AppStrings.others)) return false;

  final other = normalized[AppStrings.otherField];
  return other == null ||
      other == AppStrings.empty ||
      other.toString().trim().isEmpty;
}

bool hasValidMultipleAnswer({
  dynamic storedInForm,
  dynamic storedOnQuestion,
}) {
  for (final raw in [storedInForm, storedOnQuestion]) {
    if (raw == null) continue;
    final normalized = normalizeMultipleQuestionAnswer(raw);
    if (!multipleAnswerHasSelections(normalized)) continue;
    if (multipleAnswerNeedsOtherText(normalized)) continue;
    return true;
  }
  return false;
}

/// Prefer [youMustAddOthersFieldIn] when selections exist but "Others" text is missing.
String multipleValidationMessageKey({
  dynamic storedInForm,
  dynamic storedOnQuestion,
}) {
  for (final raw in [storedInForm, storedOnQuestion]) {
    if (raw == null) continue;
    final normalized = normalizeMultipleQuestionAnswer(raw);
    if (multipleAnswerHasSelections(normalized) &&
        multipleAnswerNeedsOtherText(normalized)) {
      return AppStrings.youMustAddOthersFieldIn;
    }
  }
  return AppStrings.youMustSelectAtLeastOneChoice;
}

/// Ensures multiple-question [formData] entries are sent as `{ answers, other_field }`.
Map<String, dynamic> sanitizeMultipleAnswersInFormData(
  Map<String, dynamic> rawFormData,
  List<QuestionModel> questions,
) {
  final sanitized = Map<String, dynamic>.from(rawFormData);

  for (final question in questions) {
    final id = question.id?.toString();
    if (id == null) continue;
    final isMultiple = question.type == AppStrings.questionTypeMultiple ||
        question.type == AppStrings.multipleType;
    if (!isMultiple || !sanitized.containsKey(id)) continue;

    final normalized = normalizeMultipleQuestionAnswer(sanitized[id]);
    final answers = normalized[AppStrings.answers];
    final List<dynamic> answersList;
    if (answers is List) {
      answersList = List<dynamic>.from(answers);
    } else if (answers is String && answers.isNotEmpty) {
      answersList = [answers];
    } else {
      answersList = <dynamic>[];
    }

    sanitized[id] = multipleAnswerPayload(
      answers: answersList,
      otherText: normalized[AppStrings.otherField],
    );
  }

  return sanitized;
}
