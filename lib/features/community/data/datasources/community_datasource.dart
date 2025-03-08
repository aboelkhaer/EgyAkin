import 'package:egy_akin/features/community/data/models/add_like_on_post_model_response.dart';
import 'package:egy_akin/features/community/data/models/delete_post_model_response.dart';
import 'package:egy_akin/features/community/data/models/get_groups_tab_model_response.dart';
import 'package:egy_akin/features/community/data/models/get_trending_tab_in_community_model_response.dart';
import 'package:egy_akin/features/community/data/models/join_group_model_response.dart';
import 'package:egy_akin/features/community/data/models/save_or_unsave_post_model_response.dart';

import '../../../../exports.dart';

abstract class CommunityDatasource {
  Future<GetPostsCommunityModelResponse> getAllFeeds(int page);
  Future<AddLikeOnPostModelResponse> addLikeOrUnlikeOnPost(
      String postId, String likeOrUnlike);
  Future<SaveOrUnsavePostModelResponse> saveOrUnsavePost({
    required String postId,
    required String saveOrUnsave,
  });
  Future<DeletePostModelResponse> deletePostInFeeds({
    required String postId,
  });
  Future<GetGroupsTabModelResponse> getGroupsTab(int page);
  Future<JoinGroupModelResponse> joinGroupInCommunity(
    String groupId,
  );
  Future<GetTrendingTabInCommunityModelResponse> getTrendingPostsInCommunity();
}

class CommunityDatasourceImpl implements CommunityDatasource {
  final ApiServices _apiServices;

  CommunityDatasourceImpl(this._apiServices);

  @override
  Future<GetPostsCommunityModelResponse> getAllFeeds(int page) async {
    return await _apiServices.getAllFeeds(page);
  }

  @override
  Future<AddLikeOnPostModelResponse> addLikeOrUnlikeOnPost(
      String postId, String likeOrUnlike) async {
    return await _apiServices.addLikeOrUnlikeOnPost(postId, likeOrUnlike);
  }

  @override
  Future<SaveOrUnsavePostModelResponse> saveOrUnsavePost(
      {required String postId, required String saveOrUnsave}) async {
    return await _apiServices.saveOrUnsavePost(postId, saveOrUnsave);
  }

  @override
  Future<DeletePostModelResponse> deletePostInFeeds(
      {required String postId}) async {
    return await _apiServices.deletePostInFeeds(postId);
  }

  @override
  Future<GetGroupsTabModelResponse> getGroupsTab(int page) async {
    return await _apiServices.getGroupsTab(page);
  }

  @override
  Future<JoinGroupModelResponse> joinGroupInCommunity(String groupId) async {
    return await _apiServices.joinGroupInCommunity(groupId);
  }

  @override
  Future<GetTrendingTabInCommunityModelResponse>
      getTrendingPostsInCommunity() async {
    return await _apiServices.getTrendingPostsInCommunity();
  }
}
