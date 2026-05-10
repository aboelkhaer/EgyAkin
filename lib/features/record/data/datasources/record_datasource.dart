import 'dart:io';
import 'package:dio/dio.dart';

import '../../../../exports.dart';

abstract class RecordDataSource {
  Future<ProcessSectionModelResponse> processSection({
    required String sectionId,
    required File audioFile,
  });

  Future<ProcessSectionModelResponse> processSectionImages({
    required String sectionId,
    required List<File> imageFiles,
  });
}

class RecordDataSourceImpl implements RecordDataSource {
  final ApiServices _apiServices;

  RecordDataSourceImpl(this._apiServices);

  @override
  Future<ProcessSectionModelResponse> processSection({
    required String sectionId,
    required File audioFile,
  }) async {
    return await _apiServices.processSection(sectionId, audioFile);
  }

  @override
  Future<ProcessSectionModelResponse> processSectionImages({
    required String sectionId,
    required List<File> imageFiles,
  }) async {
    final dio = await sl<DioFactory>().getDio();
    final formData = FormData()
      ..fields.add(MapEntry('section_id', sectionId));

    for (final image in imageFiles) {
      formData.files.add(
        MapEntry(
          'images[]',
          await MultipartFile.fromFile(
            image.path,
            filename: image.path.split(Platform.pathSeparator).last,
          ),
        ),
      );
    }

    final response = await dio.post<dynamic>(
      ApiEndPoint.processSection,
      data: formData,
      options: Options(contentType: 'multipart/form-data'),
    );

    return ProcessSectionModelResponse.fromJson(
      Map<String, dynamic>.from(response.data as Map),
    );
  }
}
