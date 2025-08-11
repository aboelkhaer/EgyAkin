import 'dart:developer';

import 'package:egy_akin/features/show_single_feed/domain/usecases/get_post_by_id_usecase.dart';

import '../../../../exports.dart';

class ShowSingleFeedCubit extends Cubit<ShowSingleFeedState> {
  ShowSingleFeedCubit(
      this._getCommentsInCommunityUsecase,
      this._addLikeOrUnlikeOnCommentInCommunityUsecase,
      this._createCommentOnPostInCommunityUsecase,
      this._deleteCommentOnPostInCommunityUsecase,
      this._createReplyOnCommentInCommunityUsecase,
      this._addVoteAndUnvoteUsecase,
      this._addOptionOnPollUsecase,
      this._getPostByIdUsecase)
      : super(const ShowSingleFeedState.initial());
  static ShowSingleFeedCubit get(context) => BlocProvider.of(context);

  final GetCommentsInCommunityUsecase _getCommentsInCommunityUsecase;
  final AddLikeOrUnlikeOnCommentInCommunityUsecase
      _addLikeOrUnlikeOnCommentInCommunityUsecase;
  final CreateCommentOnPostInCommunityUsecase
      _createCommentOnPostInCommunityUsecase;
  final DeleteCommentOnPostInCommunityUsecase
      _deleteCommentOnPostInCommunityUsecase;
  final CreateReplyOnCommentInCommunityUsecase
      _createReplyOnCommentInCommunityUsecase;
  // ScrollController scrollController = ScrollController();
  final AddVoteAndUnvoteUsecase _addVoteAndUnvoteUsecase;
  final AddOptionOnPollUsecase _addOptionOnPollUsecase;
  final GetPostByIdUsecase _getPostByIdUsecase;

  final Map<int, Set<int>> postSelectedOptions = {};
  final Map<int, int?> postSelectedOption = {};

  CommentModelInCommunity? commentToReply;
  bool isLoadingMoreForScroll = false;
  bool isLastPage = false;
  int _currentPage = 1;

  TextEditingController commentContent = TextEditingController();
  int changeCounter = 0;
  final GlobalKey<AnimatedListState> listKeyForComments =
      GlobalKey<AnimatedListState>();

  Future<PostCommunityModel> getPostByIdWhenComeFromNotification(
      String postId) async {
    emit(const ShowSingleFeedState.loading());

    final result = await _getPostByIdUsecase.execute(postId);
    return result.fold(
      (l) {
        // Handle error case
        emit(ShowSingleFeedState.error(l.message));
        return const PostCommunityModel(); // Return default/empty model
      },
      (r) {
        // Handle success case
        emit(ShowSingleFeedState.loaded(
          // You'll need to provide all required parameters for the loaded state
          // This is just a placeholder - adjust according to your actual state
          const GetCommentsInCommunityModelResponse(),
          0,
          r.data!,
          false,
          false,
          '',
          null,
          false,
          false,
          false,
          false,
          false,
        ));
        return r.data!;
      },
    );
  }

  getCommentsInCommunity(
      String postId, PostCommunityModel feed, bool isComeFromNotification,
      {String? highlightedCommentId}) async {
    commentToReply = null;
    _currentPage = 1;
    // Emit loading state only if no silent refresh
    if (highlightedCommentId == null) {
      // if(isComeFromNotification ==true)
      if (!isComeFromNotification) {
        emit(const ShowSingleFeedState.loading());
      }

      final result = await _getCommentsInCommunityUsecase.execute(
        GetCommentsInCommunityUsecaseInput(
          postId: postId,
          page: _currentPage,
        ),
      );
      result.fold(
        (l) {
          emit(ShowSingleFeedState.error(l.message));
        },
        (r) async {
          if (highlightedCommentId == null) {
            emit(
              ShowSingleFeedState.loaded(
                r,
                changeCounter,
                feed,
                false,
                false,
                '',
                null,
                false,
                false,
                false,
                false,
                false,
              ),
            );
          }
        },
      );
    }
    // Remove highlight after 100 milliseconds
    if (highlightedCommentId != null) {
      await Future.delayed(const Duration(seconds: 1));
      emit(
        state.maybeMap(
          orElse: () => state,
          loaded: (value) => ShowSingleFeedState.loaded(
            value.commentsResponse,
            changeCounter,
            feed,
            false,
            true,
            '',
            null,
            false,
            false,
            false,
            false,
            false,
          ),
        ),
      );
    }
  }

