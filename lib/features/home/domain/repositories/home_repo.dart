import 'dart:io';

import 'package:egy_akin/features/home/data/models/upload_syndicate_card_model_response.dart';

import '../../../../exports.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepository {
  Future<Either<Failure, HomeModelResponse>> getHome();
  Future<Either<Failure, UploadSyndicateCardModelResponse>>
      uploadSyndicateCard({
    required File image,
  });
}
