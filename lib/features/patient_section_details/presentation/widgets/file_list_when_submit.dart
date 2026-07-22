import '../../../../exports.dart';

class FileListWhenSubmit extends StatelessWidget {
  final List<String> files;

  const FileListWhenSubmit({super.key, required this.files});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: files.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final fileUrl = files[index];
        final fileName = Uri.tryParse(fileUrl)?.pathSegments.lastOrNull ??
            fileUrl.split('/').last;

        return ListTile(
          title: Text(fileName),
          onTap: () => launchURL(
            url: fileUrl,
            onError: (error) => showErrorDialog(context, error),
          ),
        );
      },
    );
  }
}
