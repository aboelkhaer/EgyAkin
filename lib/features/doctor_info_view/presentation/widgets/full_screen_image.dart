import 'package:photo_view/photo_view.dart';

import '../../../../exports.dart';

class FullScreenImage extends StatelessWidget {
  final String imageUrl;

  const FullScreenImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(1),
      body: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        onHorizontalDragStart: (details) {
          Navigator.of(context).pop();
        },
        child: Stack(
          children: [
            Center(
              child: PhotoView(
                imageProvider: CachedNetworkImageProvider(imageUrl),
                backgroundDecoration: BoxDecoration(
                  color: Colors.black.withOpacity(1),
                ),
              ),
            ),
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
