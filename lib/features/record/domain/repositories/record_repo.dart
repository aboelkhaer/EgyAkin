import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../exports.dart';

abstract class RecordRepository {
  Future<Either<Failure, ProcessSectionModelResponse>> processSection({
    required String sectionId,
    required File audioFile,
  });

  Future<Either<Failure, ProcessSectionModelResponse>> processSectionImages({
    required String sectionId,
    required List<File> imageFiles,
  });
}
