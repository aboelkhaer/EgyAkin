import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/community/data/models/get_poll_voters_model_response.dart';
import '../../../../exports.dart';

class GetPollVotersUsecase
    implements
        BaseUseCase<GetPollVotersUsecaseInput, GetPollVotersModelResponse> {
  final CommunityRepository repository;

  GetPollVotersUsecase(this.repository);

  @override
  Future<Either<Failure, GetPollVotersModelResponse>> execute(
      GetPollVotersUsecaseInput input) async {
    return await repository.getPollVoters(
      input.pollId,
      input.optionId,
      input.page,
    );
  }
}

class GetPollVotersUsecaseInput {
  final String pollId;
  final String optionId;
  final int page;

  GetPollVotersUsecaseInput({
    required this.pollId,
    required this.optionId,
    required this.page,
  });
}
