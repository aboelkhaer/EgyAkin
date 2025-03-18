import 'dart:developer';

import 'package:egy_akin/features/community/domain/usecases/add_option_on_poll_usecase.dart';
import 'package:egy_akin/features/community/domain/usecases/add_vote_and_unvote_usecase.dart';
import 'package:egy_akin/features/community/presentation/cubit/community_state.dart';

import '../../../../exports.dart';

class CommunityCubit extends Cubit<CommunityState> {
  CommunityCubit(
    this._getAllFeedsUsecase,
    this._addLikeOnPostUsecase,
    this._saveOrUnsavePostUsecase,
    this._deletePostInFeedsUsecase,
    this._addVoteAndUnvoteUsecase,
    this._addOptionOnPollUsecase,
  ) : super(const CommunityState.initial());
  static CommunityCubit get(context) => BlocProvider.of(context);
  final GetAllFeedsUsecase _getAllFeedsUsecase;
  final AddLikeOnPostUsecase _addLikeOnPostUsecase;
  final SaveOrUnsavePostUsecase _saveOrUnsavePostUsecase;
  final DeletePostInFeedsUsecase _deletePostInFeedsUsecase;
  final AddVoteAndUnvoteUsecase _addVoteAndUnvoteUsecase;
  final AddOptionOnPollUsecase _addOptionOnPollUsecase;
  final Map<int, Set<int>> postSelectedOptions = {};
  final Map<int, int?> postSelectedOption = {};

  int changeCounter = 0;

  // ScrollController? feedsScrollController;

  bool isLoadingMoreForScroll = false;
  bool isLastPage = false;
  int _currentPage = 1;

  getAllFeeds() async {
    _currentPage = 1;
    postSelectedOptions.clear();
    postSelectedOption.clear();
    emit(const CommunityState.loading());
    final result = await _getAllFeedsUsecase.execute(_currentPage);
    result.fold(
      (l) {
        emit(CommunityState.error(l.message));
      },
      (postResponse) async {
        emit(CommunityState.loaded(
          postResponse,
          false,
          false,
          '',
          false,
          changeCounter,
        ));
      },
    );
  }

  addVoteAndUnVote(
    String pollId,
    int optionId,
  ) async {
    emit(
      state.maybeMap(
        orElse: () => state,
        loaded: (value) {
          final updatedFeeds = value.feedsResponse.data?.data?.map((post) {
            if (post.poll?.id.toString() == pollId) {
              final poll = post.poll!;
              final isMultipleChoice = poll.allowMultipleChoice ?? false;

              int? previouslyVotedOptionId;
              if (!isMultipleChoice) {
                // Find the previously voted option (for single-choice polls)
                previouslyVotedOptionId = poll.options!
                    .firstWhere((opt) => opt.isVoted ?? false,
                        orElse: () => const PollOptionsModelResponse(id: -1))
                    .id;
              }

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

              final updatedPoll = poll.copyWith(options: updatedOptions);
              return post.copyWith(poll: updatedPoll);
            }
            return post;
          }).toList();

          final updatedResponse = value.feedsResponse.copyWith(
            data: value.feedsResponse.data!.copyWith(data: updatedFeeds),
          );

          return CommunityState.loaded(
            updatedResponse,
            false,
            false,
            '',
            value.isSeeMore,
            changeCounter,
          );
        },
      ),
    );

    // API call
    final result = await _addVoteAndUnvoteUsecase.execute(
      AddVoteAndUnvoteUsecaseInput(
        pollId: pollId,
        optionId: optionId,
      ),
    );

    result.fold(
      (l) {}, // Handle failure
      (r) async {
        // Optionally re-fetch data from server if needed
      },
    );
  }

