import 'dart:io';

import '../../../../exports.dart';

abstract class RecordDataSource {
  Future<ProcessSectionModelResponse> processSection({
    required String sectionId,
    required File audioFile,
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
}
