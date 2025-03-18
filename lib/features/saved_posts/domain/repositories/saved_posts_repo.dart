import 'package:egy_akin/features/saved_posts/data/models/get_saved_posts_model_response.dart';

import '../../../../exports.dart';
import 'package:dartz/dartz.dart';

abstract class SavedPostsRepository {
  Future<Either<Failure, GetSavedPostsModelResponse>> getSavedPosts(
    String doctorId,
    int page,
  );
}
