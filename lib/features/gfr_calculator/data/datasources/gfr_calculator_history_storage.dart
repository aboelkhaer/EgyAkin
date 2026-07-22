import 'dart:convert';

import 'package:egy_akin/app/constants/local_storage_key.dart';
import 'package:egy_akin/app/services/local_storage.dart';
import 'package:egy_akin/features/gfr_calculator/data/models/gfr_calculator_model_response.dart';

class GfrCalculatorHistoryStorage {
  static const int maxEntries = 100;

  Future<List<GFRCalculatorHistoryModelResponse>> load(
    AppPreferences preferences,
  ) async {
    final raw = await preferences.getString(AppLocalStrings.gfrCalculatorHistory);
    if (raw == null || raw.isEmpty) return [];

    try {
      final decoded = jsonDecode(raw);
      if (decoded is! List) return [];

      return decoded
          .map(
            (item) => GFRCalculatorHistoryModelResponse.fromJson(
              Map<String, dynamic>.from(item as Map),
            ),
          )
          .toList();
    } catch (_) {
      return [];
    }
  }

  Future<void> save(
    AppPreferences preferences,
    List<GFRCalculatorHistoryModelResponse> history,
  ) async {
    final trimmed = history.length > maxEntries
        ? history.sublist(history.length - maxEntries)
        : history;

    final encoded = jsonEncode(
      trimmed.map((entry) => entry.toJson()).toList(),
    );
    await preferences.setData(AppLocalStrings.gfrCalculatorHistory, encoded);
  }

  Future<void> clear(AppPreferences preferences) async {
    await preferences.removeData(AppLocalStrings.gfrCalculatorHistory);
  }
}
