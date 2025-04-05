import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/show_single_feed/data/models/get_post_by_id_model_response.dart';

import '../../../../exports.dart';

class GetPostByIdUsecase
    implements BaseUseCase<String, GetPostByIdModelResponse> {
  final ShowSingleFeedRepository repository;

  GetPostByIdUsecase(this.repository);

  @override
  Future<Either<Failure, GetPostByIdModelResponse>> execute(
    String postId,
  ) async {
    return await repository.getPostById(postId: postId);
  }
}
