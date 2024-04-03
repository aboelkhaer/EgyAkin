import 'package:dio/dio.dart';

import '../../exports.dart';

class MultipartFileConverter
    implements JsonConverter<MultipartFile, Map<String, dynamic>> {
  const MultipartFileConverter();

  @override
  MultipartFile fromJson(Map<String, dynamic> json) {
    // Implement conversion from JSON to MultipartFile if needed
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> toJson(MultipartFile object) {
    // Implement conversion from MultipartFile to JSON if needed
    throw UnimplementedError();
  }
}
