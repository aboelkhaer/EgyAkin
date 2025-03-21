import 'dart:developer';

import 'package:egy_akin/features/community/domain/usecases/add_option_on_poll_usecase.dart';
import 'package:egy_akin/features/community/domain/usecases/add_vote_and_unvote_usecase.dart';
import 'package:egy_akin/features/community_search/data/models/get_response_of_search_model.dart';
import 'package:egy_akin/features/community_search/domain/usecases/get_response_of_search_in_community_usecase.dart';
import 'package:egy_akin/features/community_search/presentation/cubit/community_search_state.dart';

import '../../../../exports.dart';

class CommunitySearchCubit extends Cubit<CommunitySearchState> {
  CommunitySearchCubit(
      this._getResponseOfSearchInCommunityUsecase,
      this._addLikeOnPostUsecase,
      this._saveOrUnsavePostUsecase,
      this._addVoteAndUnvoteUsecase,
      this._addOptionOnPollUsecase)
      : super(const CommunitySearchState.initial());
  static CommunitySearchCubit get(context) => BlocProvider.of(context);
  final GetResponseOfSearchInCommunityUsecase
      _getResponseOfSearchInCommunityUsecase;
  final AddLikeOnPostUsecase _addLikeOnPostUsecase;
  final SaveOrUnsavePostUsecase _saveOrUnsavePostUsecase;
  final AddVoteAndUnvoteUsecase _addVoteAndUnvoteUsecase;
  final AddOptionOnPollUsecase _addOptionOnPollUsecase;
  bool isSearchContentEmpty = true;
  Timer? _debounce;
  String? initialValue;
  String? searchValue;
  final Map<int, Set<int>> postSelectedOptions = {};
  final Map<int, int?> postSelectedOption = {};

  bool isLoadingMoreForScroll = false;
  bool isLastPage = false;
  ScrollController? scrollController;
  int _currentPage = 1;
  int changeCounter = 0;

  void getResponseOfSearchInCommunity(String searchContent,
      [int? milliseconds]) {
    _debounce
        ?.cancel(); // Cancel the previous request if the user is still typing

    _debounce = Timer(Duration(milliseconds: milliseconds ?? 1000), () async {
      emit(const CommunitySearchState.loading());

      final result = await _getResponseOfSearchInCommunityUsecase.execute(
        GetResponseOfSearchInCommunityUsecaseInput(
          page: _currentPage,
          searchContent: searchContent,
        ),
      );

      result.fold((l) => emit(CommunitySearchState.error(l.message)),
          (response) {
        emit(CommunitySearchState.loaded(
          '',
          '',
          response,
          false,
          changeCounter,
        ));
        if (isSearchContentEmpty == true) {
          resetPostsList();
        }
      });
    });
  }

