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
  bool _isTikTok = false;
  bool _showLinkOnly = false;

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
    // Validate URL format first
    if (!_isValidUrl(widget.url)) {
      _setFallbackMetadata();
      return;
    }

    if (_isTikTokUrl(widget.url)) {
      _isTikTok = true;
      await _handleTikTokUrl(widget.url);
      return;
    }

    if (_isGoogleDriveUrl(widget.url)) {
      _handleGoogleDriveUrl(widget.url);
      return;
    }

    try {
      final metadata = await MetadataFetch.extract(widget.url);
      _metadataCache[widget.url] = metadata;

      if (metadata != null && _hasValidMetadata(metadata)) {
        _setMetadata(metadata);
      } else {
        // Try to extract basic info from URL for fallback
        _setFallbackMetadata();
      }
    } catch (e) {
      _setFallbackMetadata();
    }
  }

  bool _hasValidMetadata(Metadata metadata) {
    // Check if we have meaningful content - at least a title or description
    // Image alone is not enough for a meaningful preview
    final hasTitle = metadata.title != null && metadata.title!.trim().isNotEmpty;
    final hasDescription = metadata.description != null && metadata.description!.trim().isNotEmpty;
    final hasImage = metadata.image != null && metadata.image!.trim().isNotEmpty;
    
    // We need at least a title or description to show a meaningful preview
    // Also check that the values are not just "null" strings
    final titleIsValid = hasTitle && metadata.title!.trim().toLowerCase() != "null";
    final descriptionIsValid = hasDescription && metadata.description!.trim().toLowerCase() != "null";
    
    return titleIsValid || descriptionIsValid;
  }

  Future<void> _handleTikTokUrl(String url) async {
    try {
      // Extract TikTok video ID
      final videoId = _extractTikTokVideoId(url);
      if (videoId == null) {
        _setError();
        return;
      }

      // Get TikTok metadata
      final metadata = await MetadataFetch.extract(url);

      // TikTok thumbnail URL pattern
      _imageUrl = "https://www.tiktok.com/api/img/?itemId=$videoId";

      if (mounted) {
        setState(() {
          // Only set title if it's not null, not empty, and not "null" string
          _title = (metadata?.title != null && 
                   metadata!.title!.trim().isNotEmpty && 
                   metadata.title!.trim().toLowerCase() != "null")
              ? metadata.title!.trim()
              : "TikTok Video";
          
          // Only set description if it's not null, not empty, and not "null" string
          _description = (metadata?.description != null && 
                         metadata!.description!.trim().isNotEmpty && 
                         metadata.description!.trim().toLowerCase() != "null")
              ? metadata.description!.trim()
              : "Watch on TikTok";
          
          _isLoading = false;
        });
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

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _setMetadata(Metadata metadata) {
    if (mounted) {
      setState(() {
        // Only set title if it's not null, not empty, and not "null" string
        _title = (metadata.title != null && 
                 metadata.title!.trim().isNotEmpty && 
                 metadata.title!.trim().toLowerCase() != "null") 
            ? metadata.title!.trim() 
            : null;
        
        // Only set description if it's not null, not empty, and not "null" string
        _description = (metadata.description != null && 
                       metadata.description!.trim().isNotEmpty && 
                       metadata.description!.trim().toLowerCase() != "null") 
            ? metadata.description!.trim() 
            : null;
        
        // Only set image URL if it's not null, not empty, and not "null" string
        _imageUrl = (metadata.image != null && 
                    metadata.image!.trim().isNotEmpty && 
                    metadata.image!.trim().toLowerCase() != "null") 
            ? metadata.image!.trim() 
            : null;
        
        _isLoading = false;
      });
    }
  }

  void _setError() {
    if (mounted) {
      setState(() {
        _hasError = true;
        _isLoading = false;
        _showLinkOnly = true;
      });
    }
  }

  void _setFallbackMetadata() {
    if (mounted) {
      setState(() {
        // Extract domain name for fallback title
        String fallbackTitle = "Link";
        
        try {
          final uri = Uri.tryParse(widget.url);
          
          if (uri != null && uri.host.isNotEmpty) {
            // Clean up domain name for better display
            String domain = uri.host.replaceAll('www.', '');
            
            // Special handling for known domains
            if (domain.contains('mayoclinic')) {
              fallbackTitle = "Mayo Clinic";
            } else if (domain.contains('webmd')) {
              fallbackTitle = "WebMD";
            } else if (domain.contains('healthline')) {
              fallbackTitle = "Healthline";
            } else if (domain.contains('medlineplus')) {
              fallbackTitle = "MedlinePlus";
            } else {
              // Capitalize first letter of domain
              fallbackTitle = domain.split('.').first;
              if (fallbackTitle.isNotEmpty) {
                fallbackTitle = fallbackTitle[0].toUpperCase() + fallbackTitle.substring(1);
              }
            }
          } else if (widget.url.startsWith('file://')) {
            // Handle file URIs
            fallbackTitle = "Local File";
          } else if (widget.url.startsWith('data:')) {
            // Handle data URIs
            fallbackTitle = "Data URL";
          } else if (widget.url.startsWith('mailto:')) {
            // Handle mailto URIs
            fallbackTitle = "Email";
          } else if (widget.url.startsWith('tel:')) {
            // Handle tel URIs
            fallbackTitle = "Phone";
          }
        } catch (e) {
          // If URI parsing fails, use generic title
          fallbackTitle = "Link";
        }
        
        _title = fallbackTitle;
        _description = "Click to view the full article";
        _imageUrl = null;
        _isLoading = false;
      });
    }
  }

  void _openUrl() async {
    try {
      final Uri url = Uri.parse(widget.url);
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Could not open link")),
        );
      }
    } catch (e) {
      // Handle invalid URI format
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid link format: ${widget.url}")),
      );
    }
  }

  bool _isGoogleDriveUrl(String url) {
    return url.contains("drive.google.com");
  }

  bool _isTikTokUrl(String url) {
    return url.contains("tiktok.com") &&
        (url.contains("/video/") || url.contains("/v/"));
  }

  String? _extractGoogleDriveFileId(String url) {
    RegExp regex = RegExp(r"/d/([a-zA-Z0-9_-]+)|id=([a-zA-Z0-9_-]+)");
    final match = regex.firstMatch(url);
    return match?.group(1) ?? match?.group(2);
  }

  String? _extractTikTokVideoId(String url) {
    RegExp regex = RegExp(r"/video/(\d+)");
    final match = regex.firstMatch(url);
    return match?.group(1);
  }

  bool _isValidUrl(String url) {
    try {
      final uri = Uri.tryParse(url);
      if (uri == null) return false;
      
      // Check for valid schemes
      final validSchemes = ['http', 'https', 'ftp', 'file', 'data', 'mailto', 'tel'];
      if (!validSchemes.contains(uri.scheme)) return false;
      
      // For file URIs, check if they have a proper path
      if (uri.scheme == 'file' && (uri.path.isEmpty || uri.path == '/')) return false;
      
      // For http/https, check if they have a host
      if ((uri.scheme == 'http' || uri.scheme == 'https') && uri.host.isEmpty) return false;
      
      return true;
    } catch (e) {
      return false;
    }
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
                  ? _buildLinkOnly()
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

  Widget _buildLinkOnly() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey[100],
      child: Row(
        children: [
          const Icon(Icons.link, color: Colors.blue, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Link",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.url,
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  "Tap to open",
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.open_in_new, color: Colors.blue, size: 20),
        ],
      ),
    );
  }

  Widget _buildPreview() {
    // Check if we have enough content to show a meaningful preview
    final hasTitle = _title != null && _title!.trim().isNotEmpty;
    final hasDescription = _description != null && _description!.trim().isNotEmpty;
    final hasImage = _imageUrl != null && _imageUrl!.isNotEmpty;

    // If we don't have enough content, show link only
    // We need at least a title or description for a meaningful preview
    if (!hasTitle && !hasDescription) {
      return _buildLinkOnly();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hasImage && !_isPdf)
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            child: Stack(
              children: [
                Image.network(
                  _imageUrl!,
                  width: double.infinity,
                  height: _isTikTok ? 300 : 150,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    // Handle "Invalid image data" error and other image errors
                    return Container(
                      height: _isTikTok ? 300 : 150,
                      color: Colors.grey[200],
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _isTikTok ? Icons.videocam_off : Icons.image_not_supported,
                            size: 40,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Image not available",
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      height: _isTikTok ? 300 : 150,
                      color: Colors.grey[200],
                      child: Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      ),
                    );
                  },
                ),
                if (_isTikTok)
                  const Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.play_circle_filled,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          color: Colors.grey.shade100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (hasTitle)
                Text(
                  _title!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                ),
              if (hasTitle && hasDescription) const SizedBox(height: 6),
              if (hasDescription)
                Text(
                  _description!,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              if (_isTikTok)
                const Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    "Tap to watch on TikTok",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
