
import '../../../../exports.dart';
import 'package:dartz/dartz.dart';

abstract class CommunityRepository {
  Future<Either<Failure, GetPostsCommunityModelResponse>> getAllFeeds(int page);

  Future<Either<Failure, AddLikeOnPostModelResponse>> addLikeOrUnlikeOnPost({
    required String postId,
    required String likeOrUnlike,
  });

  Future<Either<Failure, SaveOrUnsavePostModelResponse>> saveOrUnsavePost({
    required String postId,
    required String saveOrUnsave,
  });
  Future<Either<Failure, DeletePostModelResponse>> deletePostInFeeds({
    required String postId,
  });

  Future<Either<Failure, GetGroupsTabModelResponse>> getGroupsTab(int page);

  Future<Either<Failure, JoinGroupModelResponse>> joinGroupInCommunity(
    String groupId,
  );

  Future<Either<Failure, GetTrendingTabInCommunityModelResponse>>
      getTrendingPostsInCommunity(int page);

  Future<Either<Failure, AddVoteAndUnvoteModelResponse>> addVoteForPollInPosts(
    String pollId,
    int optionId,
  );
  Future<Either<Failure, AddOptionInPollModelResponse>> addOptionOnPoll(
    String pollId,
    String option,
  );
  Future<Either<Failure, GetPollVotersModelResponse>> getPollVoters(
    String pollId,
    String optionId,
    int page,
  );
}
