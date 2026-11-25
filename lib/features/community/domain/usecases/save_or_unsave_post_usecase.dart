import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class SaveOrUnsavePostUsecase
    implements
        BaseUseCase<SaveOrUnsavePostUsecaseInput,
            SaveOrUnsavePostModelResponse> {
  final CommunityRepository repository;

  SaveOrUnsavePostUsecase(this.repository);

  @override
  Future<Either<Failure, SaveOrUnsavePostModelResponse>> execute(
    SaveOrUnsavePostUsecaseInput input,
  ) async {
    return await repository.saveOrUnsavePost(
        postId: input.postId, saveOrUnsave: input.saveOrUnsave);
  }
}

class SaveOrUnsavePostUsecaseInput {
  final String postId;
  final String saveOrUnsave;

  SaveOrUnsavePostUsecaseInput({
    required this.postId,
    required this.saveOrUnsave,
  });
}
