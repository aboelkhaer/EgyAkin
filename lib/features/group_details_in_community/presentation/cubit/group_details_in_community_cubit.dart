import 'package:egy_akin/features/community/domain/usecases/join_group_in_community_usecase.dart';
import 'package:egy_akin/features/group_details_in_community/domain/usecases/delete_group_in_community_usecase.dart';
import 'package:egy_akin/features/group_details_in_community/domain/usecases/get_group_details_in_community_usecase.dart';
import 'package:egy_akin/features/group_details_in_community/domain/usecases/leave_group_in_community_usecase.dart';
import 'package:egy_akin/features/group_details_in_community/presentation/cubit/group_details_in_community_state.dart';

import '../../../../exports.dart';

class GroupDetailsInCommunityCubit extends Cubit<GroupDetailsInCommunityState> {
  GroupDetailsInCommunityCubit(
      this._getGroupDetailsInCommunityUsecase,
      this._leaveGroupInCommunityUsecase,
      this._joinGroupInCommunityUsecase,
      this._addLikeOnPostUsecase,
      this._saveOrUnsavePostUsecase,
      this._deleteGroupInCommunityUsecase)
      : super(const GroupDetailsInCommunityState.initial());
  static GroupDetailsInCommunityCubit get(context) => BlocProvider.of(context);

  final GetGroupDetailsInCommunityUsecase _getGroupDetailsInCommunityUsecase;
  final JoinGroupInCommunityUsecase _joinGroupInCommunityUsecase;
  final LeaveGroupInCommunityUsecase _leaveGroupInCommunityUsecase;
  final AddLikeOnPostUsecase _addLikeOnPostUsecase;
  final SaveOrUnsavePostUsecase _saveOrUnsavePostUsecase;
  final DeleteGroupInCommunityUsecase _deleteGroupInCommunityUsecase;

  getGroupDetails(String groupId) async {
    emit(const GroupDetailsInCommunityState.loading());
    final result = await _getGroupDetailsInCommunityUsecase.execute(groupId);

    result.fold((l) {
      emit(GroupDetailsInCommunityState.error(l.message));
    }, (r) async {
      emit(GroupDetailsInCommunityState.loaded(
        r,
        '',
        '',
        false,
        false,
      ));
    });
  }

