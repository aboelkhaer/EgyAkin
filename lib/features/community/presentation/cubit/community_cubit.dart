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
    isLastPage = false;
    isLoadingMoreForScroll = false;
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
  
  // Reset pagination state
  void resetPaginationState() {
    isLastPage = false;
    isLoadingMoreForScroll = false;
    _currentPage = 1;
  }
  
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

        emit(state.maybeMap(
          orElse: () => state,
          loaded: (value) {
            final currentPosts = value.feedsResponse.data?.data ?? [];
            // Final cleanup - ensure post is removed
            return CommunityState.loaded(
              value.feedsResponse.copyWith(
                data: value.feedsResponse.data?.copyWith(
                  data: currentPosts
                      .where((post) => post.id.toString() != postId)
                      .toList(),
                ),
              ),
              false, // isDeletePostLoading
              true, // isDeletePostLoaded
              success.message.toString(),
              value.isSeeMore,
              value.changeCounter + 1,
            );
          },
        ));
      },
    );
    postIdDeleted = '';
  }

  final Set<String> _updatingPostIds = {};

  Future<void> addLikeOrUnlikeOnPost(
    String postId, {
    required String likeOrUnlike, // 'like' or 'unlike'
  }) async {
    if (_updatingPostIds.contains(postId)) return;
    _updatingPostIds.add(postId);

    try {
      // First get the current like status if not explicitly provided
      bool? wasLiked;
      emit(
        state.maybeMap(
          loaded: (loadedState) {
            final posts = loadedState.feedsResponse.data?.data;
            if (posts == null) return loadedState;

            final index =
                posts.indexWhere((post) => post.id.toString() == postId);
            if (index == -1) return loadedState;

            final post = posts[index];
            wasLiked = post.isLiked ?? false;

            // Determine the new like status based on the action
            final newLikeStatus = likeOrUnlike == 'like' ? true : false;
            final likesCountChange = likeOrUnlike == 'like' ? 1 : -1;

            final updatedPost = post.copyWith(
              isLiked: newLikeStatus,
              likesCount: (post.likesCount ?? 0) + likesCountChange,
            );

            final updatedPosts = [...posts]..[index] = updatedPost;
            final updatedResponse = loadedState.feedsResponse.copyWith(
              data:
                  loadedState.feedsResponse.data!.copyWith(data: updatedPosts),
            );

            return loadedState.copyWith(feedsResponse: updatedResponse);
          },
          orElse: () => state,
        ),
      );

      // Make the API call
      final result = await _addLikeOnPostUsecase.execute(
        AddLikeOnPostUsecaseInput(
          postId: postId,
          likeOrUnlike: likeOrUnlike,
        ),
      );

      result.fold(
        (failure) {
          // Revert the changes if the API call fails
          emit(
            state.maybeMap(
              loaded: (loadedState) {
                final posts = loadedState.feedsResponse.data?.data;
                if (posts == null) return loadedState;

                final index =
                    posts.indexWhere((post) => post.id.toString() == postId);
                if (index == -1) return loadedState;

                // Revert to the original like status
                final originalPost = posts[index].copyWith(
                  isLiked: wasLiked,
                  likesCount: (posts[index].likesCount ?? 0) +
                      (likeOrUnlike == 'like' ? -1 : 1),
                );

                final updatedPosts = [...posts]..[index] = originalPost;
                final updatedResponse = loadedState.feedsResponse.copyWith(
                  data: loadedState.feedsResponse.data!
                      .copyWith(data: updatedPosts),
                );

                return loadedState.copyWith(feedsResponse: updatedResponse);
              },
              orElse: () => state,
            ),
          );
        },
        (success) {
          // Success case is already handled by the optimistic update
        },
      );
    } catch (e) {
      debugPrint('Error in addLikeOrUnlikeOnPost: $e');
    } finally {
      _updatingPostIds.remove(postId);
    }
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

  final Set<String> _updatingSavePostIds = {};

  Future<void> addSaveOrUnsaveOnPost(
    String postId, {
    required String saveOrUnsave, // 'save' or 'unsave' (required)
  }) async {
    if (_updatingSavePostIds.contains(postId)) return;

    _updatingSavePostIds.add(postId);
    bool wasSaved = false;

    emit(
      state.maybeMap(
        loaded: (loadedState) {
          final posts = loadedState.feedsResponse.data?.data;
          if (posts == null) return loadedState;

          final index =
              posts.indexWhere((post) => post.id.toString() == postId);
          if (index == -1) return loadedState;

          final post = posts[index];
          wasSaved = post.isSaved ?? false;

          // Determine new state based on parameter
          final newSavedStatus = saveOrUnsave == 'save';
          final updatedPost = post.copyWith(isSaved: newSavedStatus);
          final updatedPosts = [...posts]..[index] = updatedPost;

          final updatedResponse = loadedState.feedsResponse.copyWith(
            data: loadedState.feedsResponse.data!.copyWith(data: updatedPosts),
          );

          return loadedState.copyWith(feedsResponse: updatedResponse);
        },
        orElse: () => state,
      ),
    );

    final result = await _saveOrUnsavePostUsecase.execute(
      SaveOrUnsavePostUsecaseInput(
        postId: postId,
        saveOrUnsave: saveOrUnsave, // Use the provided parameter directly
      ),
    );

    result.fold(
      (failure) {
        // Rollback UI update on failure
        emit(
          state.maybeMap(
            loaded: (loadedState) {
              final posts = loadedState.feedsResponse.data?.data;
              if (posts == null) return loadedState;

              final index =
                  posts.indexWhere((post) => post.id.toString() == postId);
              if (index == -1) return loadedState;

              final revertedPost = posts[index].copyWith(isSaved: wasSaved);
              final revertedPosts = [...posts]..[index] = revertedPost;

              final updatedResponse = loadedState.feedsResponse.copyWith(
                data: loadedState.feedsResponse.data!
                    .copyWith(data: revertedPosts),
              );

              return loadedState.copyWith(feedsResponse: updatedResponse);
            },
            orElse: () => state,
          ),
        );
      },
      (_) {
        // Optionally handle success
      },
    );

    _updatingSavePostIds.remove(postId);
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
                '',
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
