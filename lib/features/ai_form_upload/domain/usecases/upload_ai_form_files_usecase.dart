import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../exports.dart';
import '../repositories/ai_form_upload_repo.dart';

class UploadAiFormFilesUsecaseInput {
  final String sectionId;
  final List<File> imageFiles;
  final List<File> attachmentFiles;

  UploadAiFormFilesUsecaseInput({
    required this.sectionId,
    required this.imageFiles,
    required this.attachmentFiles,
  });
}

class UploadAiFormFilesUsecase
    implements
        BaseUseCase<
            UploadAiFormFilesUsecaseInput, AiFormUploadAnalysisModelResponse> {
  final AiFormUploadRepo _repo;

  UploadAiFormFilesUsecase(this._repo);

  @override
  Future<Either<Failure, AiFormUploadAnalysisModelResponse>> execute(
      UploadAiFormFilesUsecaseInput input) {
    return _repo.uploadFilesForAnalysis(
      sectionId: input.sectionId,
      imageFiles: input.imageFiles,
      attachmentFiles: input.attachmentFiles,
    );
  }
}
