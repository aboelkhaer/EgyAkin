import 'package:egy_akin/app/shared/functions/profile_post_counts.dart';
import 'package:egy_akin/features/saved_posts/presentation/cubit/saved_posts_state.dart';

import '../../../../exports.dart';

class SavedPostsCubit extends Cubit<SavedPostsState> {
  SavedPostsCubit(
      this._getSavedPostsUsecase,
      this._addLikeOnPostUsecase,
      this._saveOrUnsavePostUsecase,
      this._deletePostInFeedsUsecase,
      this._addVoteAndUnvoteUsecase,
      this._addOptionOnPollUsecase)
      : super(const SavedPostsState.initial());
  static SavedPostsCubit get(context) => BlocProvider.of(context);

  final GetSavedPostsUsecase _getSavedPostsUsecase;
  final AddLikeOnPostUsecase _addLikeOnPostUsecase;
  final SaveOrUnsavePostUsecase _saveOrUnsavePostUsecase;
  final DeletePostInFeedsUsecase _deletePostInFeedsUsecase;
  final AddVoteAndUnvoteUsecase _addVoteAndUnvoteUsecase;
  final AddOptionOnPollUsecase _addOptionOnPollUsecase;
  ScrollController? scrollController;

  int currentPage = 1;
  bool isLoadingMoreForScroll = false;
  bool isLastPage = false;
  final Map<int, Set<int>> postSelectedOptions = {};
  final Map<int, int?> postSelectedOption = {};

  int changeCounter = 0;

  bool get hasLoadedList => state.maybeWhen(
        loaded: (_, __, ___, ____, _____, ______, _______) => true,
        orElse: () => false,
      );

  Future<void> ensureSavedPostsLoaded(String doctorId) async {
    if (hasLoadedList) return;
    await getSavedPosts(doctorId);
  }

  void upsertSavedPost(PostCommunityModel post) {
    if (post.id == null) return;
    final savedPost = post.copyWith(isSaved: true);
    emit(
      state.maybeMap(
        orElse: () => state,
        loaded: (value) {
          final data = value.response.data;
          if (data == null) return value;
          final list = [...(data.data ?? const <PostCommunityModel>[])];
          final id = savedPost.id.toString();
          final existed = list.any((p) => p.id.toString() == id);
          list.removeWhere((p) => p.id.toString() == id);
          list.insert(0, savedPost);
          changeCounter++;
          final total = data.total;
          return SavedPostsState.loaded(
            value.response.copyWith(
              data: data.copyWith(
                data: list,
                total: existed || total == null ? total : total + 1,
              ),
            ),
            '',
            '',
            false,
            false,
            false,
            changeCounter,
          );
        },
      ),
    );
  }

  void removeSavedPost(String postId) {
    if (postId.isEmpty || postId == 'null') return;
    emit(
      state.maybeMap(
        orElse: () => state,
        loaded: (value) {
          final data = value.response.data;
          if (data == null) return value;
          final list = [...(data.data ?? const <PostCommunityModel>[])];
          final index = list.indexWhere((p) => p.id.toString() == postId);
          if (index < 0) return value;
          list.removeAt(index);
          changeCounter++;
          final total = data.total;
          return SavedPostsState.loaded(
            value.response.copyWith(
              data: data.copyWith(
                data: list,
                total: total == null ? null : (total - 1).clamp(0, 1 << 30),
              ),
            ),
            '',
            '',
            false,
            false,
            false,
            changeCounter,
          );
        },
      ),
    );
  }

  Future<void> getSavedPosts(String doctorId) async {
    emit(const SavedPostsState.loading());
    currentPage = 1;
    isLastPage = false;
    final result = await _getSavedPostsUsecase.execute(
        GetSavedPostsUsecaseInput(doctorId: doctorId, page: currentPage));
    result.fold(
      (l) {
        emit(SavedPostsState.error(l.message));
      },
      (response) async {
        emit(SavedPostsState.loaded(
          response,
          '',
          '',
          false,
          false,
          false,
          changeCounter,
        ));
      },
    );
  }

