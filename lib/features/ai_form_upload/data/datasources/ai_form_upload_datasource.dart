import 'dart:io';

import '../../../../exports.dart';

abstract class AiFormUploadDatasource {
  Future<AiFormUploadAnalysisModelResponse> uploadFilesForAnalysis({
    required String sectionId,
    required List<File> imageFiles,
    required List<File> attachmentFiles,
  });
}

class AiFormUploadDatasourceImpl implements AiFormUploadDatasource {
  final ApiServices _apiServices;

  AiFormUploadDatasourceImpl(this._apiServices);

  @override
  Future<AiFormUploadAnalysisModelResponse> uploadFilesForAnalysis({
    required String sectionId,
    required List<File> imageFiles,
    required List<File> attachmentFiles,
  }) async {
    final raw = await _apiServices.processSectionFiles(
      sectionId,
      imageFiles,
      attachmentFiles,
    );
    return AiFormUploadAnalysisModelResponse(
      extractedText: raw.extractedText,
      data: raw.data,
    );
  }
}
