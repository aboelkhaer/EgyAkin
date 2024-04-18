import 'package:egy_akin/app/shared/functions/animate_to_bottom_of_screen.dart';
import 'package:egy_akin/features/post_details/domain/usecases/add_comment_on_post_usecase.dart';
import 'package:egy_akin/features/post_details/domain/usecases/delete_post_comment_usecase.dart';
import 'package:egy_akin/features/post_details/domain/usecases/get_post_comments_usecase.dart';

import '../../../../exports.dart';

class PostDetailsCubit extends Cubit<PostDetailsState> {
  PostDetailsCubit(
    this._getPostCommentsUsecase,
    this._deletePostCommentUsecase,
    this._addCommentOnPostUsecase,
  ) : super(const PostDetailsState.initial());
  static PostDetailsCubit get(context) => BlocProvider.of(context);
  final GetPostCommentsUsecase _getPostCommentsUsecase;
  final DeletePostCommentUsecase _deletePostCommentUsecase;
  final AddCommentOnPostUsecase _addCommentOnPostUsecase;
  ScrollController scrollController = ScrollController();
  String newComment = '';

  getPostComments(String postId) async {
    emit(const PostDetailsState.loading());
    final result = await _getPostCommentsUsecase.excute(postId);

    result.fold(
      (l) {
        emit(PostDetailsState.error(l.message));
      },
      (result) async {
        emit(PostDetailsState.loaded(result.data ?? []));
      },
    );
  }

  void deletePostComment(String commentId) async {
    final result = await _deletePostCommentUsecase.excute(commentId);

    result.fold(
      (l) {
        emit(PostDetailsState.error(l.message));
      },
      (result) async {
        state.maybeMap(
          loaded: (value) {
            final updatedComments = value.comments
                .where((comment) => comment.id.toString() != commentId)
                .toList();
            emit(PostDetailsState.loaded(updatedComments));
          },
          orElse: () => state,
        );
      },
    );
  }

  void addCommentOnPost(String postId) async {
    if (newComment.trim() != '') {
      emit(const PostDetailsState.loading());
      final result = await _addCommentOnPostUsecase.excute(
        AddCommentOnPostUseCaseInput(
          postId: postId,
          content: newComment,
        ),
      );

      result.fold(
        (l) {
          emit(PostDetailsState.error(l.message));
        },
        (result) async {
          newComment = '';
          final getCommentsResult =
              await _getPostCommentsUsecase.excute(postId);
          getCommentsResult.fold(
            (l) {
              emit(PostDetailsState.error(l.message));
            },
            (r) {
              emit(PostDetailsState.loaded(r.data!));
              animateToBottomOfScreen(scrollController);
            },
          );
        },
      );
    }
  }
}