  void loadMorePosts(String searchContent) async {
    if (isLastPage) return;

    _currentPage++;
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) => CommunitySearchState.loaded(
        '',
        '',
        value.response,
        true, // Set isSeeMore to true to show a loading indicator
        changeCounter,
      ),
    ));

    final result = await _getResponseOfSearchInCommunityUsecase.execute(
      GetResponseOfSearchInCommunityUsecaseInput(
        page: _currentPage,
        searchContent: searchContent,
      ),
    );

    result.fold(
      (l) {
        _currentPage--; // Roll back the page increment if the API call fails
        emit(CommunitySearchState.error(l.message));
      },
      (loadMorePosts) {
        final currentState = state;
        currentState.when(
          initial: () {},
          loading: () {},
          loaded: (
            snackBarMessage,
            dialogMessage,
            response,
            isSeeMore,
            changeCounter,
          ) {
            // Check if the new data is empty
            if (loadMorePosts.data?.data?.isEmpty ?? true) {
              // No more posts to load, set isLastPage to true
              isLastPage = true;
              isLoadingMoreForScroll = false;

              // Emit the current state without updating the data
              emit(CommunitySearchState.loaded(
                '',
                '',
                response,
                false,
                changeCounter,
              ));
            } else {
              // Merge the new data with the existing data
              final updatedData = response.copyWith(
                data: response.data?.copyWith(
                  data: [
                    ...(response.data?.data ?? []),
                    ...(loadMorePosts.data?.data ?? []),
                  ],
                ),
              );

              // Check if this is the last page
              isLastPage = (response.data?.lastPage != null &&
                  _currentPage >= response.data!.lastPage!);
              isLoadingMoreForScroll = false;

              // Emit the updated state
              emit(CommunitySearchState.loaded(
                '',
                '',
                updatedData,
                false,
                changeCounter,
              ));
            }
          },
          error: (error) {},
        );
      },
    );
  }

  resetPostsList() {
    emit(
      state.maybeMap(
        orElse: () => state,
        loaded: (value) {
          final emptyResponse = value.response.copyWith(
            data: value.response.data?.copyWith(
                  data: [],
                ) ??
                const GetPostsCommunityDataModelResponse(data: []),
          );

          return CommunitySearchState.loaded(
            '',
            '',
            emptyResponse,
            false,
            changeCounter,
          );
        },
      ),
    );
  }

  bool _isUpdatingPostLikeStatus = false;

  Future<void> addLikeOrUnlikeOnPost(String postId) async {
    if (_isUpdatingPostLikeStatus) return;
    _isUpdatingPostLikeStatus = true;

    bool isCurrentlyLiked = false;

    /// **1️⃣ Optimistically Update UI**
    emit(
      state.maybeMap(
        loaded: (value) {
          final response = value.response;
          if (response.data == null || response.data!.data == null) {
            return value;
          }

          final postList = response.data!.data!;

          /// **Find Post & Toggle Like Status**
          final updatedPosts = postList.map((post) {
            if (post.id == int.tryParse(postId)) {
              isCurrentlyLiked = post.isLiked ?? false;
              final updatedLikesCount =
                  (post.likesCount ?? 0) + (isCurrentlyLiked ? -1 : 1);

              return post.copyWith(
                isLiked: !isCurrentlyLiked,
                likesCount: updatedLikesCount,
              );
            }
            return post;
          }).toList();

          /// **Update State with a New Instance**
          final updatedResponse = response.copyWith(
            data: response.data!.copyWith(data: [...updatedPosts]),
          );

          return CommunitySearchState.loaded(
            '',
            '',
            updatedResponse,
            false,
            changeCounter,
          );
        },
        orElse: () => state,
      ),
    );

    /// **2️⃣ Send API Request**
    final likeOrUnlike = isCurrentlyLiked ? 'unlike' : 'like';
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
          state.maybeMap(
            loaded: (value) {
              final response = value.response;
              if (response.data == null || response.data!.data == null) {
                return value;
              }

              final revertedPosts = response.data!.data!.map((post) {
                if (post.id == int.tryParse(postId)) {
                  final revertedLikesCount = !isCurrentlyLiked
                      ? (post.likesCount ?? 1) - 1
                      : (post.likesCount ?? 0) + 1;

                  return post.copyWith(
                    isLiked: isCurrentlyLiked,
                    likesCount: revertedLikesCount,
                  );
                }
                return post;
              }).toList();

              final revertedResponse = response.copyWith(
                data: response.data!.copyWith(data: [...revertedPosts]),
              );

              return CommunitySearchState.loaded(
                '',
                '',
                revertedResponse,
                false,
                changeCounter,
              );
            },
            orElse: () => state,
          ),
        );
      },
      (success) {},
    );

    _isUpdatingPostLikeStatus = false;
  }

  bool _isUpdatingPostSaveStatus =
      false; // Private flag to prevent multiple simultaneous actions

  Future<void> addSaveOrUnsaveOnPost(String postId) async {
    // Prevent multiple simultaneous actions
    if (_isUpdatingPostSaveStatus) return;
    _isUpdatingPostSaveStatus = true;

    bool isCurrentlySaved =
        false; // Store the current save status for rollback in case of failure

    /// **1️⃣ Optimistically Update UI**
    emit(
      state.maybeMap(
        loaded: (value) {
          final response = value.response;
          if (response.data == null || response.data!.data == null) {
            debugPrint("[Save] ❌ No data found in response");
            return value; // Return unchanged state if data is null
          }

          final postList = response.data!.data!;

          /// **Find Post & Toggle Save Status**
          final updatedPosts = postList.map((post) {
            if (post.id == int.tryParse(postId)) {
              isCurrentlySaved =
                  post.isSaved ?? false; // Default to false if null
              return post.copyWith(
                isSaved: !isCurrentlySaved, // Toggle isSaved
              );
            }
            return post; // Return unchanged post if ID doesn't match
          }).toList();

          /// **Update State with a New Instance**
          final updatedResponse = response.copyWith(
            data: response.data!.copyWith(data: [...updatedPosts]),
          );

          debugPrint("[Save] ✅ UI Updated Optimistically");
          return CommunitySearchState.loaded(
            '',
            '',
            updatedResponse,
            false,
            changeCounter,
          );
        },
        orElse: () =>
            state, // Return unchanged state if not in the loaded state
      ),
    );

    /// **2️⃣ Send API Request**
    final saveOrUnsave = isCurrentlySaved ? 'unsave' : 'save';
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
                  return post.copyWith(
                    isSaved: isCurrentlySaved, // Revert to original state
                  );
                }
                return post;
              }).toList();

              /// **Update State with Reverted Data**
              final revertedResponse = response.copyWith(
                data: response.data!.copyWith(data: [...revertedPosts]),
              );

              debugPrint("[Save] 🔄 Rollback UI Due to API Failure");
              return CommunitySearchState.loaded(
                '',
                '',
                revertedResponse,
                false,
                changeCounter,
              );
            },
            orElse: () => state,
          ),
        );
      },
      (success) {
        debugPrint("[Save] ✅ API Success: Save/Unsave applied");
      },
    );

    _isUpdatingPostSaveStatus = false; // Reset the flag
  }

  Future<void> deletePost(String postId) async {
    // Step 1: Delete the post using your Cubit or repository
    await sl<CommunityCubit>().deletePost(postId);

    // Step 2: Emit a new state with the updated list of posts
    emit(
      state.maybeMap(
        orElse: () =>
            state, // Return the current state if it's not the expected type
        loaded: (value) {
          // Step 3: Filter out the deleted post
          final updatedPosts = value.response.data?.data
              ?.where((post) => post.id.toString() != postId)
              .toList();

          // Step 4: Create a new state with the updated posts
          return CommunitySearchState.loaded(
            'Post deleted successfully', // snackBarMessage
            '', // dialogMessage (optional)
            value.response.copyWith(
              data: value.response.data?.copyWith(
                data: updatedPosts,
              ),
            ),
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
          return CommunitySearchState.loaded(
            '',
            '',
            updatedResponse,
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
      loaded: (value) => CommunitySearchState.loaded(
        '',
        '',
        value.response,
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
            loaded: (value) => CommunitySearchState.loaded(
              'Failed to add option', // Snackbar message for failure
              '', // No dialog message
              value.response,
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

              // Create a new instance of GetResponseOfSearchModel with updated posts
              final updatedResponse = GetResponseOfSearchModel(
                data: value.response.data?.copyWith(
                  data: updatedPosts,
                ),
              );

              return CommunitySearchState.loaded(
                '', // Snackbar message for success
                '', // No dialog message
                updatedResponse,
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
