import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../exports.dart';

abstract class AiFormUploadRepo {
  Future<Either<Failure, AiFormUploadAnalysisModelResponse>> uploadFilesForAnalysis({
    required String sectionId,
    required List<File> imageFiles,
    required List<File> attachmentFiles,
  });
}
