import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../exports.dart';
import '../repositories/record_repo.dart';

class ProcessSectionImagesParams {
  final String sectionId;
  final List<File> imageFiles;

  ProcessSectionImagesParams({
    required this.sectionId,
    required this.imageFiles,
  });
}

class ProcessSectionImagesUsecase
    implements
        BaseUseCase<ProcessSectionImagesParams, ProcessSectionModelResponse> {
  final RecordRepository _recordRepository;

  ProcessSectionImagesUsecase(this._recordRepository);

  @override
  Future<Either<Failure, ProcessSectionModelResponse>> execute(
      ProcessSectionImagesParams input) {
    return _recordRepository.processSectionImages(
      sectionId: input.sectionId,
      imageFiles: input.imageFiles,
    );
  }
}
