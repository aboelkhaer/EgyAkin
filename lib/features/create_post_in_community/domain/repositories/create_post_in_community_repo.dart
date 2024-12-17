import 'dart:io';

import 'package:egy_akin/features/create_post_in_community/data/models/create_post_in_community_model_response.dart';

import '../../../../exports.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepository {
  Future<Either<Failure, CreatePostInCommunityModelResponse>>
      uploadSyndicateCard({
    required File image,
  });
}
