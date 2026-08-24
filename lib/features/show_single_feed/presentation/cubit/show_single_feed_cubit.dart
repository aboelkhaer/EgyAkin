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
  /// Extra top inset while replying so early comments can sit above the keyboard.
  double replyAnchorTopPadding = 0;
  /// Items playing exit animation before being removed from the list.
  final Set<String> exitingItemIds = {};
  bool isLoadingMoreForScroll = false;
  bool isLastPage = false;
  int _currentPage = 1;

  TextEditingController commentContent = TextEditingController();
  final FocusNode commentFocusNode = FocusNode();
  ScrollController? feedScrollController;
  final GlobalKey composerKey = GlobalKey(debugLabel: 'feed-comment-composer');
  final Map<String, GlobalKey> _commentKeys = {};
  int changeCounter = 0;
  final GlobalKey<AnimatedListState> listKeyForComments =
      GlobalKey<AnimatedListState>();

  GlobalKey keyForComment(String commentId) {
    return _commentKeys.putIfAbsent(
      commentId,
      () => GlobalKey(debugLabel: 'feed-comment-$commentId'),
    );
  }

  void clearReplyTarget({bool refresh = true}) {
    commentToReply = null;
    replyAnchorTopPadding = 0;
    if (refresh) refreshScreen();
  }

  bool isItemExiting(String itemId) => exitingItemIds.contains(itemId);

  /// Called when a delete exit animation finishes — removes the item from state.
  void finalizeExitingItem(String itemId) {
    if (!exitingItemIds.remove(itemId)) return;

    final currentState = state.maybeMap(
      orElse: () => null,
      loaded: (value) => value,
    );
    if (currentState == null) return;

    final comments =
        List<CommentModelInCommunity>.from(
            currentState.commentsResponse.data?.data ?? []);

    final commentIndex =
        comments.indexWhere((c) => c.id.toString() == itemId);

    if (commentIndex != -1) {
      comments.removeAt(commentIndex);
    } else {
      for (var i = 0; i < comments.length; i++) {
        final replies = comments[i].replies;
        if (replies == null ||
            !replies.any((r) => r.id.toString() == itemId)) {
          continue;
        }
        comments[i] = comments[i].copyWith(
          replies: replies.where((r) => r.id.toString() != itemId).toList(),
          repliesCount: ((comments[i].repliesCount ?? 1) - 1) < 0
              ? 0
              : (comments[i].repliesCount ?? 1) - 1,
        );
        break;
      }
    }

    emit(
      ShowSingleFeedState.loaded(
        currentState.commentsResponse.copyWith(
          data: currentState.commentsResponse.data?.copyWith(
            data: comments,
          ),
        ),
        changeCounter + 1,
        currentState.feed,
        currentState.isSendCommentLoading,
        currentState.isSendCommentLoaded,
        '',
        currentState.highlightedCommentId,
        false,
        currentState.isDeleteCommentLoaded,
        currentState.isSendReplyLoading,
        currentState.isSendReplyLoaded,
        currentState.isSeeMore,
      ),
    );
  }

  void _beginExitAnimation(String itemId) {
    exitingItemIds.add(itemId);
    deleteCommentId = '';
    refreshScreen();
  }

  /// Focus the composer and scroll the target comment just above it.
  Future<void> beginReplyTo(CommentModelInCommunity comment) async {
    commentToReply = comment;
    replyAnchorTopPadding = 0;
    refreshScreen();

    await Future<void>.delayed(const Duration(milliseconds: 16));
    if (isClosed) return;

    commentFocusNode.requestFocus();

    // Wait until keyboard + reply chip are ready, then scroll once.
    await _waitForKeyboard(keyForComment(comment.id.toString()));
    if (isClosed) return;

    await Future<void>.delayed(const Duration(milliseconds: 80));
    if (isClosed) return;
    await WidgetsBinding.instance.endOfFrame;
    if (isClosed) return;

    await scrollItemAboveComposer(comment.id.toString());
  }

  Future<void> _waitForKeyboard(GlobalKey commentKey) async {
    final started = DateTime.now();
    const timeout = Duration(milliseconds: 400);
    double lastInset = 0;
    var stableFrames = 0;

    while (DateTime.now().difference(started) < timeout) {
      await Future<void>.delayed(const Duration(milliseconds: 20));
      if (isClosed) return;

      final ctx = commentKey.currentContext;
      if (ctx == null || !ctx.mounted) continue;

      final inset = MediaQuery.viewInsetsOf(ctx).bottom;
      if (inset > 60) {
        // Keyboard started; wait until inset stops growing.
        if ((inset - lastInset).abs() < 1) {
          stableFrames++;
          if (stableFrames >= 2) {
            await WidgetsBinding.instance.endOfFrame;
            return;
          }
        } else {
          stableFrames = 0;
        }
        lastInset = inset;
      }
    }

    await WidgetsBinding.instance.endOfFrame;
  }

  /// Places a comment/reply (full card) clearly above the composer bar.
  Future<void> scrollItemAboveComposer(
    String itemId, {
    bool didApplyTopPad = false,
  }) async {
    final controller = feedScrollController;
    if (controller == null || !controller.hasClients) return;

    final ctx = keyForComment(itemId).currentContext;
    if (ctx == null || !ctx.mounted) return;

    final commentBox = ctx.findRenderObject() as RenderBox?;
    if (commentBox == null || !commentBox.hasSize || !commentBox.attached) {
      return;
    }

    final position = controller.position;
    final viewportContext = position.context.notificationContext;
    final viewportBox = viewportContext?.findRenderObject() as RenderBox?;
    if (viewportBox == null || !viewportBox.hasSize) return;

    final viewportTopGlobal = viewportBox.localToGlobal(Offset.zero).dy;
    final commentTopGlobal = commentBox.localToGlobal(Offset.zero).dy;
    final commentBottomInViewport =
        (commentTopGlobal - viewportTopGlobal) + commentBox.size.height;

    // Align to the real composer top (not an estimate of keyboard + bar).
    const gap = 16.0;
    double targetBottom;
    final composerBox =
        composerKey.currentContext?.findRenderObject() as RenderBox?;
    if (composerBox != null && composerBox.hasSize) {
      final composerTopGlobal = composerBox.localToGlobal(Offset.zero).dy;
      targetBottom = composerTopGlobal - viewportTopGlobal - gap;
    } else {
      final media = MediaQuery.of(ctx);
      final keyboard = media.viewInsets.bottom;
      final fallbackComposer = commentToReply != null ? 130.h : 100.h;
      targetBottom =
          viewportBox.size.height - keyboard - fallbackComposer - gap;
    }

    if (targetBottom <= 0) return;

    final delta = commentBottomInViewport - targetBottom;
    final idealTarget = position.pixels + delta;

    // Early items often can't move down (already at scroll 0). Inject top
    // padding so they can sit just above the keyboard/composer.
    if (idealTarget < position.minScrollExtent - 0.5 && !didApplyTopPad) {
      final missing = position.minScrollExtent - idealTarget;
      if (missing > 1) {
        replyAnchorTopPadding = missing;
        refreshScreen();
        await Future<void>.delayed(const Duration(milliseconds: 16));
        if (isClosed) return;
        await WidgetsBinding.instance.endOfFrame;
        if (isClosed) return;
        await scrollItemAboveComposer(
          itemId,
          didApplyTopPad: true,
        );
        return;
      }
    }

    final target = idealTarget.clamp(
      position.minScrollExtent,
      position.maxScrollExtent,
    );

    if ((target - position.pixels).abs() < 1) return;

    await controller.animateTo(
      target,
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOutCubic,
    );
  }

  Future<void> _scrollToNewlyAddedItem(String itemId) async {
    // Wait for highlight/entrance widgets to mount with their GlobalKey.
    await WidgetsBinding.instance.endOfFrame;
    await Future<void>.delayed(const Duration(milliseconds: 80));
    if (isClosed) return;
    await scrollItemAboveComposer(itemId);
  }

  @override
  Future<void> close() {
    commentFocusNode.dispose();
    return super.close();
  }

  bool _isLastCommentsPage({
    required int currentPage,
    required PostCommentsData? pagination,
    bool itemsAreSinglePageOnly = false,
  }) {
    if (pagination == null) return true;

    final nextPageUrl = pagination.nextPageUrl?.trim();
    if (nextPageUrl == null || nextPageUrl.isEmpty) return true;

    final lastPage = pagination.lastPage;
    if (lastPage != null && currentPage >= lastPage) return true;

    final loadedCount = pagination.data?.length ?? 0;
    final perPage = pagination.perPage ?? 10;
    final total = pagination.total;

    // Single API page response: fewer items than page size means no more pages.
    if (itemsAreSinglePageOnly && loadedCount < perPage) return true;

    // Merged list / known totals.
    if (total != null && loadedCount >= total) return true;

    return false;
  }

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
    replyAnchorTopPadding = 0;
    exitingItemIds.clear();
    _currentPage = 1;
    isLastPage = false;
    isLoadingMoreForScroll = false;
    if (highlightedCommentId == null) {
      // Clear previous post's comments without a full-screen loading flash.
      emit(const ShowSingleFeedState.initial());

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
          isLastPage = _isLastCommentsPage(
            currentPage: _currentPage,
            pagination: r.data,
            itemsAreSinglePageOnly: true,
          );
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

    // Re-check against current pagination before requesting page 2+.
    final currentPagination = state.maybeWhen(
      loaded: (commentsResponse, _, __, ___, ____, _____, ______, _______,
              ________, _________, __________, ___________) =>
          commentsResponse.data,
      orElse: () => null,
    );
    if (_isLastCommentsPage(
      currentPage: _currentPage,
      pagination: currentPagination,
    )) {
      isLastPage = true;
      return;
    }

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
            final newPageItems = loadMoreComments.data?.data ?? [];
            isLastPage = newPageItems.isEmpty ||
                _isLastCommentsPage(
                  currentPage: _currentPage,
                  pagination: loadMoreComments.data,
                  itemsAreSinglePageOnly: true,
                );

            // Merge the existing comments with the new ones
            final updatedComments = value.commentsResponse.copyWith(
              data: value.commentsResponse.data?.copyWith(
                data: [
                  ...(value.commentsResponse.data?.data ?? []),
                  ...newPageItems,
                ],
                currentPage: _currentPage,
                lastPage: loadMoreComments.data?.lastPage,
                nextPageUrl: loadMoreComments.data?.nextPageUrl,
                total: loadMoreComments.data?.total ??
                    value.commentsResponse.data?.total,
                perPage: loadMoreComments.data?.perPage ??
                    value.commentsResponse.data?.perPage,
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
    commentContent.clear();
    replyAnchorTopPadding = 0;

    final baseFeed = state.maybeWhen(
      loaded: (_, __, stateFeed, ___, ____, _____, ______, _______, ________,
              _________, __________, ___________) =>
          stateFeed,
      orElse: () => feed,
    );

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
        final updatedFeed = baseFeed.copyWith(
          commentsCount: (baseFeed.commentsCount ?? 0) + 1,
        );
        try {
          sl<CommunityCubit>().updatePost(updatedFeed);
        } catch (_) {}

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

        final mutableCommentsList =
            List<CommentModelInCommunity>.from(commentsList);
        mutableCommentsList.insert(0, newComment);

        emit(
          state.maybeMap(
            orElse: () => state,
            loaded: (value) {
              final previousTotal = value.commentsResponse.data?.total ??
                  (value.commentsResponse.data?.data?.length ?? 0);
              return ShowSingleFeedState.loaded(
                value.commentsResponse.copyWith(
                  data: value.commentsResponse.data?.copyWith(
                    data: mutableCommentsList,
                    total: previousTotal + 1,
                  ),
                ),
                changeCounter + 1,
                updatedFeed,
                false,
                true,
                '',
                r.data!.id.toString(),
                value.isDeleteCommentLoading,
                value.isDeleteCommentLoaded,
                value.isSendReplyLoading,
                value.isSendReplyLoaded,
                value.isSeeMore,
              );
            },
          ),
        );

        await _scrollToNewlyAddedItem(r.data!.id.toString());

        await Future.delayed(const Duration(milliseconds: 1200));
        emit(
          state.maybeMap(
            orElse: () => state,
            loaded: (value) => ShowSingleFeedState.loaded(
              value.commentsResponse,
              value.changeCounter,
              value.feed,
              false,
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
        deleteCommentId = '';
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
          currentState.isSeeMore,
        ));
      },
      (r) async {
        final deletedRepliesCount = !isReply
            ? (deletedComment.replies?.length ??
                deletedComment.repliesCount ??
                0)
            : 0;
        final totalDeleted = 1 + deletedRepliesCount;

        final updatedFeed = feed.copyWith(
          commentsCount: ((feed.commentsCount ?? 0) - totalDeleted) < 0
              ? 0
              : (feed.commentsCount ?? 0) - totalDeleted,
        );

        try {
          sl<CommunityCubit>().updatePost(updatedFeed);
        } catch (_) {}

        // Keep the item mounted so the exit animation can play.
        emit(ShowSingleFeedState.loaded(
          currentState.commentsResponse,
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
          currentState.isSeeMore,
        ));

        _beginExitAnimation(commentId);
      },
    );
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
        deleteCommentId = '';
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
            currentState.isSeeMore,
          ),
        );
      },
      (success) async {
        final updatedFeed = feed.copyWith(
          commentsCount: ((feed.commentsCount ?? 0) - 1) < 0
              ? 0
              : (feed.commentsCount ?? 0) - 1,
        );

        try {
          sl<CommunityCubit>().updatePost(updatedFeed);
        } catch (_) {}

        // Keep the reply mounted so the exit animation can play.
        emit(
          ShowSingleFeedState.loaded(
            currentState.commentsResponse,
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
            currentState.isSeeMore,
          ),
        );

        _beginExitAnimation(replyId);
      },
    );
  }

  //! create reply

  Future<void> createReplyOnComment(
    String postId,
    String commentId,
    CommentModelInCommunity parentComment,
    DoctorModel currentDoctorModel, {
    String? commentText,
  }) async {
    final replyText = (commentText ?? commentContent.text).trim();
    commentContent.clear();
    commentToReply = null;
    replyAnchorTopPadding = 0;

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
        comment: replyText,
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
        try {
          sl<CommunityCubit>().updatePost(updatedFeed);
        } catch (_) {}

        // Create the new reply model
        final newReply = CommentModelInCommunity(
          id: success.data!.id,
          feedPostId: parentComment.feedPostId,
          parentId: parentComment.id,
          doctor: currentDoctorModel,
          comment: replyText,
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
            total: (currentState.commentsResponse.data?.total ??
                    updatedComments.length) +
                1,
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

        await _scrollToNewlyAddedItem(success.data!.id.toString());

        await Future.delayed(const Duration(milliseconds: 1200));

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
        replyAnchorTopPadding = 0;
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
