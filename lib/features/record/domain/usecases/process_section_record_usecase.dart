import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../exports.dart';
import '../repositories/record_repo.dart';

class ProcessSectionRecordParams {
  final String sectionId;
  final File audioFile;

  ProcessSectionRecordParams({
    required this.sectionId,
    required this.audioFile,
  });
}

class ProcessSectionRecordUsecase
    implements BaseUseCase<ProcessSectionRecordParams, ProcessSectionModelResponse> {
  final RecordRepository _recordRepository;

  ProcessSectionRecordUsecase(this._recordRepository);

  @override
  Future<Either<Failure, ProcessSectionModelResponse>> execute(
      ProcessSectionRecordParams input) {
    return _recordRepository.processSection(
      sectionId: input.sectionId,
      audioFile: input.audioFile,
    );
  }
}
