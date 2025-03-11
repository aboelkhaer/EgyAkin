import 'dart:developer';

import 'package:egy_akin/features/community_search/domain/usecases/get_response_of_search_in_community_usecase.dart';
import 'package:egy_akin/features/community_search/presentation/cubit/community_search_state.dart';

import '../../../../exports.dart';

class CommunitySearchCubit extends Cubit<CommunitySearchState> {
  CommunitySearchCubit(this._getResponseOfSearchInCommunityUsecase,
      this._addLikeOnPostUsecase, this._saveOrUnsavePostUsecase)
      : super(const CommunitySearchState.initial());
  static CommunitySearchCubit get(context) => BlocProvider.of(context);
  final GetResponseOfSearchInCommunityUsecase
      _getResponseOfSearchInCommunityUsecase;
  final AddLikeOnPostUsecase _addLikeOnPostUsecase;
  final SaveOrUnsavePostUsecase _saveOrUnsavePostUsecase;
  bool isSearchContentEmpty = true;
  Timer? _debounce;

  void getResponseOfSearchInCommunity(String searchContent,
      [int? milliseconds]) {
    _debounce
        ?.cancel(); // Cancel the previous request if the user is still typing

    _debounce = Timer(Duration(milliseconds: milliseconds ?? 1000), () async {
      emit(const CommunitySearchState.loading());

      final result =
          await _getResponseOfSearchInCommunityUsecase.execute(searchContent);

      result.fold((l) => emit(CommunitySearchState.error(l.message)),
          (response) {
        emit(CommunitySearchState.loaded(
          '',
          '',
          response,
        ));
        if (isSearchContentEmpty == true) {
          resetPostsList();
        }
      });
    });
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

          return CommunitySearchState.loaded('', '', updatedResponse);
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

              return CommunitySearchState.loaded('', '', revertedResponse);
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
          return CommunitySearchState.loaded('', '', updatedResponse);
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
              return CommunitySearchState.loaded('', '', revertedResponse);
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
          );
        },
      ),
    );
  }
}
