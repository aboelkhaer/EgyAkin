import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/home/data/models/upload_syndicate_card_model_response.dart';
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
