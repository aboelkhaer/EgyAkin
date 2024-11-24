import 'dart:io';

import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class UploadSyndicateCardUsecase
    implements BaseUseCase<File, UploadSyndicateCardModelResponse> {
  final HomeRepository repository;

  UploadSyndicateCardUsecase(this.repository);

  @override
  Future<Either<Failure, UploadSyndicateCardModelResponse>> execute(
      File image) async {
    return await repository.uploadSyndicateCard(image: image);
  }
}
