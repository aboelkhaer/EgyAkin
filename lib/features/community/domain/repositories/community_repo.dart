import 'package:egy_akin/features/community/data/models/add_like_on_post_model_response.dart';
import 'package:egy_akin/features/community/data/models/add_option_in_poll_model_response.dart';
import 'package:egy_akin/features/community/data/models/delete_post_model_response.dart';
import 'package:egy_akin/features/community/data/models/get_groups_tab_model_response.dart';
import 'package:egy_akin/features/community/data/models/get_poll_voters_model_response.dart';
import 'package:egy_akin/features/community/data/models/get_trending_tab_in_community_model_response.dart';
import 'package:egy_akin/features/community/data/models/join_group_model_response.dart';
import 'package:egy_akin/features/community/data/models/save_or_unsave_post_model_response.dart';
import 'package:egy_akin/features/group_details_in_community/data/models/add_vote_and_unvote_model_response.dart';

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
