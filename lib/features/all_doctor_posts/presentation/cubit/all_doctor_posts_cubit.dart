import 'dart:developer';

import '../../../../exports.dart';

class AllDoctorPostsCubit extends Cubit<AllDoctorPostsState> {
  AllDoctorPostsCubit(
      this._getAllDoctorPostsUsecase,
      this._addLikeOnPostUsecase,
      this._saveOrUnsavePostUsecase,
      this._deletePostInFeedsUsecase,
      this._addVoteAndUnvoteUsecase,
      this._addOptionOnPollUsecase)
      : super(const AllDoctorPostsState.initial());
  static AllDoctorPostsCubit get(context) => BlocProvider.of(context);
  final GetAllDoctorPostsUsecase _getAllDoctorPostsUsecase;
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

  getAllDoctorPosts(String doctorId) async {
    emit(const AllDoctorPostsState.loading());
    currentPage = 1;
    final result = await _getAllDoctorPostsUsecase.execute(
        GetAllDoctorPostsUsecaseInput(doctorId: doctorId, page: currentPage));
    result.fold(
      (l) {
        emit(AllDoctorPostsState.error(l.message));
      },
      (response) async {
        emit(AllDoctorPostsState.loaded(
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
      loaded: (value) => AllDoctorPostsState.loaded(
        value.response,
        '',
        '',
        false,
        false,
        true,
        changeCounter,
      ),
    ));
    final result = await _getAllDoctorPostsUsecase.execute(
        GetAllDoctorPostsUsecaseInput(doctorId: doctorId, page: currentPage));
    result.fold(
      (l) {
        currentPage--;
        emit(AllDoctorPostsState.error(l.message));
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
            emit(AllDoctorPostsState.loaded(
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

    // Store the original state for potential rollback
    final originalState = state;
    bool isCurrentlyLiked = false;
    int? originalLikesCount;

    /// **1️⃣ Optimistically Update UI**
    emit(
      state.maybeMap(
        loaded: (value) {
          final response = value.response;
          if (response.data == null || response.data!.data == null) {
            return value;
          }

          final postList = response.data!.data!;

          /// **Find Post & Update Like Status**
          final updatedPosts = postList.map((post) {
            if (post.id == int.tryParse(postId)) {
              isCurrentlyLiked = post.isLiked ?? false;
              originalLikesCount = post.likesCount ?? 0;

              // Determine new state based on explicit action
              final newLikeStatus = likeOrUnlike == 'like';
              final likesCountChange = newLikeStatus
                  ? (isCurrentlyLiked ? 0 : 1) // Like action
                  : (isCurrentlyLiked ? -1 : 0); // Unlike action

              return post.copyWith(
                isLiked: newLikeStatus,
                likesCount: originalLikesCount! + likesCountChange,
              );
            }
            return post;
          }).toList();

          /// **Update State with a New Instance**
          final updatedResponse = response.copyWith(
            data: response.data!.copyWith(data: updatedPosts),
          );

          return AllDoctorPostsState.loaded(
            updatedResponse,
            '',
            '',
            false,
            false,
            false,
            changeCounter + 1, // Increment changeCounter
          );
        },
        orElse: () => state,
      ),
    );

    /// **2️⃣ Send API Request**
    final result = await _addLikeOnPostUsecase.execute(
      AddLikeOnPostUsecaseInput(
        postId: postId,
        likeOrUnlike: likeOrUnlike,
      ),
    );

    result.fold(
      (failure) {
        /// **3️⃣ Rollback UI on Failure**
        emit(
          originalState.maybeMap(
            loaded: (value) => AllDoctorPostsState.loaded(
              value.response,
              '',
              '',
              false,
              false,
              false,
              changeCounter + 1, // Also increment on rollback
            ),
            orElse: () => originalState,
          ),
        );
      },
      (success) {
        // On success, no need to do anything as we already optimistically updated
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
    // Prevent multiple simultaneous actions
    if (_isUpdatingPostSaveStatus) return;
    _isUpdatingPostSaveStatus = true;

    bool isCurrentlySaved = false; // Store current save status for rollback

    /// **1️⃣ Optimistically Update UI**
    emit(
      state.maybeMap(
        loaded: (value) {
          final response = value.response;
          if (response.data == null || response.data!.data == null) {
            debugPrint("[Save] ❌ No data found in response");
            return value;
          }

          final postList = response.data!.data!;

          /// **Find Post & Update Save Status**
          final updatedPosts = postList.map((post) {
            if (post.id == int.tryParse(postId)) {
              isCurrentlySaved = post.isSaved ?? false;

              // Determine new state based on explicit action
              final newSavedStatus = saveOrUnsave == 'save';
              debugPrint(
                  "[Save] 🔄 Changing save status from $isCurrentlySaved to $newSavedStatus");

              return post.copyWith(
                isSaved: newSavedStatus,
              );
            }
            return post;
          }).toList();

          /// **Update State with a New Instance**
          final updatedResponse = response.copyWith(
            data: response.data!.copyWith(data: [...updatedPosts]),
          );

          debugPrint("[Save] ✅ UI Updated Optimistically");
          return AllDoctorPostsState.loaded(
            updatedResponse,
            '',
            '',
            false,
            false,
            false,
            changeCounter,
          );
        },
        orElse: () => state,
      ),
    );

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

        /// **3️⃣ Rollback UI on Failure**
        emit(
          state.maybeMap(
            loaded: (value) {
              final response = value.response;
              if (response.data == null || response.data!.data == null) {
                return value;
              }

              final postList = response.data!.data!;

              /// **Revert Save Status**
              final revertedPosts = postList.map((post) {
                if (post.id == int.tryParse(postId)) {
                  debugPrint(
                      "[Save] ↩️ Reverting to original save status: $isCurrentlySaved");
                  return post.copyWith(
                    isSaved: isCurrentlySaved,
                  );
                }
                return post;
              }).toList();

              /// **Update State with Reverted Data**
              final revertedResponse = response.copyWith(
                data: response.data!.copyWith(data: [...revertedPosts]),
              );

              debugPrint("[Save] 🔄 Rollback UI Due to API Failure");
              return AllDoctorPostsState.loaded(
                revertedResponse,
                '',
                '',
                false,
                false,
                false,
                changeCounter,
              );
            },
            orElse: () => state,
          ),
        );
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
        loaded: (value) => AllDoctorPostsState.loaded(
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
            loaded: (value) => AllDoctorPostsState.loaded(
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

        emit(
          state.maybeMap(
            orElse: () => state,
            loaded: (value) => AllDoctorPostsState.loaded(
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
          return AllDoctorPostsState.loaded(
            updatedResponse,
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
      loaded: (value) => AllDoctorPostsState.loaded(
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
            loaded: (value) => AllDoctorPostsState.loaded(
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
              final updatedResponse = GetAllDoctorPostsModelResponse(
                data: value.response.data?.copyWith(
                  data: updatedPosts,
                ),
              );

              return AllDoctorPostsState.loaded(
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
