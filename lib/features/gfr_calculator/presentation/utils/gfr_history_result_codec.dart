import 'dart:convert';

import 'package:egy_akin/app/constants/app_strings.dart';
import 'package:egy_akin/features/gfr_calculator/presentation/utils/gfr_equation_formulas.dart';

const String _nkfHistoryPrefix = '__nkf_v1:';

/// NKF multi-equation results stored with labels for history display.
String encodeNkfHistoryResult(List<NkfEgfrResultLine> lines) {
  final payload = lines
      .map(
        (line) => {
          'labelKey': line.labelKey,
          'egfr': line.egfr,
        },
      )
      .toList();
  return '$_nkfHistoryPrefix${jsonEncode(payload)}';
}

/// Parses NKF history [result]. Returns labeled lines when encoded or legacy
/// slash-separated values; null if not an NKF multi/single encoded form.
List<NkfEgfrResultLine>? parseNkfHistoryResult(String? result) {
  if (result == null || result.isEmpty) return null;

  if (result.startsWith(_nkfHistoryPrefix)) {
    try {
      final decoded =
          jsonDecode(result.substring(_nkfHistoryPrefix.length)) as List;
      return decoded
          .map(
            (item) => NkfEgfrResultLine(
              labelKey: (item as Map)['labelKey'] as String,
              egfr: ((item)['egfr'] as num).toDouble(),
            ),
          )
          .toList();
    } catch (_) {
      return null;
    }
  }

  if (result.contains('/')) {
    return _legacySlashSeparatedNkfLines(result);
  }

  return null;
}

List<NkfEgfrResultLine> _legacySlashSeparatedNkfLines(String result) {
  const labelKeys = [
    AppStrings.ckdEpiCreatinine2021,
    AppStrings.ckdEpiCreatinineCystatin2021,
    AppStrings.ckdEpiCystatinC2012,
  ];

  final parts = result.split('/').map((s) => s.trim()).toList();
  final lines = <NkfEgfrResultLine>[];

  for (var i = 0; i < parts.length; i++) {
    final egfr = double.tryParse(parts[i]);
    if (egfr == null) continue;
    lines.add(
      NkfEgfrResultLine(
        labelKey: i < labelKeys.length ? labelKeys[i] : AppStrings.estimatedGfr,
        egfr: egfr,
      ),
    );
  }

  return lines;
}
