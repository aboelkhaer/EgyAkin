import 'package:egy_akin/features/show_single_feed/domain/usecases/create_reply_on_comment_in_community_usecase.dart';
import 'package:egy_akin/features/show_single_feed/presentation/widgets/reply_widget_in_community.dart';

import '../../../../exports.dart';

class ShowSingleFeedCubit extends Cubit<ShowSingleFeedState> {
  ShowSingleFeedCubit(
      this._getCommentsInCommunityUsecase,
      this._addLikeOrUnlikeOnCommentInCommunityUsecase,
      this._createCommentOnPostInCommunityUsecase,
      this._deleteCommentOnPostInCommunityUsecase,
      this._createReplyOnCommentInCommunityUsecase)
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
  ScrollController scrollController = ScrollController();

  CommentModelInCommunity? commentToReply;
  // String commentContent = '';

  TextEditingController commentContent = TextEditingController();
  int changeCounter = 0;
  final GlobalKey<AnimatedListState> listKeyForComments =
      GlobalKey<AnimatedListState>();

  getCommentsInCommunity(String postId, PostCommunityModel feed,
      {String? highlightedCommentId}) async {
    commentToReply = null;
    // Emit loading state only if no silent refresh
    if (highlightedCommentId == null) {
      emit(const ShowSingleFeedState.loading());

      final result = await _getCommentsInCommunityUsecase.execute(postId);
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
                false, // No general loading
                false, // Successfully loaded comments
                '', // No message
                null, // Highlighted comment ID
                false, false, false, false,
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
            null, // Clear highlight
            false, false, false, false,
          ),
        ),
      );
      // emit(ShowSingleFeedState.loaded(
      //   r,
      //   changeCounter,
      //   feed,
      //   false,
      //   true,
      //   '',
      //   null, // Clear highlight
      //   false, false,
      // ));
    }
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
          false,
          false,
        ),
      ),
    );
  }

  bool _isLikingOrUnlikingPost = false; // Add this private flag

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

          // Call the like/unlike API
          sl<CommunityCubit>().addLikeOrUnlikeOnPost(currentFeed.id.toString());

          // Update the post state with the new like status and likes count
          sl<CommunityCubit>().updatePost(
            currentFeed.copyWith(
              isLiked: !isCurrentlyLiked,
              likesCount: updatedLikesCount,
            ),
          );

          // Emit the new state with updated data
          return ShowSingleFeedState.loaded(
            value.commentsResponse,
            value.changeCounter,
            currentFeed.copyWith(
              isLiked: !isCurrentlyLiked, // Toggle the isLiked flag
              likesCount: updatedLikesCount, // Update likes count
            ),
            false,
            false,
            '',
            null,
            false,
            false,
            false,
            false,
          );
        },
      ),
    );

    // Reset the flag after the operation is complete (assuming the API call is async)
    Future.delayed(
      const Duration(milliseconds: 500),
      () {
        _isLikingOrUnlikingPost = false;
      },
    );
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

          // Call the save or unsave API
          sl<CommunityCubit>().addSaveOrUnsaveOnPost(currentFeed.id.toString());

          // Update the post state with the new save status
          sl<CommunityCubit>().updatePost(
            currentFeed.copyWith(
              isSaved: !isCurrentlySaved,
            ),
          );

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
            false,
            false,
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
          value.isDeleteCommentLoaded, false, false,
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
              value.isDeleteCommentLoaded, false, false,
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
              value.isDeleteCommentLoaded, false, false,
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
              value.isDeleteCommentLoaded, false, false,
            ),
          ),
        );

        // Optionally refresh comments from the server
        await getCommentsInCommunity(
          postId,
          updatedFeed, // Pass updated feed
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
    int index, // Pass the index to delete and animate the comment smoothly
    HomeModelResponse homeDataModel,
    DoctorModel currentDoctorModel,
  ) async {
    deleteCommentId = commentId;
    // Access the current state
    final currentState = state.maybeMap(
      orElse: () => null,
      loaded: (value) => value, // Capture the current loaded state
    );

    if (currentState == null) return; // Exit if the current state is not loaded

    // Emit a loading state with deletion in progress
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
      ),
    );

    final result =
        await _deleteCommentOnPostInCommunityUsecase.execute(commentId);

    result.fold(
      // Handle error case
      (l) {
        emit(
          ShowSingleFeedState.loaded(
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
          ),
        );
      },
      // Handle success case
      (r) async {
        final updatedFeed = feed.copyWith(
          commentsCount:
              (feed.commentsCount ?? 0) - 1, // Decrement comments count
        );

        // Safely filter the comments list
        final updatedCommentsData = currentState.commentsResponse.data?.data
            ?.where((comment) => comment.id.toString() != commentId)
            .toList();

        // Construct the updated comments response
        final updatedCommentsResponse = currentState.commentsResponse.copyWith(
          data: currentState.commentsResponse.data?.copyWith(
            data: updatedCommentsData,
          ),
        );

        // Update the CommunityCubit with the new post
        sl<CommunityCubit>().updatePost(updatedFeed);

        // Trigger the smooth deletion animation in the UI
        if (listKeyForComments.currentState != null) {
          listKeyForComments.currentState?.removeItem(
            index,
            (context, animation) {
              return SizeTransition(
                sizeFactor: animation,
                axisAlignment: 0.0,
                child: CommentWidgetInCommunity(
                    commentModel:
                        currentState.commentsResponse.data!.data![index],
                    homeDataModel: homeDataModel,
                    currentDoctorModel: currentDoctorModel,
                    commentsResponse: currentState.commentsResponse,
                    index: index,
                    updatedFeed: updatedFeed),
              );
            },
            duration: const Duration(milliseconds: 300),
          );
        }

        emit(
          ShowSingleFeedState.loaded(
            updatedCommentsResponse, // Use the updated comments list
            changeCounter,
            updatedFeed,
            false,
            false,
            '',
            null,
            false,
            true, false, false,
          ),
        );
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
                    updatedFeed: updatedFeed),
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
          ),
        );
      },
    );

    deleteCommentId = '';
    commentContent.clear();
  }

  //! create reply

  createReplyOnComment(
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
          false, // Not sending a comment
          false, // Not sending a comment
          '',
          value.highlightedCommentId,
          value.isDeleteCommentLoading,
          value.isDeleteCommentLoaded,
          true, // Sending a reply
          false,
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
              false, // Not sending a comment
              false, // Not sending a comment
              failure.message, // Show error message
              value.highlightedCommentId,
              value.isDeleteCommentLoading,
              value.isDeleteCommentLoaded,
              false, // Not sending a reply
              false,
            ),
          ),
        );
      },
      // Success case
      (success) async {
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

        // Update the replies list of the parent comment
        final updatedParentComment = parentComment.copyWith(
          replies: [...(parentComment.replies ?? []), newReply],
        );

        // Update the list of comments in the state
        final updatedComments = state
            .maybeMap(
          orElse: () => <CommentModelInCommunity>[],
          loaded: (loadedState) =>
              loadedState.commentsResponse.data?.data ?? [],
        )
            .map((comment) {
          if (comment.id == parentComment.id) {
            return updatedParentComment;
          }
          return comment;
        }).toList();

        emit(
          state.maybeMap(
            orElse: () => state,
            loaded: (value) => ShowSingleFeedState.loaded(
              value.commentsResponse.copyWith(
                data: value.commentsResponse.data?.copyWith(
                  data: updatedComments,
                ),
              ),
              changeCounter,
              value.feed,
              false, // Not sending a comment
              false, // Not sending a comment
              '',
              success.data!.id.toString(),
              value.isDeleteCommentLoading,
              value.isDeleteCommentLoaded,
              false, // Not sending a reply
              true, // Reply sent successfully
            ),
          ),
        );

        await Future.delayed(const Duration(milliseconds: 100));

        // Emit the updated state with the new reply
        emit(
          state.maybeMap(
            orElse: () => state,
            loaded: (value) => ShowSingleFeedState.loaded(
              value.commentsResponse.copyWith(
                data: value.commentsResponse.data?.copyWith(
                  data: updatedComments,
                ),
              ),
              changeCounter,
              value.feed,
              false, // Not sending a comment
              false, // Not sending a comment
              '',
              null,
              value.isDeleteCommentLoading,
              value.isDeleteCommentLoaded,
              false, // Not sending a reply
              true, // Reply sent successfully
            ),
          ),
        );
        commentToReply = null;
        commentContent.clear();
      },
    );
  }
}
