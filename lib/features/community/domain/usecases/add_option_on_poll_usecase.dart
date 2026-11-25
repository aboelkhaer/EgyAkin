import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class AddOptionOnPollUsecase
    implements
        BaseUseCase<AddOptionOnPollUsecaseInput, AddOptionInPollModelResponse> {
  final CommunityRepository repository;

  AddOptionOnPollUsecase(this.repository);

  @override
  Future<Either<Failure, AddOptionInPollModelResponse>> execute(
    AddOptionOnPollUsecaseInput input,
  ) async {
    return await repository.addOptionOnPoll(
      input.pollId,
      input.option,
    );
  }
}

class AddOptionOnPollUsecaseInput {
  final String pollId;
  final String option;

  AddOptionOnPollUsecaseInput({
    required this.pollId,
    required this.option,
  });
}
