import 'dart:developer';

import 'package:egy_akin/features/community/presentation/cubit/community_state.dart';

import '../../../../exports.dart';

class CommunityCubit extends Cubit<CommunityState> {
  CommunityCubit(
    this._getAllFeedsUsecase,
    this._addLikeOnPostUsecase,
    this._saveOrUnsavePostUsecase,
    this._deletePostInFeedsUsecase,
  ) : super(const CommunityState.initial());
  static CommunityCubit get(context) => BlocProvider.of(context);
  final GetAllFeedsUsecase _getAllFeedsUsecase;
  final AddLikeOnPostUsecase _addLikeOnPostUsecase;
  final SaveOrUnsavePostUsecase _saveOrUnsavePostUsecase;
  final DeletePostInFeedsUsecase _deletePostInFeedsUsecase;

  ScrollController? feedsScrollController;

  bool isLoadingMoreForScroll = false;
  bool isLastPage = false;
  int _currentPage = 0;
  void disposeScrollController() {
    feedsScrollController?.dispose();
    feedsScrollController = null;
  }

  getAllFeeds() async {
    _currentPage = 0;
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
        ));
      },
    );
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
}