  void leaveGroup(String groupId) async {
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) {
        final response = value.groupDetails;
        if (response.data == null || response.data!.group == null) {
          return value; // Return unchanged state if data or group is null
        }

        // Check if the group ID matches the provided groupId
        if (response.data!.group!.id.toString() == groupId) {
          // Update the group's userStatus and memberCount
          final updatedGroup = response.data!.group!.copyWith(
            userStatus: null, // Set userStatus to null when leaving the group
            memberCount: (response.data!.group!.memberCount ?? 1) -
                1, // Decrement memberCount
          );

          // Create a new data object with the updated group
          final updatedData = response.data!.copyWith(group: updatedGroup);

          // Create a new response object with the updated data
          final updatedResponse = response.copyWith(data: updatedData);

          // Return a new state with the updated response
          return GroupDetailsInCommunityState.loaded(
            updatedResponse,
            '',
            '',
            false,
            false,
          );
        }

        return value; // Return unchanged state if the group ID doesn't match
      },
    ));
    final result = await _leaveGroupInCommunityUsecase.execute(groupId);

    result.fold(
      (l) {
        emit(
          state.maybeMap(
            orElse: () => state,
            loaded: (value) => GroupDetailsInCommunityState.loaded(
              value.groupDetails,
              l.message.toString(),
              '',
              false,
              false,
            ),
          ),
        );
      },
      (r) {},
    );
  }

  joinGroup(String groupId) async {
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) {
        final response = value.groupDetails;
        if (response.data == null || response.data!.group == null) {
          return value; // Return unchanged state if data or group is null
        }

        // Check if the group ID matches the provided groupId
        if (response.data!.group!.id.toString() == groupId) {
          // Update the group's userStatus and memberCount
          final updatedGroup = response.data!.group!.copyWith(
            userStatus: GroupInviteStatus
                .invited.name, // Set userStatus to null when leaving the group
            memberCount: (response.data!.group!.memberCount ?? 0) +
                1, // Decrement memberCount
          );

          // Create a new data object with the updated group
          final updatedData = response.data!.copyWith(group: updatedGroup);

          // Create a new response object with the updated data
          final updatedResponse = response.copyWith(data: updatedData);

          // Return a new state with the updated response
          return GroupDetailsInCommunityState.loaded(
            updatedResponse,
            '',
            '',
            false,
            false,
          );
        }

        return value; // Return unchanged state if the group ID doesn't match
      },
    ));
    final result = await _joinGroupInCommunityUsecase.execute(groupId);
    result.fold(
      (failure) {
        emit(state.maybeMap(
          orElse: () => state,
          loaded: (value) => GroupDetailsInCommunityState.loaded(
            value.groupDetails,
            '',
            failure.message,
            false,
            false,
          ),
        ));
      },
      (success) {
        // Optionally handle success case if needed
      },
    );
  }

  bool _isUpdatingPostLikeStatus =
      false; // Private flag to prevent multiple simultaneous actions

  void addLikeOrUnlikeOnPost(String postId) async {
    // Prevent multiple simultaneous actions
    if (_isUpdatingPostLikeStatus) return;

    _isUpdatingPostLikeStatus = true; // Set the flag to true

    // Store the current like status for rollback in case of failure
    bool isCurrentlyLiked = false;

    emit(
      state.maybeMap(
        orElse: () => state,
        loaded: (value) {
          final groupDetails = value.groupDetails;
          if (groupDetails.data == null || groupDetails.data!.posts == null) {
            return value; // Return unchanged state if groupDetails or posts is null
          }

          final posts = groupDetails.data!.posts!;
          if (posts.data == null) {
            return value; // Return unchanged state if posts.data is null
          }

          // Create a new list of posts with the updated like status
          final updatedPosts = posts.data!.map((post) {
            if (post.id.toString() == postId) {
              // Toggle isLiked and adjust likesCount
              isCurrentlyLiked =
                  post.isLiked ?? false; // Default to false if null
              final updatedLikesCount =
                  (post.likesCount ?? 0) + (isCurrentlyLiked ? -1 : 1);

              return post.copyWith(
                isLiked: !isCurrentlyLiked, // Toggle isLiked
                likesCount: updatedLikesCount, // Update likesCount
              );
            }
            return post; // Return unchanged post if ID doesn't match
          }).toList();

          // Create a new posts object with the updated posts
          final updatedPostsData = posts.copyWith(data: updatedPosts);

          // Create a new data object with the updated posts
          final updatedData =
              groupDetails.data!.copyWith(posts: updatedPostsData);

          // Create a new groupDetails object with the updated data
          final updatedGroupDetails = groupDetails.copyWith(data: updatedData);

          // Return a new state with the updated groupDetails
          return value.copyWith(groupDetails: updatedGroupDetails);
        },
      ),
    );

    // Determine the action (like or unlike) based on the current state
    final likeOrUnlike = isCurrentlyLiked ? 'unlike' : 'like';

    // Send the request to the server
    final result = await _addLikeOnPostUsecase.execute(
      AddLikeOnPostUsecaseInput(
        postId: postId,
        likeOrUnlike: likeOrUnlike,
      ),
    );

    result.fold(
      (failure) {
        // Rollback UI changes on failure
        emit(
          state.maybeMap(
            orElse: () => state,
            loaded: (value) {
              final groupDetails = value.groupDetails;
              if (groupDetails.data == null ||
                  groupDetails.data!.posts == null) {
                return value;
              }

              final posts = groupDetails.data!.posts!;
              if (posts.data == null) {
                return value;
              }

              // Revert the like status and likes count
              final revertedPosts = posts.data!.map((post) {
                if (post.id.toString() == postId) {
                  final revertedLikesCount = !isCurrentlyLiked
                      ? post.likesCount! - 1
                      : post.likesCount! + 1;

                  return post.copyWith(
                    isLiked: isCurrentlyLiked,
                    likesCount: revertedLikesCount,
                  );
                }
                return post;
              }).toList();

              // Create a new posts object with the reverted posts
              final revertedPostsData = posts.copyWith(data: revertedPosts);

              // Create a new data object with the reverted posts
              final revertedData =
                  groupDetails.data!.copyWith(posts: revertedPostsData);

              // Create a new groupDetails object with the reverted data
              final revertedGroupDetails =
                  groupDetails.copyWith(data: revertedData);

              // Return a new state with the reverted groupDetails
              return value.copyWith(groupDetails: revertedGroupDetails);
            },
          ),
        );
      },
      (success) {
        // Optionally handle success (e.g., show a toast or update other state)
      },
    );

    _isUpdatingPostLikeStatus = false; // Reset the flag
  }

  bool _isUpdatingPostSaveStatus =
      false; // Private flag to prevent multiple simultaneous actions

  void addSaveOrUnsaveOnPost(String postId) async {
    // Prevent multiple simultaneous actions
    if (_isUpdatingPostSaveStatus) return;

    _isUpdatingPostSaveStatus = true; // Set the flag to true

    // Store the current save status for rollback in case of failure
    bool isCurrentlySaved = false;

    emit(
      state.maybeMap(
        orElse: () => state,
        loaded: (value) {
          final groupDetails = value.groupDetails;
          if (groupDetails.data == null || groupDetails.data!.posts == null) {
            return value; // Return unchanged state if groupDetails or posts is null
          }

          final posts = groupDetails.data!.posts!;
          if (posts.data == null) {
            return value; // Return unchanged state if posts.data is null
          }

          // Create a new list of posts with the updated save status
          final updatedPosts = posts.data!.map((post) {
            if (post.id.toString() == postId) {
              // Toggle isSaved
              isCurrentlySaved =
                  post.isSaved ?? false; // Default to false if null
              return post.copyWith(
                isSaved: !isCurrentlySaved, // Toggle isSaved
              );
            }
            return post; // Return unchanged post if ID doesn't match
          }).toList();

          // Create a new posts object with the updated posts
          final updatedPostsData = posts.copyWith(data: updatedPosts);

          // Create a new data object with the updated posts
          final updatedData =
              groupDetails.data!.copyWith(posts: updatedPostsData);

          // Create a new groupDetails object with the updated data
          final updatedGroupDetails = groupDetails.copyWith(data: updatedData);

          // Return a new state with the updated groupDetails
          return value.copyWith(groupDetails: updatedGroupDetails);
        },
      ),
    );

    // Determine the action (save or unsave) based on the current state
    final saveOrUnsave = isCurrentlySaved ? 'unsave' : 'save';

    // Send the request to the server
    final result = await _saveOrUnsavePostUsecase.execute(
      SaveOrUnsavePostUsecaseInput(
        postId: postId,
        saveOrUnsave: saveOrUnsave,
      ),
    );

    result.fold(
      (failure) {
        // Rollback UI changes on failure
        emit(
          state.maybeMap(
            orElse: () => state,
            loaded: (value) {
              final groupDetails = value.groupDetails;
              if (groupDetails.data == null ||
                  groupDetails.data!.posts == null) {
                return value;
              }

              final posts = groupDetails.data!.posts!;
              if (posts.data == null) {
                return value;
              }

              // Revert the save status
              final revertedPosts = posts.data!.map((post) {
                if (post.id.toString() == postId) {
                  return post.copyWith(
                    isSaved: isCurrentlySaved, // Revert to original state
                  );
                }
                return post;
              }).toList();

              // Create a new posts object with the reverted posts
              final revertedPostsData = posts.copyWith(data: revertedPosts);

              // Create a new data object with the reverted posts
              final revertedData =
                  groupDetails.data!.copyWith(posts: revertedPostsData);

              // Create a new groupDetails object with the reverted data
              final revertedGroupDetails =
                  groupDetails.copyWith(data: revertedData);

              // Return a new state with the reverted groupDetails
              return value.copyWith(groupDetails: revertedGroupDetails);
            },
          ),
        );
      },
      (success) {
        // Optionally handle success (e.g., show a toast or update other state)
      },
    );

    _isUpdatingPostSaveStatus = false; // Reset the flag
  }

  deletePost(String postId) async {
    await sl<CommunityCubit>().deletePost(
      postId,
    );
    emit(
      state.maybeMap(
        orElse: () => state,
        loaded: (value) => GroupDetailsInCommunityState.loaded(
          value.groupDetails.copyWith(
            data: value.groupDetails.data!.copyWith(
                posts: value.groupDetails.data!.posts!.copyWith(
              data: value.groupDetails.data!.posts!.data!
                  .where((element) => element.id.toString() != postId)
                  .toList(),
            )),
          ),
          '',
          '',
          false,
          false,
        ),
      ),
    );
  }

  deleteGroup(String groupId) async {
    emit(
      state.maybeMap(
        orElse: () => state,
        loaded: (value) => GroupDetailsInCommunityState.loaded(
          value.groupDetails,
          '',
          '',
          true,
          false,
        ),
      ),
    );
    final result = await _deleteGroupInCommunityUsecase.execute(groupId);
    result.fold((l) {
      emit(
        state.maybeMap(
          orElse: () => state,
          loaded: (value) => GroupDetailsInCommunityState.loaded(
            value.groupDetails,
            l.message,
            '',
            false,
            false,
          ),
        ),
      );
    }, (r) async {
      emit(
        state.maybeMap(
          orElse: () => state,
          loaded: (value) => GroupDetailsInCommunityState.loaded(
            value.groupDetails,
            r.message.toString(),
            '',
            false,
            true,
          ),
        ),
      );
    });
  }
}
