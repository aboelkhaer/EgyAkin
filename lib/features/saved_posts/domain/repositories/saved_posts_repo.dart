
import '../../../../exports.dart';
import 'package:dartz/dartz.dart';

abstract class SavedPostsRepository {
  Future<Either<Failure, GetSavedPostsModelResponse>> getSavedPosts(
    String doctorId,
    int page,
  );
}
