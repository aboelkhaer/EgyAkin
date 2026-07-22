import '../../../../exports.dart';

bool isRemoteFileUrl(String? value) {
  if (value == null) return false;
  final trimmed = value.trim();
  return trimmed.startsWith('http://') || trimmed.startsWith('https://');
}

/// Resolves a downloadable/openable URL from a file answer entry map.
String? remoteFileUrlFromEntry(Map<String, dynamic> file) {
  for (final key in ['file_url', 'url', 'file_data', 'fileUrl']) {
    final value = file[key]?.toString();
    if (isRemoteFileUrl(value)) return value!.trim();
  }
  return null;
}

String fileDisplayName(Map<String, dynamic> file) {
  final name = file['file_name']?.toString();
  if (name != null && name.isNotEmpty) return name;

  final url = remoteFileUrlFromEntry(file);
  if (url != null) {
    final segment = Uri.tryParse(url)?.pathSegments.lastOrNull;
    if (segment != null && segment.isNotEmpty) return segment;
  }
  return 'file';
}

Future<void> openPatientSectionFile(
  BuildContext context,
  Map<String, dynamic> file,
) async {
  final url = remoteFileUrlFromEntry(file);
  if (url != null) {
    await launchURL(
      url: url,
      onError: (error) => showErrorDialog(context, error),
    );
    return;
  }

  if (context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          LocalizationService.instance
              .translate(AppStrings.unsupportedFileType),
        ),
      ),
    );
  }
}

List<String> fileUrlsFromQuestionAnswer(dynamic answer) {
  if (answer == null) return [];

  if (answer is String && isRemoteFileUrl(answer)) {
    return [answer.trim()];
  }

  if (answer is List) {
    final urls = <String>[];
    for (final item in answer) {
      if (item is String && isRemoteFileUrl(item)) {
        urls.add(item.trim());
        continue;
      }
      if (item is Map) {
        final map = Map<String, dynamic>.from(
          item.map((k, v) => MapEntry(k.toString(), v)),
        );
        final url = remoteFileUrlFromEntry(map);
        if (url != null) urls.add(url);
      }
    }
    return urls;
  }

  return [];
}
