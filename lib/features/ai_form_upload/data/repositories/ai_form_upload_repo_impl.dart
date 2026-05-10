import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../exports.dart';
import '../../domain/repositories/ai_form_upload_repo.dart';
import '../datasources/ai_form_upload_datasource.dart';

class AiFormUploadRepoImpl implements AiFormUploadRepo {
  final AiFormUploadDatasource _datasource;
  final NetworkInfo _networkInfo;

  AiFormUploadRepoImpl(this._datasource, this._networkInfo);

  @override
  Future<Either<Failure, AiFormUploadAnalysisModelResponse>> uploadFilesForAnalysis({
    required String sectionId,
    required List<File> imageFiles,
    required List<File> attachmentFiles,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _datasource.uploadFilesForAnalysis(
          sectionId: sectionId,
          imageFiles: imageFiles,
          attachmentFiles: attachmentFiles,
        );
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }
}
