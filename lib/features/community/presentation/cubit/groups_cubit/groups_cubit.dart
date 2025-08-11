import '../../../../../exports.dart';

class GroupsCubit extends Cubit<GroupsState> {
  GroupsCubit(
      this._getGroupsTabUsecase,
      this._addLikeOnPostUsecase,
      this._saveOrUnsavePostUsecase,
      this._joinGroupInCommunityUsecase,
      this._addVoteAndUnvoteUsecase,
      this._addOptionOnPollUsecase)
      : super(const GroupsState.initial());
  static GroupsCubit get(context) => BlocProvider.of(context);
  final GetGroupsTabUsecase _getGroupsTabUsecase;
  final AddLikeOnPostUsecase _addLikeOnPostUsecase;
  final SaveOrUnsavePostUsecase _saveOrUnsavePostUsecase;
  final JoinGroupInCommunityUsecase _joinGroupInCommunityUsecase;
  final AddVoteAndUnvoteUsecase _addVoteAndUnvoteUsecase;
  final AddOptionOnPollUsecase _addOptionOnPollUsecase;
  bool isLoadingMoreForScroll = false;
  bool isLastPage = false;
  int _currentPage = 1;
  int callGroupsTabTimes = 0;

  final Map<int, Set<int>> postSelectedOptions = {};
  final Map<int, int?> postSelectedOption = {};

  int changeCounter = 0;

  getGroupsTab() async {
    _currentPage = 1;
    emit(const GroupsState.loading());
    final result = await _getGroupsTabUsecase.execute(_currentPage);
    result.fold(
      (l) {
        emit(GroupsState.error(l.message));
      },
      (response) async {
        emit(GroupsState.loaded(
          response,
          '',
          '',
          false,
          changeCounter,
        ));
      },
    );
  }

