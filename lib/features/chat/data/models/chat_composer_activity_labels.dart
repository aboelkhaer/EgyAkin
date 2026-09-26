import 'package:egy_akin/exports.dart';
import 'package:egy_akin/features/chat/data/models/chat_composer_activity.dart';

/// Localized WhatsApp-style labels for composer activity.
abstract final class ChatComposerActivityLabels {
  static const _titles = {
    'dr',
    'dr.',
    'prof',
    'prof.',
    'mr',
    'mr.',
    'mrs',
    'mrs.',
    'ms',
    'ms.',
    'د',
    'د.',
    'دكتور',
    'دكتورة',
  };

  /// First name only — never include last name / titles in activity UI.
  static String firstNameOf(String? fullName) {
    final trimmed = fullName?.trim() ?? '';
    if (trimmed.isEmpty) return '';
    final parts = trimmed.split(RegExp(r'\s+'));
    for (final part in parts) {
      final cleaned = part.replaceAll(RegExp(r'[^\w\u0600-\u06FF]+'), '');
      if (cleaned.isEmpty) continue;
      if (_titles.contains(cleaned.toLowerCase())) continue;
      if (_titles.contains(part.toLowerCase())) continue;
      return part;
    }
    return parts.first;
  }

  /// Header / "Name is …" form (includes trailing ellipsis from translations).
  static String withIs(BuildContext context, ChatComposerActivity activity) {
    return switch (activity) {
      ChatComposerActivity.none => '',
      ChatComposerActivity.typing => context.tr(AppStrings.isTyping),
      ChatComposerActivity.recording => context.tr(AppStrings.isRecording),
      ChatComposerActivity.sendingImage =>
        context.tr(AppStrings.isSendingImage),
      ChatComposerActivity.sendingImages =>
        context.tr(AppStrings.isSendingImages),
      ChatComposerActivity.sendingFile => context.tr(AppStrings.isSendingFile),
      ChatComposerActivity.sendingFiles =>
        context.tr(AppStrings.isSendingFiles),
    };
  }

  /// Inbox preview form without the leading name ("recording…").
  static String short(BuildContext context, ChatComposerActivity activity) {
    return switch (activity) {
      ChatComposerActivity.none => '',
      ChatComposerActivity.typing => context.tr(AppStrings.typing),
      ChatComposerActivity.recording => context.tr(AppStrings.recording),
      ChatComposerActivity.sendingImage =>
        context.tr(AppStrings.sendingImage),
      ChatComposerActivity.sendingImages =>
        context.tr(AppStrings.sendingImages),
      ChatComposerActivity.sendingFile => context.tr(AppStrings.sendingFile),
      ChatComposerActivity.sendingFiles =>
        context.tr(AppStrings.sendingFiles),
    };
  }

  /// "Mai is typing…" using first name only.
  static String namedLine(
    BuildContext context, {
    required String? fullName,
    required ChatComposerActivity activity,
  }) {
    final first = firstNameOf(fullName);
    final label = withIs(context, activity)
        .replaceAll(RegExp(r'(\.\.\.|…)\s*$'), '')
        .trim();
    if (first.isEmpty) return label;
    if (label.isEmpty) return first;
    return '$first $label';
  }
}
