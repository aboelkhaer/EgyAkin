import 'package:egy_akin/features/group_details_in_community/presentation/cubit/group_details_in_community_state.dart';

import '../../../../exports.dart';

class GroupDetailsInCommunityCubit extends Cubit<GroupDetailsInCommunityState> {
  GroupDetailsInCommunityCubit(
      this._getGroupDetailsInCommunityUsecase,
      this._leaveGroupInCommunityUsecase,
      this._joinGroupInCommunityUsecase,
      this._addLikeOnPostUsecase,
      this._saveOrUnsavePostUsecase,
      this._deleteGroupInCommunityUsecase,
      this._addVoteAndUnvoteUsecase,
      this._addOptionOnPollUsecase,
      this._acceptOrDeclineMemberInGroupUsecase)
      : super(const GroupDetailsInCommunityState.initial());
  static GroupDetailsInCommunityCubit get(context) => BlocProvider.of(context);

  final GetGroupDetailsInCommunityUsecase _getGroupDetailsInCommunityUsecase;
  final JoinGroupInCommunityUsecase _joinGroupInCommunityUsecase;
  final LeaveGroupInCommunityUsecase _leaveGroupInCommunityUsecase;
  final AddLikeOnPostUsecase _addLikeOnPostUsecase;
  final SaveOrUnsavePostUsecase _saveOrUnsavePostUsecase;
  final DeleteGroupInCommunityUsecase _deleteGroupInCommunityUsecase;
  final AddVoteAndUnvoteUsecase _addVoteAndUnvoteUsecase;
  final AddOptionOnPollUsecase _addOptionOnPollUsecase;
  final AcceptOrDeclineMemberInGroupUsecase
      _acceptOrDeclineMemberInGroupUsecase;

  final Map<int, Set<int>> postSelectedOptions = {};
  final Map<int, int?> postSelectedOption = {};

  int changeCounter = 1;
  bool isLoadingMoreForScroll = false;
  bool isLastPage = false;
  int _currentPage = 1;
  getGroupDetails(String groupId) async {
    emit(const GroupDetailsInCommunityState.loading());
    _currentPage = 1;
    final result = await _getGroupDetailsInCommunityUsecase.execute(
      GetGroupDetailsInCommunityUsecaseInput(
        groupId: groupId,
        page: _currentPage,
      ),
    );

    result.fold((l) {
      emit(GroupDetailsInCommunityState.error(l.message));
    }, (r) async {
      emit(GroupDetailsInCommunityState.loaded(
        r,
        '',
        '',
        false,
        false,
        changeCounter,
        false,
        false,
      ));
    });
  }