  refreshScreen() {
    changeCounter = changeCounter + 1;
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) => CommunityState.loaded(
        value.feedsResponse,
        value.isDeletePostLoading,
        value.isDeletePostLoaded,
        '',
        value.isSeeMore,
        changeCounter,
      ),
    ));
  }

  void loadMoreFeeds() async {
    _currentPage++;
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) => CommunityState.loaded(
        value.feedsResponse,
        false,
        false,
        '',
        true,
        changeCounter,
      ),
    ));
    final result = await _getAllFeedsUsecase.execute(_currentPage);
    result.fold(
      (l) {
        _currentPage--;
        emit(CommunityState.error(l.message));
      },
      (loadMoreFeeds) async {
        final currentState = state;
        currentState.when(
          initial: () {},
          loading: () {},
          loaded: (
            feedsResponse,
            isDeletePostLoading,
            isDeletePostLoaded,
            message,
            isSeeMore,
            changeCounter,
          ) {
            final updatedData = feedsResponse.copyWith(
              data: feedsResponse.data!.copyWith(
                data: [
                  ...feedsResponse.data!.data!,
                  ...loadMoreFeeds.data!.data!
                ],
              ),
            );
            if (_currentPage >= feedsResponse.data!.lastPage!) {
              isLastPage = true;
            } else {
              isLastPage = false;
            }
            isLoadingMoreForScroll = false;
            emit(CommunityState.loaded(
              updatedData,
              false,
              false,
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

  String postIdDeleted = '';
  // make delete post function
  deletePost(
    String postId,
  ) async {
    postIdDeleted = postId;
    emit(
      state.maybeMap(
        orElse: () => state,
        loaded: (value) => CommunityState.loaded(
          value.feedsResponse,
          true,
          false,
          '',
          false,
          changeCounter,
        ),
      ),
    );

    final deleteResult = await _deletePostInFeedsUsecase.execute(
      postId,
    );
    deleteResult.fold(
      (failure) {
        emit(
          state.maybeMap(
            orElse: () => state,
            loaded: (value) => CommunityState.loaded(
              value.feedsResponse,
              false,
              false,
              failure.message,
              false,
              changeCounter,
            ),
          ),
        );
      },
      (success) {
        // delete post from the list

        emit(
          state.maybeMap(
            orElse: () => state,
            loaded: (value) => CommunityState.loaded(
              value.feedsResponse.copyWith(
                data: value.feedsResponse.data!.copyWith(
                  data: value.feedsResponse.data!.data!
                      .where((element) => element.id.toString() != postId)
                      .toList(),
                ),
              ),
              false,
              true,
              success.message.toString(),
              false,
              changeCounter,
            ),
          ),
        );
      },
    );
    postIdDeleted = '';
  }

  bool _isUpdatingPostLikeStatus = false; // Add this as a private flag

  addLikeOrUnlikeOnPost(String postId) async {
    // Prevent multiple simultaneous actions
    if (_isUpdatingPostLikeStatus) return;

    _isUpdatingPostLikeStatus = true; // Set the flag to true
    bool isCurrentlyLiked = false;

    emit(
      state.maybeMap(
        orElse: () => state,
        loaded: (value) {
          final feedsResponse = value.feedsResponse;
          if (feedsResponse.data == null) {
            return value; // Return unchanged state if feedsResponse is null
          }

          final updatedData = feedsResponse.copyWith(
            data: feedsResponse.data!.copyWith(
              data: feedsResponse.data!.data!.map((post) {
                if (post.id.toString() == postId) {
                  // Toggle isLiked and adjust likesCount
                  isCurrentlyLiked =
                      post.isLiked ?? false; // Default to false if null
                  final updatedLikesCount = isCurrentlyLiked
                      ? post.likesCount! - 1 // Decrement if liked
                      : post.likesCount! + 1; // Increment if not liked

                  return post.copyWith(
                    isLiked: !isCurrentlyLiked, // Toggle isLiked
                    likesCount: updatedLikesCount, // Update likesCount
                  );
                }
                return post; // Return unchanged post if ID doesn't match
              }).toList(),
            ),
          );

          return value.copyWith(feedsResponse: updatedData);
        },
      ),
    );

    final likeOrUnlike = isCurrentlyLiked ? 'unlike' : 'like';

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
              final feedsResponse = value.feedsResponse;
              if (feedsResponse.data == null) {
                return value;
              }

              final revertedData = feedsResponse.copyWith(
                data: feedsResponse.data!.copyWith(
                  data: feedsResponse.data!.data!.map((post) {
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
                  }).toList(),
                ),
              );

              return value.copyWith(feedsResponse: revertedData);
            },
          ),
        );
      },
      (success) {
        // Optionally handle success
      },
    );

    _isUpdatingPostLikeStatus = false; // Reset the flag
  }

  void updatePost(PostCommunityModel updatedPost) {
    log('Updating post: ${updatedPost.id}'); // Debug log

    emit(
      state.maybeMap(
        orElse: () => state,
        loaded: (value) {
          // Map through the existing posts to update the one that matches the updatedPost's ID
          final updatedData = value.feedsResponse.data?.data?.map((post) {
            if (post.id == updatedPost.id) {
              return updatedPost; // Replace the old post with the updated one
            }
            return post;
          }).toList();

          // Create a new copy of feedsResponse with the updated data
          final updatedFeedsResponse = value.feedsResponse.copyWith(
            data: value.feedsResponse.data?.copyWith(
              data: updatedData,
            ),
          );

          // Emit the new state with the updated feedsResponse
          return CommunityState.loaded(
            updatedFeedsResponse,
            value.isDeletePostLoading,
            value.isDeletePostLoaded,
            value.message,
            false,
            changeCounter,
          );
        },
      ),
    );
  }

  bool _isUpdatingPostSaveStatus = false; // Add this as a private flag

  addSaveOrUnsaveOnPost(String postId) async {
    // Prevent multiple simultaneous actions
    if (_isUpdatingPostSaveStatus) return;

    _isUpdatingPostSaveStatus = true; // Set the flag to true
    bool isCurrentlySaved = false;

    emit(
      state.maybeMap(
        orElse: () => state,
        loaded: (value) {
          final feedsResponse = value.feedsResponse;
          if (feedsResponse.data == null) {
            return value;
          }

          final updatedData = feedsResponse.copyWith(
            data: feedsResponse.data!.copyWith(
              data: feedsResponse.data!.data!.map((post) {
                if (post.id.toString() == postId) {
                  isCurrentlySaved = post.isSaved ?? false;
                  return post.copyWith(
                    isSaved: !isCurrentlySaved,
                  );
                }
                return post;
              }).toList(),
            ),
          );
          return value.copyWith(feedsResponse: updatedData);
        },
      ),
    );

    final saveOrUnsave = isCurrentlySaved ? 'unsave' : 'save';

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
              final feedsResponse = value.feedsResponse;
              if (feedsResponse.data == null) {
                return value;
              }

              final revertedData = feedsResponse.copyWith(
                data: feedsResponse.data!.copyWith(
                  data: feedsResponse.data!.data!.map((post) {
                    if (post.id.toString() == postId) {
                      return post.copyWith(
                        isSaved: isCurrentlySaved, // Revert to original state
                      );
                    }
                    return post;
                  }).toList(),
                ),
              );
              return value.copyWith(feedsResponse: revertedData);
            },
          ),
        );
      },
      (success) {
        // Optionally handle success
      },
    );

    _isUpdatingPostSaveStatus = false; // Reset the flag
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
            loaded: (value) => CommunityState.loaded(
              value.feedsResponse,
              value.isDeletePostLoading,
              value.isDeletePostLoaded,
              'Failed to add option',
              value.isSeeMore,
              value.changeCounter, // Keep change counter the same
            ),
          ),
        );
      },
      (newOptionResponse) async {
        // Extract the option from AddOptionInPollModelResponse
        PollOptionsModelResponse newOption = PollOptionsModelResponse(
          id: newOptionResponse.data!.id,
          pollId: int.parse(newOptionResponse.data!.pollId!),
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
              // Ensure data exists
              final updatedPosts = value.feedsResponse.data?.copyWith(
                data: value.feedsResponse.data?.data?.map((post) {
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
                }).toList(),
              );

              return CommunityState.loaded(
                value.feedsResponse.copyWith(
                  data: updatedPosts,
                ),
                value.isDeletePostLoading,
                value.isDeletePostLoaded,
                'Option added successfully',
                value.isSeeMore,
                value.changeCounter +
                    1, // Increment change counter to trigger UI refresh
              );
            },
          ),
        );
      },
    );
  }
}
