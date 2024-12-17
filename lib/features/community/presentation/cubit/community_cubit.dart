import 'package:egy_akin/features/community/domain/usecases/add_like_on_post_usecase.dart';
import 'package:egy_akin/features/community/domain/usecases/delete_post_in_feeds_usecase.dart';
import 'package:egy_akin/features/community/domain/usecases/get_all_feeds_usecase.dart';
import 'package:egy_akin/features/community/domain/usecases/save_or_unsave_post_usecase.dart';
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

  bool isLoadingMoreForScroll = false;
  bool isLastPage = false;
  int currentPage = 1;

  getAllFeeds() async {
    emit(const CommunityState.loading());
    final result = await _getAllFeedsUsecase.execute(currentPage);
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
        ));
      },
    );
  }

  String postIdDeleted = '';
  // make delete post function
  deletePost(String postId) async {
    postIdDeleted = postId;
    emit(
      state.maybeMap(
        orElse: () => state,
        loaded: (value) => CommunityState.loaded(
          value.feedsResponse,
          true,
          false,
          '',
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
            ),
          ),
        );
      },
    );
    postIdDeleted = '';
  }

  addLikeOrUnlikeOnPost(String postId) async {
    // Update the UI state locally
    bool isCurrentlyLiked = false;

    emit(
      state.maybeMap(
        orElse: () => state,
        loaded: (value) {
          // Ensure feedsResponse is accessible
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

    // Call the appropriate API based on whether the post is liked or unliked
    if (isCurrentlyLiked) {
      // Post is currently liked, so we need to call the "unlike" API
      final unLikeResult = await _addLikeOnPostUsecase.execute(
        AddLikeOnPostUsecaseInput(
          postId: postId,
          likeOrUnlike: 'unlike',
        ),
      );

      // Handle the result of the unlike API call
      unLikeResult.fold(
        (failure) {
          // Handle failure (e.g., rollback UI changes)
        },
        (success) {
          // Optionally handle success
        },
      );
    } else {
      // Post is currently unliked, so we need to call the "like" API
      final likeResult = await _addLikeOnPostUsecase.execute(
        AddLikeOnPostUsecaseInput(
          postId: postId,
          likeOrUnlike: 'like',
        ),
      );

      // Handle the result of the like API call
      likeResult.fold(
        (failure) {
          // Handle failure (e.g., rollback UI changes)
        },
        (success) {
          // Optionally handle success
        },
      );
    }
  }

  addSaveOrUnsaveOnPost(String postId) async {
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

    if (isCurrentlySaved) {
      final unSaveResult = await _saveOrUnsavePostUsecase.execute(
        SaveOrUnsavePostUsecaseInput(
          postId: postId,
          saveOrUnsave: 'unsave',
        ),
      );
      unSaveResult.fold(
        (failure) {
          // Handle failure (e.g., rollback UI changes)
        },
        (success) {
          // Optionally handle success
        },
      );
    } else {
      final saveResult = await _saveOrUnsavePostUsecase.execute(
        SaveOrUnsavePostUsecaseInput(
          postId: postId,
          saveOrUnsave: 'save',
        ),
      );
      saveResult.fold(
        (failure) {
          // Handle failure (e.g., rollback UI changes)
        },
        (success) {
          // Optionally handle success
        },
      );
    }
  }
}
