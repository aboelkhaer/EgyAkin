import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/saved_posts/data/models/get_saved_posts_model_response.dart';
import 'package:egy_akin/features/saved_posts/domain/repositories/saved_posts_repo.dart';
import '../../../../exports.dart';

class GetSavedPostsUsecase
    implements
        BaseUseCase<GetSavedPostsUsecaseInput, GetSavedPostsModelResponse> {
  final SavedPostsRepository repository;

  GetSavedPostsUsecase(this.repository);

  @override
  Future<Either<Failure, GetSavedPostsModelResponse>> execute(
      GetSavedPostsUsecaseInput input) async {
    return await repository.getSavedPosts(input.doctorId, input.page);
  }
}

class GetSavedPostsUsecaseInput {
  final String doctorId;
  final int page;

  GetSavedPostsUsecaseInput({required this.doctorId, required this.page});
}
