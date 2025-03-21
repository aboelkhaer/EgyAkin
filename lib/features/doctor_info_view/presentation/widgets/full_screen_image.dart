import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../exports.dart';

class FullScreenImage extends StatelessWidget {
  final String imageUrl; // Single image URL
  final bool isLocal;

  const FullScreenImage({
    super.key,
    required this.imageUrl,
    this.isLocal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(1),
      body: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Stack(
          children: [
            // Display the single image
            Center(
              child: PhotoView(
                imageProvider: isLocal
                    ? AssetImage(imageUrl) as ImageProvider
                    : CachedNetworkImageProvider(imageUrl),
                backgroundDecoration: BoxDecoration(
                  color: Colors.black.withOpacity(1),
                ),
              ),
            ),
            // Close button
            Positioned(
              top: 40,
              right: 20,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white, size: 30),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
