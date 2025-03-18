import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/group_details_in_community/data/models/add_vote_and_unvote_model_response.dart';
import '../../../../exports.dart';

class AddVoteAndUnvoteUsecase
    implements
        BaseUseCase<AddVoteAndUnvoteUsecaseInput,
            AddVoteAndUnvoteModelResponse> {
  final CommunityRepository repository;

  AddVoteAndUnvoteUsecase(this.repository);

  @override
  Future<Either<Failure, AddVoteAndUnvoteModelResponse>> execute(
    AddVoteAndUnvoteUsecaseInput input,
  ) async {
    return await repository.addVoteForPollInPosts(
      input.pollId,
      input.optionId,
    );
  }
}

class AddVoteAndUnvoteUsecaseInput {
  final String pollId;
  final int optionId;

  AddVoteAndUnvoteUsecaseInput({
    required this.pollId,
    required this.optionId,
  });
}