  loadMoreComments(String postId) async {
    // Don't load more if we're already at the last page or currently loading
    if (isLoadingMoreForScroll || isLastPage) return;

    _currentPage++;
    isLoadingMoreForScroll = true;

    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) => ShowSingleFeedState.loaded(
        value.commentsResponse,
        value.changeCounter,
        value.feed,
        value.isSendCommentLoading,
        value.isSendCommentLoaded,
        '',
        value.highlightedCommentId,
        value.isDeleteCommentLoading,
        value.isDeleteCommentLoaded,
        value.isSendReplyLoading,
        value.isSendReplyLoaded,
        true, // isSeeMore = true while loading
      ),
    ));

    final result = await _getCommentsInCommunityUsecase.execute(
      GetCommentsInCommunityUsecaseInput(
        postId: postId,
        page: _currentPage,
      ),
    );

    result.fold(
      (failure) {
        _currentPage--;
        isLoadingMoreForScroll = false;
        emit(state.maybeMap(
          orElse: () => ShowSingleFeedState.error(failure.message),
          loaded: (value) => ShowSingleFeedState.loaded(
            value.commentsResponse,
            value.changeCounter,
            value.feed,
            value.isSendCommentLoading,
            value.isSendCommentLoaded,
            failure.message,
            value.highlightedCommentId,
            value.isDeleteCommentLoading,
            value.isDeleteCommentLoaded,
            value.isSendReplyLoading,
            value.isSendReplyLoaded,
            false,
          ),
        ));
      },
      (loadMoreComments) {
        isLoadingMoreForScroll = false;

        // Update the state with the new comments
        emit(state.maybeMap(
          orElse: () => state,
          loaded: (value) {
            // Check if we've reached the last page
            isLastPage = loadMoreComments.data?.lastPage == null ||
                _currentPage >= loadMoreComments.data!.lastPage!;

            // Merge the existing comments with the new ones
            final updatedComments = value.commentsResponse.copyWith(
              data: value.commentsResponse.data?.copyWith(
                data: [
                  ...(value.commentsResponse.data?.data ?? []),
                  ...(loadMoreComments.data?.data ?? []),
                ],
                currentPage: _currentPage,
                lastPage: loadMoreComments.data?.lastPage,
                nextPageUrl: loadMoreComments.data?.nextPageUrl,
              ),
            );

            return ShowSingleFeedState.loaded(
              updatedComments,
              value.changeCounter + 1, // Increment to trigger UI updates
              value.feed,
              value.isSendCommentLoading,
              value.isSendCommentLoaded,
              '',
              value.highlightedCommentId,
              value.isDeleteCommentLoading,
              value.isDeleteCommentLoaded,
              value.isSendReplyLoading,
              value.isSendReplyLoaded,
              false, // isSeeMore = false after loading
            );
          },
        ));
      },
    );
  }

  refreshScreen() {
    changeCounter++;
    emit(
      state.maybeMap(
        orElse: () => state,
        loaded: (value) => ShowSingleFeedState.loaded(
          value.commentsResponse,
          changeCounter,
          value.feed,
          value.isSendCommentLoading,
          value.isSendCommentLoaded,
          '',
          null,
          value.isDeleteCommentLoading,
          value.isDeleteCommentLoaded,
          value.isSendReplyLoading,
          value.isSendReplyLoaded,
          value.isSeeMore,
        ),
      ),
    );
  }

  bool _isLikingOrUnlikingPost = false; // Add this private flag
  String showPostFrom = '';
  void addOrRemoveLike() {
    // Prevent multiple simultaneous actions
    if (_isLikingOrUnlikingPost) return;

    _isLikingOrUnlikingPost = true; // Set the flag to true

    emit(
      state.maybeMap(
        orElse: () => state,
        loaded: (value) {
          // Get the current feed
          final currentFeed = value.feed;

          // Toggle the like status
          final isCurrentlyLiked = currentFeed.isLiked ?? false;

          final updatedLikesCount = isCurrentlyLiked
              ? (currentFeed.likesCount ?? 0) - 1 // Decrease likes count
              : (currentFeed.likesCount ?? 0) + 1; // Increase likes count

          if (showPostFrom == ShowPostFromEnum.feedsTab.name) {
            // Call the like/unlike API
            sl<CommunityCubit>().addLikeOrUnlikeOnPost(
              currentFeed.id.toString(),
              likeOrUnlike: currentFeed.isLiked! ? 'unlike' : 'like',
            );

            // Update the post state with the new like status and likes count
            sl<CommunityCubit>().updatePost(
              currentFeed.copyWith(
                isLiked: !isCurrentlyLiked,
                likesCount: updatedLikesCount,
              ),
            );
          }
          if (showPostFrom == ShowPostFromEnum.groupsTab.name) {
            sl<GroupsCubit>().addLikeOrUnlikeOnPost(currentFeed.id.toString(),
                likeOrUnlike: currentFeed.isLiked! ? 'unlike' : 'like');
          }
          if (showPostFrom == ShowPostFromEnum.groupDetails.name) {
            sl<GroupDetailsInCommunityCubit>().addLikeOrUnlikeOnPost(
                currentFeed.id.toString(),
                likeOrUnlike: currentFeed.isLiked! ? 'unlike' : 'like');
          }
          if (showPostFrom == ShowPostFromEnum.searchTab.name) {
            sl<CommunitySearchCubit>().addLikeOrUnlikeOnPost(
                currentFeed.id.toString(),
                likeOrUnlike: currentFeed.isLiked! ? 'unlike' : 'like');
          }
          if (showPostFrom == ShowPostFromEnum.allDoctorPosts.name) {
            sl<AllDoctorPostsCubit>().addLikeOrUnlikeOnPost(
                currentFeed.id.toString(),
                likeOrUnlike: currentFeed.isLiked! ? 'unlike' : 'like');
          }
          if (showPostFrom == ShowPostFromEnum.savedPosts.name) {
            sl<SavedPostsCubit>().addLikeOrUnlikeOnPost(
                currentFeed.id.toString(),
                likeOrUnlike: currentFeed.isLiked! ? 'unlike' : 'like');
          }
          if (showPostFrom == ShowPostFromEnum.notification.name) {
            sl<CommunityCubit>().addLikeOrUnlikeOnPost(
                currentFeed.id.toString(),
                likeOrUnlike: currentFeed.isLiked! ? 'unlike' : 'like');
          }

          // Emit the new state with updated data
          return ShowSingleFeedState.loaded(
            value.commentsResponse,
            value.changeCounter,
            currentFeed.copyWith(
              isLiked: !isCurrentlyLiked, // Toggle the isLiked flag
              likesCount: updatedLikesCount, // Update likes count
            ),
            value.isSendCommentLoading,
            value.isSendCommentLoaded,
            '',
            null,
            value.isDeleteCommentLoading,
            value.isDeleteCommentLoaded,
            value.isSendReplyLoading,
            value.isSendReplyLoaded,
            value.isSeeMore,
          );
        },
      ),
    );
    _isLikingOrUnlikingPost = false;
  }

  bool _isSavingOrUnsavingPost = false; // Add this as a private flag

  void addOrRemoveSave() {
    // Prevent multiple simultaneous actions
    if (_isSavingOrUnsavingPost) return;

    _isSavingOrUnsavingPost = true; // Set the flag to true

    emit(
      state.maybeMap(
        orElse: () => state,
        loaded: (value) {
          // Get the current feed
          final currentFeed = value.feed;

          // Toggle the save status
          final isCurrentlySaved = currentFeed.isSaved ?? false;

          //! feedsTab
          if (showPostFrom == ShowPostFromEnum.feedsTab.name) {
            // Call the save or unsave API
            sl<CommunityCubit>().addSaveOrUnsaveOnPost(
              currentFeed.id.toString(),
              saveOrUnsave: currentFeed.isSaved! ? 'unsave' : 'save',
            );

            // Update the post state with the new save status
            sl<CommunityCubit>().updatePost(
              currentFeed.copyWith(
                isSaved: !isCurrentlySaved,
              ),
            );
          }
          //! groupsTab
          if (showPostFrom == ShowPostFromEnum.groupsTab.name) {
            sl<GroupsCubit>().addSaveOrUnsaveOnPost(
              currentFeed.id.toString(),
              saveOrUnsave: currentFeed.isSaved! ? 'unsave' : 'save',
            );
          }
          //! groupDetails
          if (showPostFrom == ShowPostFromEnum.groupDetails.name) {
            sl<GroupDetailsInCommunityCubit>().addSaveOrUnsaveOnPost(
              currentFeed.id.toString(),
              saveOrUnsave: currentFeed.isSaved! ? 'unsave' : 'save',
            );
          }
          //! searchTab
          if (showPostFrom == ShowPostFromEnum.searchTab.name) {
            sl<CommunitySearchCubit>().addSaveOrUnsaveOnPost(
              currentFeed.id.toString(),
              saveOrUnsave: currentFeed.isSaved! ? 'unsave' : 'save',
            );
          }
          //! allDoctorPosts
          if (showPostFrom == ShowPostFromEnum.allDoctorPosts.name) {
            sl<AllDoctorPostsCubit>().addSaveOrUnsaveOnPost(
              currentFeed.id.toString(),
              saveOrUnsave: currentFeed.isSaved! ? 'unsave' : 'save',
            );
          }
          //! savedPosts
          if (showPostFrom == ShowPostFromEnum.savedPosts.name) {
            sl<SavedPostsCubit>().addSaveOrUnsaveOnPost(
              currentFeed.id.toString(),
              saveOrUnsave: currentFeed.isSaved! ? 'unsave' : 'save',
            );
          }
          //! notification
          if (showPostFrom == ShowPostFromEnum.notification.name) {
            sl<SavedPostsCubit>().addSaveOrUnsaveOnPost(
              currentFeed.id.toString(),
              saveOrUnsave: currentFeed.isSaved! ? 'unsave' : 'save',
            );
          }

          // Emit the new state with updated data
          return ShowSingleFeedState.loaded(
            value.commentsResponse,
            value.changeCounter,
            currentFeed.copyWith(
              isSaved: !isCurrentlySaved, // Toggle the isSaved flag
            ),
            value.isSendCommentLoading,
            value.isSendCommentLoaded,
            '',
            null,
            value.isDeleteCommentLoading,
            value.isDeleteCommentLoaded,
            value.isSendReplyLoading,
            value.isSendReplyLoaded,
            value.isSeeMore,
          );
        },
      ),
    );

    // Reset the flag after the operation is complete (assuming the API call is async)
    Future.delayed(
      const Duration(milliseconds: 500),
      () {
        _isSavingOrUnsavingPost = false;
      },
    );
  }

  bool _isUpdatingLikeStatus = false; // Add this as a private flag

  addLikeOrUnlikeOnCommentInCommunity({
    required String commentId,
  }) async {
    // Prevent multiple simultaneous actions
    if (_isUpdatingLikeStatus) return;

    _isUpdatingLikeStatus = true; // Set the flag to true
    bool isCurrentlyLiked = false;

    emit(
      state.maybeMap(
        orElse: () => state,
        loaded: (value) {
          final commentsResponse = value.commentsResponse;
          if (commentsResponse.data == null) {
            return value;
          }

          final updatedData = commentsResponse.copyWith(
            data: commentsResponse.data!.copyWith(
              data: commentsResponse.data!.data!.map((comment) {
                if (comment.id.toString() == commentId) {
                  isCurrentlyLiked = comment.isLiked ?? false;
                  final updatedLikesCount = isCurrentlyLiked
                      ? comment.likesCount! - 1
                      : comment.likesCount! + 1;

                  return comment.copyWith(
                    isLiked: !isCurrentlyLiked,
                    likesCount: updatedLikesCount,
                  );
                }
                return comment;
              }).toList(),
            ),
          );

          return value.copyWith(
            commentsResponse: updatedData,
            isSendCommentLoaded: false,
            isSendCommentLoading: false,
            isDeleteCommentLoaded: false,
            isDeleteCommentLoading: false,
            highlightedCommentId: null,
          );
        },
      ),
    );

    final status = isCurrentlyLiked ? 'unlike' : 'like';

    final result = await _addLikeOrUnlikeOnCommentInCommunityUsecase.execute(
      AddLikeOrUnlikeOnCommentInCommunityUsecaseInput(
        commentId: commentId,
        status: status,
      ),
    );

    result.fold(
      (failure) {
        // Rollback UI changes on failure
        emit(
          state.maybeMap(
            orElse: () => state,
            loaded: (value) {
              final commentsResponse = value.commentsResponse;
              if (commentsResponse.data == null) {
                return value;
              }

              final revertedData = commentsResponse.copyWith(
                data: commentsResponse.data!.copyWith(
                  data: commentsResponse.data!.data!.map((comment) {
                    if (comment.id.toString() == commentId) {
                      final revertedLikesCount = !isCurrentlyLiked
                          ? comment.likesCount! - 1
                          : comment.likesCount! + 1;

                      return comment.copyWith(
                        isLiked: isCurrentlyLiked,
                        likesCount: revertedLikesCount,
                      );
                    }
                    return comment;
                  }).toList(),
                ),
              );

              return value.copyWith(commentsResponse: revertedData);
            },
          ),
        );
      },
      (success) {
        // Optionally handle success
      },
    );

    _isUpdatingLikeStatus = false; // Reset the flag
  }

  addLikeOrUnlikeOnReplyInCommunity({
    required String commentId, // The unique ID (can be a comment or reply)
  }) async {
    if (_isUpdatingLikeStatus) return;

    debugPrint(
        'Starting addLikeOrUnlikeOnReplyInCommunity with commentId: $commentId');

    _isUpdatingLikeStatus = true;
    bool? isCurrentlyLiked;
    bool found = false; // Flag to track if the comment or reply was found

    // Optimistically update the UI
    emit(
      state.maybeMap(
        orElse: () {
          debugPrint('State is not loaded. Current state: $state');
          return state;
        },
        loaded: (value) {
          final commentsResponse = value.commentsResponse;
          if (commentsResponse.data == null) {
            debugPrint('No comments data available.');
            return value;
          }

          // Iterate through comments and their replies to find the matching ID
          final updatedData = commentsResponse.copyWith(
            data: commentsResponse.data!.copyWith(
              data: commentsResponse.data!.data!.map((comment) {
                if (comment.id.toString() == commentId) {
                  // Found a matching parent comment
                  debugPrint(
                      'Found matching parent comment. Updating likes...');
                  isCurrentlyLiked = comment.isLiked;
                  final updatedLikesCount = isCurrentlyLiked == true
                      ? comment.likesCount! - 1
                      : comment.likesCount! + 1;

                  found = true; // Mark as found
                  return comment.copyWith(
                    isLiked: !(isCurrentlyLiked ?? false),
                    likesCount: updatedLikesCount,
                  );
                }

                // Search within replies of the current comment
                final updatedReplies = comment.replies?.map((reply) {
                  if (reply.id.toString() == commentId) {
                    debugPrint('Found matching reply. Updating likes...');
                    isCurrentlyLiked = reply.isLiked;
                    final updatedLikesCount = isCurrentlyLiked == true
                        ? reply.likesCount! - 1
                        : reply.likesCount! + 1;

                    found = true; // Mark as found
                    return reply.copyWith(
                      isLiked: !(isCurrentlyLiked ?? false),
                      likesCount: updatedLikesCount,
                    );
                  }
                  return reply;
                }).toList();

                return comment.copyWith(replies: updatedReplies);
              }).toList(),
            ),
          );

          if (!found) {
            debugPrint(
                'Error: No matching comment or reply found with ID: $commentId');
          }

          debugPrint('UI state updated optimistically.');
          return value.copyWith(commentsResponse: updatedData);
        },
      ),
    );

    if (isCurrentlyLiked == null) {
      debugPrint('Error: isCurrentlyLiked is null. Skipping API call.');
      _isUpdatingLikeStatus = false;
      return;
    }

    final status = isCurrentlyLiked! ? 'unlike' : 'like';
    debugPrint('Calling API with status: $status');

    // Make the API call
    final result = await _addLikeOrUnlikeOnCommentInCommunityUsecase.execute(
      AddLikeOrUnlikeOnCommentInCommunityUsecaseInput(
        commentId: commentId, // Send the unique ID
        status: status,
      ),
    );

    result.fold(
      (failure) {
        debugPrint('API call failed: $failure');
        // Rollback UI changes on failure
      },
      (success) {
        debugPrint('API call succeeded.');
      },
    );

    _isUpdatingLikeStatus = false;
    debugPrint('Finished addLikeOrUnlikeOnReplyInCommunity.');
  }

  createCommentOnPostInCommunity(
    String postId,
    String comment,
    PostCommunityModel feed,
    List<CommentModelInCommunity> commentsList,
    DoctorModel currentDoctorModel,
  ) async {
    emit(
      state.maybeMap(
        orElse: () => state,
        loaded: (value) => ShowSingleFeedState.loaded(
          value.commentsResponse,
          changeCounter,
          value.feed,
          true, // Indicates loading
          false,
          '',
          value.highlightedCommentId,
          value.isDeleteCommentLoading,
          value.isDeleteCommentLoaded,
          value.isSendReplyLoading,
          value.isSendReplyLoaded,
          value.isSeeMore,
        ),
      ),
    );

    final result = await _createCommentOnPostInCommunityUsecase.execute(
      CreateCommentOnPostInCommunityUsecaseInput(
        postId: postId,
        comment: comment,
      ),
    );

    result.fold(
      // Handle error case
      (l) {
        emit(
          state.maybeMap(
            orElse: () => state,
            loaded: (value) => ShowSingleFeedState.loaded(
              value.commentsResponse,
              changeCounter,
              value.feed,
              false, // No loading
              false, // Not successful
              l.message,
              value.highlightedCommentId,
              value.isDeleteCommentLoading,
              value.isDeleteCommentLoaded,
              value.isSendReplyLoading,
              value.isSendReplyLoaded,
              value.isSeeMore,
            ),
          ),
        );
      },
      // Handle success case
      (r) async {
        commentContent.clear();

        final updatedFeed = feed.copyWith(
          commentsCount:
              (feed.commentsCount ?? 0) + 1, // Increment comments count
        );
        sl<CommunityCubit>().updatePost(updatedFeed);

        // Adding new comment logic
        final newComment = CommentModelInCommunity(
          id: r.data!.id,
          feedPostId: int.parse(postId),
          doctor: currentDoctorModel,
          comment: comment,
          createdAt: DateTime.now().toIso8601String(),
          updatedAt: DateTime.now().toIso8601String(),
          likesCount: 0,
          repliesCount: 0,
          isLiked: false,
          replies: [],
        );

// Add the new comment at the beginning of the list
        final mutableCommentsList =
            List<CommentModelInCommunity>.from(commentsList);
        mutableCommentsList.insert(0, newComment);

// Notify the AnimatedList about the new item
        listKeyForComments.currentState
            ?.insertItem(0, duration: const Duration(seconds: 1));

// Update the state to include the new comment

        emit(
          state.maybeMap(
            orElse: () => state,
            loaded: (value) => ShowSingleFeedState.loaded(
              value.commentsResponse.copyWith(
                data: value.commentsResponse.data?.copyWith(
                  data: mutableCommentsList, // Updated list with new comment
                ),
              ),
              changeCounter,
              updatedFeed, // Use the updated feed
              true,
              false,
              '',
              r.data!.id.toString(),
              value.isDeleteCommentLoading,
              value.isDeleteCommentLoaded,
              value.isSendReplyLoading,
              value.isSendReplyLoaded,
              value.isSeeMore,
            ),
          ),
        );
        await Future.delayed(const Duration(milliseconds: 100));
        emit(
          state.maybeMap(
            orElse: () => state,
            loaded: (value) => ShowSingleFeedState.loaded(
              value.commentsResponse.copyWith(
                data: value.commentsResponse.data?.copyWith(
                  data: mutableCommentsList, // Updated list with new comment
                ),
              ),
              changeCounter,
              updatedFeed, // Use the updated feed
              true,
              false,
              '',
              null,
              value.isDeleteCommentLoading,
              value.isDeleteCommentLoaded,
              value.isSendReplyLoading,
              value.isSendReplyLoaded,
              value.isSeeMore,
            ),
          ),
        );

        // Optionally refresh comments from the server
        await getCommentsInCommunity(
          postId,
          updatedFeed, // Pass updated feed
          false,
          highlightedCommentId: r.data!.id.toString(),
        );
      },
    );
  }

  // handleAfterCreateComment(){
  //   emit(state)
  // }

