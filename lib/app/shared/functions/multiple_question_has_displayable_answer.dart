import 'package:egy_akin/app/constants/app_strings.dart';

/// True when a multiple question has at least one answer that matches an option.
bool multipleQuestionHasDisplayableAnswer({
  required List<dynamic>? optionValues,
  required dynamic storedAnswer,
}) {
  final answers = _extractMultipleAnswers(storedAnswer);
  if (answers.isEmpty) return false;
  if (optionValues == null || optionValues.isEmpty) return true;

  for (final answer in answers) {
    if (_matchOptionValue(answer, optionValues) != null) return true;
  }
  return false;
}

List<dynamic> _extractMultipleAnswers(dynamic storedAnswer) {
  if (storedAnswer is Map) {
    final raw = storedAnswer[AppStrings.answers];
    if (raw is List) {
      return raw.where((e) => e != null && e.toString().trim().isNotEmpty).toList();
    }
    if (raw is String && raw.trim().isNotEmpty) {
      return raw.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
    }
    return const [];
  }
  if (storedAnswer is List) {
    return storedAnswer
        .where((e) => e != null && e.toString().trim().isNotEmpty)
        .toList();
  }
  if (storedAnswer is String && storedAnswer.trim().isNotEmpty) {
    return storedAnswer
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
  }
  return const [];
}

/// Maps a raw AI/voice value onto the exact option label used by the UI.
dynamic matchMultipleOptionValue(dynamic raw, List<dynamic>? optionValues) {
  return _matchOptionValue(raw, optionValues);
}

dynamic _matchOptionValue(dynamic raw, List<dynamic>? optionValues) {
  if (raw == null || optionValues == null || optionValues.isEmpty) return null;
  final rawStr = raw.toString().trim();
  if (rawStr.isEmpty) return null;

  for (final opt in optionValues) {
    if (opt == raw) return opt;
  }
  final lower = rawStr.toLowerCase();
  for (final opt in optionValues) {
    if (opt.toString().trim().toLowerCase() == lower) return opt;
  }
  return null;
}