  void loadMoreFeeds(String doctorId) async {
    currentPage++;
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) => SavedPostsState.loaded(
        value.response,
        '',
        '',
        false,
        false,
        true,
        changeCounter,
      ),
    ));
    final result = await _getSavedPostsUsecase.execute(
        GetSavedPostsUsecaseInput(doctorId: doctorId, page: currentPage));
    result.fold(
      (l) {
        currentPage--;
        emit(SavedPostsState.error(l.message));
      },
      (loadMoreFeeds) async {
        final currentState = state;
        currentState.when(
          initial: () {},
          loading: () {},
          loaded: (
            response,
            snackBarMessage,
            dialogMessage,
            isDeletePostLoading,
            isDeletePostLoaded,
            isSeeMore,
            changeCounter,
          ) {
            final updatedData = response.copyWith(
              data: response.data!.copyWith(
                data: [...response.data!.data!, ...loadMoreFeeds.data!.data!],
              ),
            );
            if (currentPage >= response.data!.lastPage!) {
              isLastPage = true;
            } else {
              isLastPage = false;
            }
            isLoadingMoreForScroll = false;
            emit(SavedPostsState.loaded(
              updatedData,
              '',
              '',
              false,
              false,
              false,
              changeCounter,
            ));
          },
          error: (error) {},
        );
      },
    );
  }

  bool _isUpdatingPostLikeStatus = false;

  Future<void> addLikeOrUnlikeOnPost(
    String postId, {
    required String likeOrUnlike, // 'like' or 'unlike' (required)
  }) async {
    if (_isUpdatingPostLikeStatus) return;
    _isUpdatingPostLikeStatus = true;

    bool isCurrentlyLiked = false;
    int currentLikesCount = 0; // Changed to non-nullable with default value

    /// 1️⃣ Optimistic UI Update
    emit(
      state.maybeMap(
        loaded: (value) {
          final response = value.response;
          if (response.data == null || response.data!.data == null) {
            return value;
          }

          final postList = response.data!.data!;

          final updatedPosts = postList.map((post) {
            if (post.id == int.tryParse(postId)) {
              isCurrentlyLiked = post.isLiked ?? false;
              currentLikesCount = post.likesCount ?? 0; // Ensure non-null value

              // Calculate new state based on explicit action
              final newLikeStatus = likeOrUnlike == 'like';
              final likesCountChange = newLikeStatus
                  ? (isCurrentlyLiked ? 0 : 1) // Like action
                  : (isCurrentlyLiked ? -1 : 0); // Unlike action

              return post.copyWith(
                isLiked: newLikeStatus,
                likesCount: currentLikesCount + likesCountChange, // Now safe
              );
            }
            return post;
          }).toList();

          final updatedResponse = response.copyWith(
            data: response.data!.copyWith(data: updatedPosts),
          );

          return SavedPostsState.loaded(
            updatedResponse,
            '',
            '',
            false,
            false,
            false,
            changeCounter + 1, // Increment to ensure UI update
          );
        },
        orElse: () => state,
      ),
    );

    /// 2️⃣ API Request
    final result = await _addLikeOnPostUsecase.execute(
      AddLikeOnPostUsecaseInput(
        postId: postId,
        likeOrUnlike: likeOrUnlike,
      ),
    );

    result.fold(
      (failure) {
        /// 3️⃣ Rollback on Failure
        emit(
          state.maybeMap(
            loaded: (value) {
              final response = value.response;
              if (response.data == null || response.data!.data == null) {
                return value;
              }

              final revertedPosts = response.data!.data!.map((post) {
                if (post.id == int.tryParse(postId)) {
                  return post.copyWith(
                    isLiked: isCurrentlyLiked,
                    likesCount: currentLikesCount, // Now using non-null value
                  );
                }
                return post;
              }).toList();

              final revertedResponse = response.copyWith(
                data: response.data!.copyWith(data: revertedPosts),
              );

              return SavedPostsState.loaded(
                revertedResponse,
                '',
                '',
                false,
                false,
                false,
                changeCounter + 1,
              );
            },
            orElse: () => state,
          ),
        );
      },
      (success) {
        // Success case - no action needed
      },
    );

    _isUpdatingPostLikeStatus = false;
  }

  bool _isUpdatingPostSaveStatus =
      false; // Private flag to prevent multiple simultaneous actions

  Future<void> addSaveOrUnsaveOnPost(
    String postId, {
    required String saveOrUnsave, // 'save' or 'unsave' (required)
    PostCommunityModel? post,
  }) async {
    // Prevent multiple simultaneous actions
    if (_isUpdatingPostSaveStatus) return;
    _isUpdatingPostSaveStatus = true;

    PostCommunityModel? targetPost;
    state.maybeWhen(
      orElse: () {},
      loaded: (response, _, __, ___, ____, _____, ______) {
        for (final post in response.data?.data ?? const []) {
          if (post.id.toString() == postId) {
            targetPost = post;
            break;
          }
        }
      },
    );
    targetPost ??= post;

    if (targetPost != null) {
      if (saveOrUnsave == 'save') {
        upsertSavedPost(targetPost!);
      } else {
        removeSavedPost(postId);
      }
    }

    ProfilePostCounts.onSaveOrUnsave(saveOrUnsave);

    /// **2️⃣ Send API Request**
    debugPrint("[Save] 📡 Sending $saveOrUnsave request for post $postId");
    final result = await _saveOrUnsavePostUsecase.execute(
      SaveOrUnsavePostUsecaseInput(
        postId: postId,
        saveOrUnsave: saveOrUnsave,
      ),
    );

    result.fold(
      (failure) {
        debugPrint("[Save] ❌ API Failed: ${failure.message}");
        if (targetPost != null) {
          if (saveOrUnsave == 'save') {
            removeSavedPost(postId);
          } else {
            upsertSavedPost(targetPost!);
          }
        }
        ProfilePostCounts.revertSaveOrUnsave(saveOrUnsave);
      },
      (success) {
        debugPrint("[Save] ✅ API Success: $saveOrUnsave applied successfully");
      },
    );

    _isUpdatingPostSaveStatus = false; // Reset the flag
    debugPrint("[Save] 🏁 Operation completed for post $postId");
  }

  String postIdDeleted = '';
  Future<void> deletePost(String postId) async {
    // Step 1: Delete the post using your Cubit or repository

    postIdDeleted = postId;
    emit(
      state.maybeMap(
        orElse: () => state,
        loaded: (value) => SavedPostsState.loaded(
          value.response,
          '',
          '',
          true,
          false,
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
            loaded: (value) => SavedPostsState.loaded(
              value.response,
              failure.message,
              '',
              false,
              false,
              false,
              changeCounter,
            ),
          ),
        );
      },
      (success) {
        // delete post from the list
        ProfilePostCounts.onOwnPostDeleted(wasSaved: true);

        emit(
          state.maybeMap(
            orElse: () => state,
            loaded: (value) => SavedPostsState.loaded(
              value.response.copyWith(
                data: value.response.data!.copyWith(
                  data: value.response.data!.data!
                      .where((element) => element.id.toString() != postId)
                      .toList(),
                ),
              ),
              success.message.toString(),
              '',
              false,
              true,
              false,
              changeCounter,
            ),
          ),
        );
      },
    );
    postIdDeleted = '';
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
          final updatedPosts = value.response.data!.data!.map((post) {
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
          final updatedRandomPosts = value.response.data!.copyWith(
            data: updatedPosts,
          );

          // Create a new `GetGroupsTabModelResponse` with the updated data
          final updatedResponse = value.response.copyWith(
            data: updatedRandomPosts,
          );

          // Emit the new state with the updated response
          return SavedPostsState.loaded(
            updatedResponse,
            '',
            '',
            value.isDeletePostLoading,
            value.isDeletePostLoaded,
            value.isSeeMore,
            changeCounter,
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
      loaded: (value) => SavedPostsState.loaded(
        value.response,
        '',
        '',
        value.isDeletePostLoading,
        value.isDeletePostLoaded,
        value.isSeeMore,
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
            loaded: (value) => SavedPostsState.loaded(
              value.response,
              l.message, // Snackbar message for failure
              '', // No dialog message
              value.isDeletePostLoading,
              value.isDeletePostLoaded,
              value.isSeeMore,
              value.changeCounter +
                  1, // Increment changeCounter to trigger UI update
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
              // Ensure response and data exist
              final updatedPosts = value.response.data?.data?.map((post) {
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

              // Create a new instance of GetAllDoctorPostsModelResponse with updated posts
              final updatedResponse = GetSavedPostsModelResponse(
                data: value.response.data?.copyWith(
                  data: updatedPosts,
                ),
              );

              return SavedPostsState.loaded(
                updatedResponse,
                '', // Snackbar message for success
                '', // No dialog message
                value.isDeletePostLoading,
                value.isDeletePostLoaded,
                value.isSeeMore,
                value.changeCounter +
                    1, // Increment changeCounter to trigger UI update
              );
            },
          ),
        );
      },
    );
  }
}