//! Delete comment
  String deleteCommentId = '';
  deleteCommentOnPostInCommunity(
    String commentId,
    PostCommunityModel feed,
    int index,
    HomeModelResponse homeDataModel,
    DoctorModel currentDoctorModel,
  ) async {
    deleteCommentId = commentId;
    final currentState = state.maybeMap(
      orElse: () => null,
      loaded: (value) => value,
    );

    if (currentState == null) return;

    final deletedComment = currentState.commentsResponse.data?.data?[index];
    if (deletedComment == null) return;

    final isReply = deletedComment.parentId != null;

    emit(ShowSingleFeedState.loaded(
      currentState.commentsResponse,
      changeCounter,
      currentState.feed,
      false,
      false,
      '',
      null,
      true,
      false,
      false,
      false,
      false,
    ));

    final result =
        await _deleteCommentOnPostInCommunityUsecase.execute(commentId);

    result.fold(
      (l) {
        emit(ShowSingleFeedState.loaded(
          currentState.commentsResponse,
          changeCounter,
          currentState.feed,
          false,
          false,
          l.message,
          null,
          false,
          false,
          false,
          false,
          false,
        ));
      },
      (r) async {
        final List<CommentModelInCommunity> updatedComments = [
          ...?currentState.commentsResponse.data?.data
        ];

        int totalDeleted = 1;

        // If main comment, delete replies too
        if (!isReply) {
          final repliesToDelete = updatedComments
              .where((c) => c.parentId == deletedComment.id)
              .toList();

          totalDeleted += repliesToDelete.length;

          updatedComments.removeWhere((c) =>
              c.id.toString() == commentId || c.parentId == deletedComment.id);
        } else {
          // If reply, update parent's repliesCount
          final parentIndex = updatedComments
              .indexWhere((c) => c.id == deletedComment.parentId);
          if (parentIndex != -1) {
            final parent = updatedComments[parentIndex];
            updatedComments[parentIndex] = parent.copyWith(
              repliesCount: (parent.repliesCount ?? 1) - 1,
            );
          }
          updatedComments.removeWhere((c) => c.id.toString() == commentId);
        }

        final updatedFeed = feed.copyWith(
          commentsCount: (feed.commentsCount ?? 0) - totalDeleted,
        );

        final updatedResponse = currentState.commentsResponse.copyWith(
          data: currentState.commentsResponse.data?.copyWith(
            data: updatedComments,
          ),
        );

        sl<CommunityCubit>().updatePost(updatedFeed);

        if (listKeyForComments.currentState != null) {
          listKeyForComments.currentState?.removeItem(
            index,
            (context, animation) => SizeTransition(
              sizeFactor: animation,
              child: CommentWidgetInCommunity(
                commentModel: deletedComment,
                homeDataModel: homeDataModel,
                currentDoctorModel: currentDoctorModel,
                commentsResponse: currentState.commentsResponse,
                index: index,
                updatedFeed: updatedFeed,
              ),
            ),
            duration: const Duration(milliseconds: 300),
          );
        }

        emit(ShowSingleFeedState.loaded(
          updatedResponse,
          changeCounter + 1,
          updatedFeed,
          false,
          false,
          '',
          null,
          false,
          true,
          false,
          false,
          false,
        ));
      },
    );

    deleteCommentId = '';
  }

  final Map<int, GlobalKey<AnimatedListState>> listKeyForReplies = {};

