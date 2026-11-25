import 'package:dartz/dartz.dart';
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
