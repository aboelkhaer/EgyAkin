import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/community/data/models/add_option_in_poll_model_response.dart';
import 'package:egy_akin/features/group_details_in_community/data/models/add_vote_and_unvote_model_response.dart';
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
