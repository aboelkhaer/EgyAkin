import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../exports.dart';
import '../../domain/repositories/record_repo.dart';
import '../datasources/record_datasource.dart';

class RecordRepositoryImpl extends RecordRepository {
  final RecordDataSource _recordDataSource;
  final NetworkInfo _networkInfo;

  RecordRepositoryImpl(this._recordDataSource, this._networkInfo);

  @override
  Future<Either<Failure, ProcessSectionModelResponse>> processSection({
    required String sectionId,
    required File audioFile,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _recordDataSource.processSection(
          sectionId: sectionId,
          audioFile: audioFile,
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
