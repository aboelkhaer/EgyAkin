import 'package:metadata_fetch/metadata_fetch.dart';
import '../../../exports.dart';

/// Global cache to store fetched metadata and prevent reloading
final Map<String, Metadata?> _metadataCache = {};

class LinkPreviewWidget extends StatefulWidget {
  final String url;
  const LinkPreviewWidget({super.key, required this.url});

  @override
  _LinkPreviewWidgetState createState() => _LinkPreviewWidgetState();
}

class _LinkPreviewWidgetState extends State<LinkPreviewWidget> {
  String? _title;
  String? _description;
  String? _imageUrl;
  bool _isPdf = false;
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _loadMetadata();
  }

  void _loadMetadata() {
    if (_metadataCache.containsKey(widget.url)) {
      final metadata = _metadataCache[widget.url];
      if (metadata != null) {
        _setMetadata(metadata);
      } else {
        _setError();
      }
    } else {
      _fetchMetadata();
    }
  }

  Future<void> _fetchMetadata() async {
    if (_isGoogleDriveUrl(widget.url)) {
      _handleGoogleDriveUrl(widget.url);
      return;
    }

    try {
      final metadata = await MetadataFetch.extract(widget.url);
      _metadataCache[widget.url] = metadata;

      if (metadata != null && metadata.title != null) {
        _setMetadata(metadata);
      } else {
        _setError();
      }
    } catch (e) {
      _setError();
    }
  }

  void _handleGoogleDriveUrl(String url) {
    final fileId = _extractGoogleDriveFileId(url);
    if (fileId == null) {
      _setError();
      return;
    }

    _imageUrl = "https://drive.google.com/thumbnail?id=$fileId";
    _title = "Google Drive File";
    _description = "Click to view the file.";

    if (url.contains("export=download") || url.endsWith(".pdf")) {
      _isPdf = true;
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _setMetadata(Metadata metadata) {
    setState(() {
      _title = metadata.title;
      _description = metadata.description ?? "No description available.";
      _imageUrl = metadata.image;
      _isLoading = false;
    });
  }

  void _setError() {
    setState(() {
      _hasError = true;
      _isLoading = false;
    });
  }

  void _openUrl() async {
    final Uri url = Uri.parse(widget.url);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Could not open link")),
      );
    }
  }

  bool _isGoogleDriveUrl(String url) {
    return url.contains("drive.google.com");
  }

  String? _extractGoogleDriveFileId(String url) {
    RegExp regex = RegExp(r"/d/([a-zA-Z0-9_-]+)|id=([a-zA-Z0-9_-]+)");
    final match = regex.firstMatch(url);
    return match?.group(1) ?? match?.group(2);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _openUrl,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: _isLoading
              ? _buildShimmer()
              : _hasError
                  ? _buildError()
                  : _buildPreview(),
        ),
      ),
    );
  }

  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 180,
        width: double.infinity,
        color: Colors.white,
      ),
    );
  }

  Widget _buildError() {
    return Container(
      padding: const EdgeInsets.all(12),
      color: Colors.grey[200],
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: Colors.red),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              "Preview not available",
              style: TextStyle(color: Colors.grey[700], fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_imageUrl != null && !_isPdf)
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            child: Image.network(
              _imageUrl!,
              width: double.infinity,
              height: 150,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.image_not_supported, size: 50),
            ),
          ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          color: Colors.grey.shade200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_title != null)
                Text(
                  _title!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              const SizedBox(height: 5),
              if (_description != null)
                Text(
                  _description!,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
            ],
          ),
        ),
      ],
    );
  }
}