//! delete reply
  Future<void> deleteReplyOnComment(
    String replyId,
    CommentModelInCommunity commentModel,
    int replyIndex,
    PostCommunityModel feed,
    GetCommentsInCommunityModelResponse commentsResponse,
    HomeModelResponse homeDataModel,
    DoctorModel currentDoctorModel,
  ) async {
    deleteCommentId = replyId;

    final currentState = state.maybeMap(
      orElse: () => null,
      loaded: (value) => value,
    );

    if (currentState == null) return;

    emit(
      ShowSingleFeedState.loaded(
        currentState.commentsResponse,
        changeCounter,
        currentState.feed,
        false,
        false,
        '',
        null,
        true,
        false,
        false,
        false,
        false,
      ),
    );

    final result =
        await _deleteCommentOnPostInCommunityUsecase.execute(replyId);

    result.fold(
      (failure) {
        emit(
          ShowSingleFeedState.loaded(
            currentState.commentsResponse,
            changeCounter,
            currentState.feed,
            false,
            false,
            failure.message,
            null,
            false,
            false,
            false,
            false,
            false,
          ),
        );
      },
      (success) async {
        final updatedFeed = feed.copyWith(
          commentsCount: (feed.commentsCount ?? 0) - 1,
        );

        final updatedReplies = commentModel.replies
            ?.where((reply) => reply.id.toString() != replyId)
            .toList();
        final updatedComment = commentModel.copyWith(
          replies: updatedReplies,
          repliesCount: (commentModel.repliesCount ?? 0) - 1,
        );

        final updatedCommentsData = currentState.commentsResponse.data?.data
            ?.map((comment) =>
                comment.id == commentModel.id ? updatedComment : comment)
            .toList();
        final updatedCommentsResponse = currentState.commentsResponse.copyWith(
          data: currentState.commentsResponse.data?.copyWith(
            data: updatedCommentsData,
          ),
        );

        if (listKeyForReplies[commentModel.id]?.currentState != null) {
          listKeyForReplies[commentModel.id]?.currentState?.removeItem(
            replyIndex,
            (context, animation) {
              final replyToRemove = commentModel.replies![replyIndex];
              return SizeTransition(
                sizeFactor: animation,
                axisAlignment: 0.0,
                child: CommentWidgetInCommunity(
                  commentModel: replyToRemove,
                  homeDataModel: homeDataModel,
                  currentDoctorModel: currentDoctorModel,
                  commentsResponse: currentState.commentsResponse,
                  index: replyIndex,
                  updatedFeed: updatedFeed,
                ),
              );
            },
            duration: const Duration(milliseconds: 300),
          );

          await Future.delayed(const Duration(milliseconds: 300));
        }

        emit(
          ShowSingleFeedState.loaded(
            updatedCommentsResponse,
            changeCounter + 1,
            updatedFeed,
            false,
            false,
            '',
            null,
            false,
            true,
            false,
            false,
            false,
          ),
        );
      },
    );

    deleteCommentId = '';
    commentContent.clear();
  }

  //! create reply

  Future<void> createReplyOnComment(
    String postId,
    String commentId,
    CommentModelInCommunity parentComment,
    DoctorModel currentDoctorModel,
  ) async {
    // Start the loading state for sending a reply
    emit(
      state.maybeMap(
        orElse: () => state,
        loaded: (value) => ShowSingleFeedState.loaded(
          value.commentsResponse,
          changeCounter,
          value.feed,
          false,
          false,
          '',
          value.highlightedCommentId,
          value.isDeleteCommentLoading,
          value.isDeleteCommentLoaded,
          true, // Sending a reply
          false,
          value.isSeeMore,
        ),
      ),
    );

    // Execute the use case for creating a reply
    final result = await _createReplyOnCommentInCommunityUsecase.execute(
      CreateReplyOnCommentInCommunityUsecaseInput(
        postId: postId,
        comment: commentContent.text,
        parentId: int.parse(commentId),
      ),
    );

    // Handle the result
    result.fold(
      // Error case
      (failure) {
        emit(
          state.maybeMap(
            orElse: () => state,
            loaded: (value) => ShowSingleFeedState.loaded(
              value.commentsResponse,
              changeCounter,
              value.feed,
              false,
              false,
              failure.message,
              value.highlightedCommentId,
              value.isDeleteCommentLoading,
              value.isDeleteCommentLoaded,
              false,
              false,
              value.isSeeMore,
            ),
          ),
        );
      },
      // Success case
      (success) async {
        // Get current state
        final currentState = state.maybeMap(
          orElse: () => null,
          loaded: (value) => value,
        );

        if (currentState == null) return;

        // Update the feed's comments count
        final updatedFeed = currentState.feed.copyWith(
          commentsCount: (currentState.feed.commentsCount ?? 0) + 1,
        );

        // Create the new reply model
        final newReply = CommentModelInCommunity(
          id: success.data!.id,
          feedPostId: parentComment.feedPostId,
          parentId: parentComment.id,
          doctor: currentDoctorModel,
          comment: commentContent.text,
          createdAt: DateTime.now().toIso8601String(),
          updatedAt: DateTime.now().toIso8601String(),
          likesCount: 0,
          repliesCount: 0,
          isLiked: false,
          replies: [],
        );

        // Update the parent comment with new reply and incremented count
        final updatedParentComment = parentComment.copyWith(
          replies: [...(parentComment.replies ?? []), newReply],
          repliesCount: (parentComment.repliesCount ?? 0) + 1,
        );

        // Update the list of comments
        final updatedComments = (currentState.commentsResponse.data?.data ?? [])
            .map((comment) =>
                comment.id == parentComment.id ? updatedParentComment : comment)
            .toList();

        // Create updated comments response
        final updatedCommentsResponse = currentState.commentsResponse.copyWith(
          data: currentState.commentsResponse.data?.copyWith(
            data: updatedComments,
          ),
        );

        // Animate the new reply into the list
        if (listKeyForReplies[parentComment.id]?.currentState != null) {
          final replyIndex = updatedParentComment.replies?.length ?? 0;
          listKeyForReplies[parentComment.id]!.currentState!.insertItem(
                replyIndex - 1,
                duration: const Duration(milliseconds: 300),
              );
        }

        emit(
          ShowSingleFeedState.loaded(
            updatedCommentsResponse,
            changeCounter + 1,
            updatedFeed,
            false,
            false,
            '',
            success.data!.id.toString(), // Highlight the new reply
            currentState.isDeleteCommentLoading,
            currentState.isDeleteCommentLoaded,
            false,
            true, // Reply sent successfully
            currentState.isSeeMore,
          ),
        );

        await Future.delayed(const Duration(milliseconds: 100));

        // Remove highlight after delay
        emit(
          ShowSingleFeedState.loaded(
            updatedCommentsResponse,
            changeCounter + 2, // Increment again to trigger rebuild
            updatedFeed,
            false,
            false,
            '',
            null, // Remove highlight
            currentState.isDeleteCommentLoading,
            currentState.isDeleteCommentLoaded,
            false,
            true,
            currentState.isSeeMore,
          ),
        );

        commentToReply = null;
        commentContent.clear();
      },
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
          // Debug: Print current poll state
          print("Current Poll: ${value.feed.poll}");

          // Update the poll in the feed
          final updatedPoll = value.feed.poll != null &&
                  value.feed.poll!.id.toString() == pollId
              ? _updatePoll(value.feed.poll!, optionId)
              : value.feed.poll; // No change for other polls

          // Debug: Print updated poll state
          print("Updated Poll: $updatedPoll");

          final updatedFeed = value.feed.copyWith(poll: updatedPoll);

          // Debug: Print updated feed state
          print("Updated Feed: $updatedFeed");

          // Update the post state with the new poll
          // sl<CommunityCubit>().updatePost(updatedFeed);

          // Update the state with the new feed
          return ShowSingleFeedState.loaded(
            value.commentsResponse,
            value.changeCounter,
            updatedFeed,
            value.isSendCommentLoading,
            value.isSendCommentLoaded,
            '',
            null,
            value.isDeleteCommentLoading,
            value.isDeleteCommentLoaded,
            value.isSendReplyLoading,
            value.isSendReplyLoaded,
            value.isSeeMore,
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
        print("Vote update failed: $l");
      },
      (r) async {
        // Call the like/unlike API
        // sl<CommunityCubit>().addVoteAndUnVote(pollId, optionId);

        // Optionally re-fetch data from the server if needed
        print("Vote update succeeded");
      },
    );
  }

  /// Helper function to update the poll options
  PollModelResponse _updatePoll(PollModelResponse poll, int optionId) {
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

    // Debug: Print previously voted option ID
    print("Previously Voted Option ID: $previouslyVotedOptionId");

    // Update the poll options
    final updatedOptions = poll.options!.map((option) {
      if (option.id == optionId) {
        // Toggle the vote for the selected option
        return option.copyWith(
          votesCount:
              (option.votesCount ?? 0) + (option.isVoted == true ? -1 : 1),
          isVoted: !(option.isVoted ?? false),
        );
      } else if (!isMultipleChoice && option.id == previouslyVotedOptionId) {
        // Reduce the vote count for the previously voted option (single-choice polls)
        return option.copyWith(
          votesCount: (option.votesCount ?? 0) - 1,
          isVoted: false,
        );
      }
      return option; // No change for other options
    }).toList();

    // Debug: Print updated options
    print("Updated Options: $updatedOptions");

    // Update the poll with the new options
    return poll.copyWith(options: updatedOptions);
  }

  addOptionOnPoll(
    String pollId,
    String option,
  ) async {
    emit(
      state.maybeMap(
        orElse: () => state,
        loaded: (value) => ShowSingleFeedState.loaded(
          value.commentsResponse,
          value.changeCounter,
          value.feed,
          value.isSendCommentLoading,
          value.isSendCommentLoaded,
          '', // Show error message
          value.highlightedCommentId,
          value.isDeleteCommentLoading,
          value.isDeleteCommentLoaded,
          value.isSendReplyLoading,
          value.isSendReplyLoaded, value.isSeeMore,
        ),
      ),
    );
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
            loaded: (value) => ShowSingleFeedState.loaded(
              value.commentsResponse,
              value.changeCounter,
              value.feed,
              value.isSendCommentLoading,
              value.isSendCommentLoaded,
              l.message, // Show error message
              value.highlightedCommentId,
              value.isDeleteCommentLoading,
              value.isDeleteCommentLoaded,
              value.isSendReplyLoading,
              value.isSendReplyLoaded, value.isSeeMore,
            ),
          ),
        );
      },
      (newOptionResponse) async {
        // Ensure response data is not null
        if (newOptionResponse.data == null) return;

        PollOptionsModelResponse newOption = PollOptionsModelResponse(
          id: newOptionResponse.data!.id,
          pollId: int.parse(newOptionResponse.data!.pollId.toString()),
          optionText: newOptionResponse.data!.option.toString(),
          createdAt: newOptionResponse.data!.createdAt,
          updatedAt: newOptionResponse.data!.updatedAt,
          votesCount: 0, // Default votes count
          isVoted: false,
        );

        emit(
          state.maybeMap(
            orElse: () => state,
            loaded: (value) {
              // Ensure feed.poll is not null before modifying
              if (value.feed.poll == null) return value;

              // Update the poll options
              final updatedFeed = value.feed.copyWith(
                poll: value.feed.poll!.copyWith(
                  options: [
                    ...(value.feed.poll!.options ??
                        []), // Keep existing options
                    newOption, // Add new option
                  ],
                ),
              );

              return ShowSingleFeedState.loaded(
                value.commentsResponse,
                value.changeCounter + 1, // Increment to reflect UI changes
                updatedFeed, // Updated feed with new poll option
                value.isSendCommentLoading,
                value.isSendCommentLoaded,
                newOptionResponse.message.toString(), // Clear message
                value.highlightedCommentId,
                value.isDeleteCommentLoading,
                value.isDeleteCommentLoaded,
                value.isSendReplyLoading,
                value.isSendReplyLoaded, value.isSeeMore,
              );
            },
          ),
        );
      },
    );
  }
}
