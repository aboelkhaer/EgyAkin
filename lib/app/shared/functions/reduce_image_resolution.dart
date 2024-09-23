import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;

import '../../../exports.dart';

Future<File> optimizeImage(File imageFile) async {
  final tempDir = await getTemporaryDirectory();
  final optimizedImagePath = '${tempDir.path}/optimized_image.jpg';

  // Use compute to process the image in a background thread
  final optimizedImageFile = await compute(_processImage, {
    'imageFile': imageFile,
    'optimizedImagePath': optimizedImagePath,
  });

  return optimizedImageFile;
}

// Background processing function
File _processImage(Map<String, dynamic> params) {
  final imageFile = params['imageFile'] as File;
  final optimizedImagePath = params['optimizedImagePath'] as String;

  final image = img.decodeImage(imageFile.readAsBytesSync())!;
  // Resize the image to a maximum dimension of 1024x1024
  final resizedImage = img.copyResize(image, width: 1024, height: 1024);

  // Save the compressed image to the specified path
  final optimizedImageFile = File(optimizedImagePath)
    ..writeAsBytesSync(img.encodeJpg(resizedImage, quality: 70));

  return optimizedImageFile;
}