  void loadMoreFeeds(String groupId) async {
    _currentPage++;
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) => GroupDetailsInCommunityState.loaded(
        value.groupDetails,
        '',
        '',
        false,
        false,
        changeCounter,
        true,
        false,
      ),
    ));
    final result = await _getGroupDetailsInCommunityUsecase.execute(
      GetGroupDetailsInCommunityUsecaseInput(
        groupId: groupId,
        page: _currentPage,
      ),
    );
    result.fold(
      (l) {
        _currentPage--;
        emit(GroupDetailsInCommunityState.error(l.message));
      },
      (loadMoreFeeds) async {
        final currentState = state;
        currentState.when(
          initial: () {},
          loading: () {},
          loaded: (
            groupDetails,
            snackBarMessage,
            dialogMessage,
            isDeleteGroupLoading,
            isDeleteGroupLoaded,
            changeCounter,
            isSeeMore,
            isAcceptOrDeclineGroupInvitation,
          ) {
            final updatedData = groupDetails.copyWith(
              data: groupDetails.data!.copyWith(
                posts: groupDetails.data!.posts!.copyWith(
                  data: [
                    ...groupDetails.data!.posts!.data!,
                    ...loadMoreFeeds.data!.posts!.data!
                  ],
                ),
              ),
            );
            if (_currentPage >= groupDetails.data!.posts!.lastPage!) {
              isLastPage = true;
            } else {
              isLastPage = false;
            }
            isLoadingMoreForScroll = false;
            emit(GroupDetailsInCommunityState.loaded(
              updatedData,
              '',
              '',
              false,
              false,
              changeCounter,
              false,
              false,
            ));
          },
          error: (error) {},
        );
      },
    );
  }

  refreshScreen() {
    changeCounter = changeCounter + 1;
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) => GroupDetailsInCommunityState.loaded(
        value.groupDetails,
        '',
        '',
        value.isDeleteGroupLoading,
        value.isDeleteGroupLoaded,
        changeCounter,
        value.isSeeMore,
        value.isAcceptOrDeclineGroupInvitation,
      ),
    ));
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
            changeCounter,
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
              changeCounter,
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
            userStatus:
                response.data!.group!.privacy == GroupPrivacy.private.name
                    ? GroupInviteStatus.pending.name
                    : GroupInviteStatus.joined.name,
            memberCount: response.data!.group!.privacy ==
                    GroupPrivacy.public.name
                ? (response.data!.group!.memberCount ?? 0) + 1
                : response.data!.group!.memberCount, // Decrement memberCount
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
            changeCounter,
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
            changeCounter,
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

  void addLikeOrUnlikeOnPost(
    String postId, {
    required String likeOrUnlike, // 'like' or 'unlike'
  }) async {
    // Prevent multiple simultaneous actions
    if (_isUpdatingPostLikeStatus) return;
    _isUpdatingPostLikeStatus = true;

    // Store the current like status for rollback in case of failure
    bool isCurrentlyLiked = false;
    int? currentLikesCount;

    emit(
      state.maybeMap(
        orElse: () => state,
        loaded: (value) {
          final groupDetails = value.groupDetails;
          if (groupDetails.data == null || groupDetails.data!.posts == null) {
            return value;
          }

          final posts = groupDetails.data!.posts!;
          if (posts.data == null) {
            return value;
          }

          // Create updated posts list
          final updatedPosts = posts.data!.map((post) {
            if (post.id.toString() == postId) {
              // Store current values
              isCurrentlyLiked = post.isLiked ?? false;
              currentLikesCount = post.likesCount ?? 0;

              // Determine new values based on explicit action
              final newLikeStatus = likeOrUnlike == 'like';
              final likesCountChange = newLikeStatus
                  ? (isCurrentlyLiked
                      ? 0
                      : 1) // Like: only increment if not already liked
                  : (isCurrentlyLiked
                      ? -1
                      : 0); // Unlike: only decrement if currently liked

              return post.copyWith(
                isLiked: newLikeStatus,
                likesCount: currentLikesCount! + likesCountChange,
              );
            }
            return post;
          }).toList();

          // Update state hierarchy
          final updatedPostsData = posts.copyWith(data: updatedPosts);
          final updatedData =
              groupDetails.data!.copyWith(posts: updatedPostsData);
          final updatedGroupDetails = groupDetails.copyWith(data: updatedData);

          return value.copyWith(groupDetails: updatedGroupDetails);
        },
      ),
    );

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

              // Revert to original values
              final revertedPosts = posts.data!.map((post) {
                if (post.id.toString() == postId) {
                  return post.copyWith(
                    isLiked: isCurrentlyLiked,
                    likesCount: currentLikesCount,
                  );
                }
                return post;
              }).toList();

              final revertedPostsData = posts.copyWith(data: revertedPosts);
              final revertedData =
                  groupDetails.data!.copyWith(posts: revertedPostsData);
              final revertedGroupDetails =
                  groupDetails.copyWith(data: revertedData);

              return value.copyWith(groupDetails: revertedGroupDetails);
            },
          ),
        );
      },
      (success) {
        // Success case - no action needed as UI was already updated
      },
    );

    _isUpdatingPostLikeStatus = false;
  }

  bool _isUpdatingPostSaveStatus =
      false; // Private flag to prevent multiple simultaneous actions

  Future<void> addSaveOrUnsaveOnPost(
    String postId, {
    required String saveOrUnsave, // 'save' or 'unsave' (required)
  }) async {
    if (_isUpdatingPostSaveStatus) return;
    _isUpdatingPostSaveStatus = true;

    bool isCurrentlySaved = false;

    emit(
      state.maybeMap(
        orElse: () => state,
        loaded: (value) {
          final groupDetails = value.groupDetails;
          if (groupDetails.data == null || groupDetails.data!.posts == null) {
            return value;
          }

          final posts = groupDetails.data!.posts!;
          if (posts.data == null) {
            return value;
          }

          final updatedPosts = posts.data!.map((post) {
            if (post.id.toString() == postId) {
              isCurrentlySaved = post.isSaved ?? false;

              // Determine new state based on explicit action
              final newSavedStatus = saveOrUnsave == 'save';
              return post.copyWith(
                isSaved: newSavedStatus,
              );
            }
            return post;
          }).toList();

          final updatedPostsData = posts.copyWith(data: updatedPosts);
          final updatedData =
              groupDetails.data!.copyWith(posts: updatedPostsData);
          final updatedGroupDetails = groupDetails.copyWith(data: updatedData);

          return value.copyWith(groupDetails: updatedGroupDetails);
        },
      ),
    );

    final result = await _saveOrUnsavePostUsecase.execute(
      SaveOrUnsavePostUsecaseInput(
        postId: postId,
        saveOrUnsave: saveOrUnsave,
      ),
    );

    result.fold(
      (failure) {
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

              final revertedPosts = posts.data!.map((post) {
                if (post.id.toString() == postId) {
                  return post.copyWith(
                    isSaved: isCurrentlySaved,
                  );
                }
                return post;
              }).toList();

              final revertedPostsData = posts.copyWith(data: revertedPosts);
              final revertedData =
                  groupDetails.data!.copyWith(posts: revertedPostsData);
              final revertedGroupDetails =
                  groupDetails.copyWith(data: revertedData);

              return value.copyWith(groupDetails: revertedGroupDetails);
            },
          ),
        );
      },
      (success) {
        // Success case - no action needed
      },
    );

    _isUpdatingPostSaveStatus = false;
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
          changeCounter,
          value.isSeeMore,
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
          changeCounter,
          false,
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
            changeCounter,
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
            changeCounter,
            false,
            false,
          ),
        ),
      );
    });
  }

  void addVoteAndUnVote(
    String pollId,
    int optionId,
  ) async {
    emit(
      state.maybeMap(
        orElse: () => state,
        loaded: (value) {
          // Update the posts in the group details
          final updatedPosts =
              value.groupDetails.data?.posts?.data?.map((post) {
            if (post.poll?.id.toString() == pollId) {
              final poll = post.poll!;
              final isMultipleChoice = poll.allowMultipleChoice ?? false;

              int? previouslyVotedOptionId;
              if (!isMultipleChoice) {
                // Find the previously voted option (for single-choice polls)
                previouslyVotedOptionId = poll.options!
                    .firstWhere(
                      (opt) => opt.isVoted ?? false,
                      orElse: () => const PollOptionsModelResponse(id: -1),
                    )
                    .id;
              }

              // Update the poll options
              final updatedOptions = poll.options!.map((option) {
                if (option.id == optionId) {
                  // Toggle the vote for the selected option
                  return option.copyWith(
                    votesCount: (option.votesCount ?? 0) +
                        (option.isVoted == true ? -1 : 1),
                    isVoted: !(option.isVoted ?? false),
                  );
                } else if (!isMultipleChoice &&
                    option.id == previouslyVotedOptionId) {
                  // Reduce the vote count for the previously voted option (single-choice polls)
                  return option.copyWith(
                    votesCount: (option.votesCount ?? 0) - 1,
                    isVoted: false,
                  );
                }
                return option; // No change for other options
              }).toList();

              // Update the poll with the new options
              final updatedPoll = poll.copyWith(options: updatedOptions);

              // Return the updated post
              return post.copyWith(poll: updatedPoll);
            }
            return post; // No change for other posts
          }).toList();

          // Update the posts in the group details response
          final updatedPostsResponse = value.groupDetails.data?.posts?.copyWith(
            data: updatedPosts,
          );

          // Update the group details with the new posts
          final updatedGroupDetails = value.groupDetails.data?.copyWith(
            posts: updatedPostsResponse,
          );

          // Update the state with the new group details
          return GroupDetailsInCommunityState.loaded(
            value.groupDetails.copyWith(data: updatedGroupDetails),
            '',
            '',
            false,
            false,
            value.changeCounter,
            value.isSeeMore,
            false,
          );
        },
      ),
    );

    // Make the API call to update the vote
    final result = await _addVoteAndUnvoteUsecase.execute(
      AddVoteAndUnvoteUsecaseInput(
        pollId: pollId,
        optionId: optionId,
      ),
    );

    result.fold(
      (l) {
        // Handle failure (e.g., show an error message)
      },
      (r) async {
        // Optionally re-fetch data from the server if needed
      },
    );
  }

  addOptionOnPoll(
    String pollId,
    String option,
  ) async {
    final result = await _addOptionOnPollUsecase.execute(
      AddOptionOnPollUsecaseInput(
        pollId: pollId,
        option: option,
      ),
    );

    result.fold(
      (l) {
        emit(
          state.maybeMap(
            orElse: () => state,
            loaded: (value) => GroupDetailsInCommunityState.loaded(
              value.groupDetails,
              'Failed to add option', // Snackbar message for failure
              '', // No dialog message
              value.isDeleteGroupLoading,
              value.isDeleteGroupLoaded,
              value.changeCounter,
              value.isSeeMore, false,
            ),
          ),
        );
      },
      (newOptionResponse) async {
        if (newOptionResponse.data == null) return;

        PollOptionsModelResponse newOption = PollOptionsModelResponse(
          id: newOptionResponse.data!.id,
          pollId: int.parse(newOptionResponse.data!.pollId.toString()),
          optionText: newOptionResponse.data!.option.toString(),
          createdAt: newOptionResponse.data!.createdAt,
          updatedAt: newOptionResponse.data!.updatedAt,
          votesCount: 0, // Default votes count for new option
          isVoted: false,
        );

        emit(
          state.maybeMap(
            orElse: () => state,
            loaded: (value) {
              // Ensure groupDetails and posts exist
              final updatedPosts =
                  value.groupDetails.data?.posts?.data?.map((post) {
                if (post.poll?.id.toString() == pollId) {
                  return post.copyWith(
                    poll: post.poll?.copyWith(
                      options: [
                        ...(post.poll?.options ?? []), // Keep old options
                        newOption, // Append new option
                      ],
                    ),
                  );
                }
                return post;
              }).toList();

              // Create a new instance of GetGroupDetailsInCommunityModelResponse with updated posts
              final updatedGroupDetails =
                  GetGroupDetailsInCommunityModelResponse(
                data: value.groupDetails.data?.copyWith(
                  posts: value.groupDetails.data?.posts?.copyWith(
                    data: updatedPosts,
                  ),
                ),
              );

              return GroupDetailsInCommunityState.loaded(
                updatedGroupDetails,
                '',
                '', // No dialog message
                value.isDeleteGroupLoading,
                value.isDeleteGroupLoaded,
                value.changeCounter +
                    1, // Increment changeCounter to trigger UI update
                value.isSeeMore, false,
              );
            },
          ),
        );
      },
    );
  }

  changeIsHasInvitationsValue() {
    emit(
      state.maybeMap(
        orElse: () => state,
        loaded: (value) => GroupDetailsInCommunityState.loaded(
          value.groupDetails.copyWith(
            data: value.groupDetails.data?.copyWith(
              group: value.groupDetails.data?.group?.copyWith(
                isHasPendingInvitations: false,
              ),
            ),
          ),
          '',
          '',
          value.isDeleteGroupLoading,
          value.isDeleteGroupLoaded,
          value.changeCounter + 1, // Increment to force state change
          value.isSeeMore, false,
        ),
      ),
    );
  }

  acceptOrDeclineGroupInvitation({
    required String groupId,
    required int invitationId,
    required String status,
    required String doctorId,
  }) async {
    emit(
      state.maybeMap(
        orElse: () => state,
        loaded: (value) => GroupDetailsInCommunityState.loaded(
          value.groupDetails,
          '',
          '',
          value.isDeleteGroupLoading,
          value.isDeleteGroupLoaded,
          value.changeCounter + 1,
          value.isSeeMore,
          true,
        ),
      ),
    );
    final result = await _acceptOrDeclineMemberInGroupUsecase.execute(
      AcceptOrDeclineMemberInGroupUsecaseInput(
          groupId: groupId, status: status, invitationId: invitationId),
    );
    result.fold((l) {
      emit(
        state.maybeMap(
          orElse: () => state,
          loaded: (value) => GroupDetailsInCommunityState.loaded(
            value.groupDetails,
            l.message,
            '',
            value.isDeleteGroupLoading,
            value.isDeleteGroupLoaded,
            value.changeCounter + 1,
            value.isSeeMore,
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
            '',
            '',
            value.isDeleteGroupLoading,
            value.isDeleteGroupLoaded,
            value.changeCounter + 1,
            value.isSeeMore,
            false,
          ),
        ),
      );
      getGroupDetails(groupId);
    });
  }

  void increaseOrDecreaseMembers(bool isIncrease) {
    emit(
      state.maybeMap(
        orElse: () => state,
        loaded: (value) {
          // Check for null group data first
          if (value.groupDetails.data?.group == null) {
            return state;
          }

          // Calculate new member count
          final currentCount = value.groupDetails.data!.group!.memberCount ?? 0;
          final newCount = isIncrease ? currentCount + 1 : currentCount - 1;

          // Create updated group
          final updatedGroup = value.groupDetails.data!.group!.copyWith(
            memberCount: newCount,
          );

          // Create updated data
          final updatedData = value.groupDetails.data!.copyWith(
            group: updatedGroup,
          );

          // Create final updated group details
          final updatedGroupDetails = value.groupDetails.copyWith(
            data: updatedData,
          );

          // Return new state
          return GroupDetailsInCommunityState.loaded(
            updatedGroupDetails,
            value.snackBarMessage,
            value.dialogMessage,
            value.isDeleteGroupLoading,
            value.isDeleteGroupLoaded,
            changeCounter,
            value.isSeeMore,
            value.isAcceptOrDeclineGroupInvitation,
          );
        },
      ),
    );
  }
}
