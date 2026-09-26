import 'package:egy_akin/features/community/data/models/get_posts_community_model_response.dart';
import 'package:egy_akin/features/saved_posts/presentation/cubit/saved_posts_cubit.dart';
import 'package:egy_akin/injection_container.dart';

/// Adds or removes a post from the Saved posts list in memory (no refetch).
class SavedPostsLocalSync {
  static SavedPostsCubit? _cubit() {
    if (!sl.isRegistered<SavedPostsCubit>()) return null;
    final cubit = resolveSavedPostsCubit();
    return cubit.isClosed ? null : cubit;
  }

  static void apply({
    required String saveOrUnsave,
    required PostCommunityModel post,
  }) {
    final cubit = _cubit();
    if (cubit == null) return;
    final postId = post.id?.toString();
    if (postId == null || postId.isEmpty) return;
    if (saveOrUnsave == 'save') {
      cubit.upsertSavedPost(post);
    } else {
      cubit.removeSavedPost(postId);
    }
  }

  static void revert({
    required String saveOrUnsave,
    required PostCommunityModel post,
  }) {
    apply(
      saveOrUnsave: saveOrUnsave == 'save' ? 'unsave' : 'save',
      post: post,
    );
  }
}