  void loadMorePosts() async {
    _currentPage++;
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) => GroupsState.loaded(
        value.response,
        '',
        '',
        true,
        changeCounter,
      ),
    ));

    final result = await _getGroupsTabUsecase.execute(_currentPage);

    result.fold(
      (l) {
        _currentPage--;
        emit(GroupsState.error(l.message));
      },
      (loadMorePosts) async {
        final currentState = state;
        currentState.when(
          initial: () {},
          loading: () {},
          loaded: (
            response,
            snackBarMessage,
            dialogMessage,
            isSeeMore,
            changeCounter,
          ) {
            final updatedData = response.copyWith(
              data: response.data?.copyWith(
                randomPosts: response.data?.randomPosts?.copyWith(
                  data: [
                    ...(response.data?.randomPosts?.data ??
                        []), // ✅ Merging `randomPosts`
                    ...(loadMorePosts.data?.randomPosts?.data ?? []),
                  ],
                ),
              ),
            );

            isLastPage = (response.data?.randomPosts?.lastPage != null &&
                _currentPage >= response.data!.randomPosts!.lastPage!);
            isLoadingMoreForScroll = false;

            emit(GroupsState.loaded(
              updatedData,
              '',
              '',
              false,
              changeCounter,
            ));
          },
          error: (error) {},
        );
      },
    );
  }

  void joinGroup(String groupId) async {
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) {
        final response = value.response;
        if (response.data == null || response.data!.latestGroups == null) {
          return value; // Return unchanged state if data or latestGroups is null
        }

        // Find the group with the matching groupId and update its userStatus and memberCount
        final updatedGroups = response.data!.latestGroups!.map((group) {
          if (group.id.toString() == groupId) {
            return group.copyWith(
              userStatus: group.privacy == GroupPrivacy.private.name
                  ? GroupInviteStatus.pending.name
                  : GroupInviteStatus.joined.name,
              memberCount: group.privacy == GroupPrivacy.public.name
                  ? (group.memberCount ?? 0) + 1
                  : group.memberCount, // Increment memberCount
            ); // Update userStatus and memberCount
          }
          return group; // Return unchanged group if ID doesn't match
        }).toList();

        // Create a new data object with the updated groups
        final updatedData =
            response.data!.copyWith(latestGroups: updatedGroups);

        // Create a new response object with the updated data
        final updatedResponse = response.copyWith(data: updatedData);

        // Return a new state with the updated response
        return GroupsState.loaded(
          updatedResponse,
          '',
          '',
          false,
          changeCounter,
        );
      },
    ));

    final result = await _joinGroupInCommunityUsecase.execute(groupId);
    result.fold(
      (failure) {
        emit(state.maybeMap(
          orElse: () => state,
          loaded: (value) => GroupsState.loaded(
            value.response,
            '',
            failure.message,
            false,
            changeCounter,
          ),
        ));
      },
      (success) {
        // Optionally handle success case if needed
      },
    );
  }

  bool _isUpdatingPostLikeStatus = false; // Add this as a private flag
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
          final feedsResponse = value.response;
          if (feedsResponse.data == null ||
              feedsResponse.data!.randomPosts == null) {
            return value;
          }

          final randomPosts = feedsResponse.data!.randomPosts!;
          if (randomPosts.data == null) {
            return value;
          }

          // Create updated posts list
          final updatedPosts = randomPosts.data!.map((post) {
            if (post.id.toString() == postId) {
              // Store current values
              isCurrentlyLiked = post.isLiked ?? false;
              currentLikesCount = post.likesCount ?? 0;

              // Determine new values based on explicit action
              final newLikeStatus = likeOrUnlike == 'like';
              final likesCountChange = newLikeStatus
                  ? (isCurrentlyLiked ? 0 : 1)
                  : // Like: only increment if not already liked
                  (isCurrentlyLiked
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
          final updatedRandomPosts = randomPosts.copyWith(data: updatedPosts);
          final updatedData =
              feedsResponse.data!.copyWith(randomPosts: updatedRandomPosts);
          final updatedResponse = feedsResponse.copyWith(data: updatedData);

          return value.copyWith(response: updatedResponse);
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
              final feedsResponse = value.response;
              if (feedsResponse.data == null ||
                  feedsResponse.data!.randomPosts == null) {
                return value;
              }

              final randomPosts = feedsResponse.data!.randomPosts!;
              if (randomPosts.data == null) {
                return value;
              }

              // Revert to original values
              final revertedPosts = randomPosts.data!.map((post) {
                if (post.id.toString() == postId) {
                  return post.copyWith(
                    isLiked: isCurrentlyLiked,
                    likesCount: currentLikesCount,
                  );
                }
                return post;
              }).toList();

              final revertedRandomPosts =
                  randomPosts.copyWith(data: revertedPosts);
              final revertedData = feedsResponse.data!
                  .copyWith(randomPosts: revertedRandomPosts);
              final revertedResponse =
                  feedsResponse.copyWith(data: revertedData);

              return value.copyWith(response: revertedResponse);
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

  bool _isUpdatingPostSaveStatus = false; // Add this as a private flag

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
          final feedsResponse = value.response;
          if (feedsResponse.data == null ||
              feedsResponse.data!.randomPosts == null) {
            return value;
          }

          final randomPosts = feedsResponse.data!.randomPosts!;
          if (randomPosts.data == null) {
            return value;
          }

          final updatedPosts = randomPosts.data!.map((post) {
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

          final updatedRandomPosts = randomPosts.copyWith(data: updatedPosts);
          final updatedData =
              feedsResponse.data!.copyWith(randomPosts: updatedRandomPosts);
          final updatedResponse = feedsResponse.copyWith(data: updatedData);

          return value.copyWith(response: updatedResponse);
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
              final feedsResponse = value.response;
              if (feedsResponse.data == null ||
                  feedsResponse.data!.randomPosts == null) {
                return value;
              }

              final randomPosts = feedsResponse.data!.randomPosts!;
              if (randomPosts.data == null) {
                return value;
              }

              final revertedPosts = randomPosts.data!.map((post) {
                if (post.id.toString() == postId) {
                  return post.copyWith(
                    isSaved: isCurrentlySaved,
                  );
                }
                return post;
              }).toList();

              final revertedRandomPosts =
                  randomPosts.copyWith(data: revertedPosts);
              final revertedData = feedsResponse.data!
                  .copyWith(randomPosts: revertedRandomPosts);
              final revertedResponse =
                  feedsResponse.copyWith(data: revertedData);

              return value.copyWith(response: revertedResponse);
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

  Future<void> deletePost(String postId) async {
    await sl<CommunityCubit>().deletePost(postId);

    emit(
      state.maybeMap(
        orElse: () => state,
        loaded: (value) {
          // Filter out the deleted post
          final updatedPosts = value.response.data!.randomPosts!.data!
              .where((element) => element.id.toString() != postId)
              .toList();

          // Create a new state with the updated posts
          return GroupsState.loaded(
            value.response.copyWith(
              data: value.response.data!.copyWith(
                randomPosts: value.response.data!.randomPosts!.copyWith(
                  data: updatedPosts,
                ),
              ),
            ),
            '', // snackBarMessage
            '', // dialogMessage
            false, changeCounter,
          );
        },
      ),
    );
  }

  void addVoteAndUnVote(
    String pollId,
    int optionId,
  ) async {
    emit(
      state.maybeMap(
        orElse: () => state,
        loaded: (value) {
          // Update the posts with the new poll data
          final updatedPosts =
              value.response.data!.randomPosts!.data!.map((post) {
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
                  // Toggle new vote
                  return option.copyWith(
                    votesCount: (option.votesCount ?? 0) +
                        (option.isVoted == true ? -1 : 1),
                    isVoted: !(option.isVoted ?? false),
                  );
                } else if (!isMultipleChoice &&
                    option.id == previouslyVotedOptionId) {
                  // Reduce previous vote count for single-choice polls
                  return option.copyWith(
                    votesCount: (option.votesCount ?? 0) - 1,
                    isVoted: false,
                  );
                }
                return option;
              }).toList();

              // Update the poll with the new options
              final updatedPoll = poll.copyWith(options: updatedOptions);
              return post.copyWith(poll: updatedPoll);
            }
            return post;
          }).toList();

          // Create a new `randomPosts` object with the updated posts
          final updatedRandomPosts = value.response.data!.randomPosts!.copyWith(
            data: updatedPosts,
          );

          // Create a new `LatestGroupsData` object with the updated `randomPosts`
          final updatedLatestGroupsData = value.response.data!.copyWith(
            randomPosts: updatedRandomPosts,
          );

          // Create a new `GetGroupsTabModelResponse` with the updated data
          final updatedResponse = value.response.copyWith(
            data: updatedLatestGroupsData,
          );

          // Emit the new state with the updated response
          return GroupsState.loaded(
            updatedResponse,
            '',
            '',
            value.isSeeMore,
            value.changeCounter +
                1, // Increment changeCounter to trigger UI rebuild
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

  refreshScreen() {
    changeCounter = changeCounter + 1;
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) => GroupsState.loaded(
        value.response,
        '',
        '',
        false,
        changeCounter,
      ),
    ));
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
            loaded: (value) => GroupsState.loaded(
              value.response,
              l.message,
              '',
              value.isSeeMore,
              value.changeCounter,
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
              // Ensure randomPosts and data exist
              final updatedPosts =
                  value.response.data?.randomPosts?.data?.map((post) {
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

              return GroupsState.loaded(
                value.response.copyWith(
                  data: value.response.data?.copyWith(
                    randomPosts: value.response.data?.randomPosts?.copyWith(
                      data:
                          updatedPosts, // ✅ Assign to `data`, not `randomPosts`
                    ),
                  ),
                ),
                '',
                '',
                value.isSeeMore,
                value.changeCounter +
                    1, // ✅ Increment changeCounter to trigger UI update
              );
            },
          ),
        );
      },
    );
  }
}
