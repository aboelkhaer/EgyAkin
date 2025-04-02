import 'package:egy_akin/features/community/domain/usecases/get_trending_posts_in_community_usecase.dart';
import 'package:egy_akin/features/community/presentation/cubit/trending_cubit/trending_state.dart';

import '../../../../../exports.dart';

class TrendingCubit extends Cubit<TrendingState> {
  TrendingCubit(this._getTrendingPostsInCommunityUsecase)
      : super(const TrendingState.initial());
  static TrendingCubit get(context) => BlocProvider.of(context);
  final GetTrendingPostsInCommunityUsecase _getTrendingPostsInCommunityUsecase;
  int callTrendsTabTimes = 0;
  bool isLoadingMoreForScroll = false;
  bool isLastPage = false;

  int _currentPage = 1;

  getTrendingPostsInCommunity() async {
    emit(const TrendingState.loading());
    _currentPage = 1;
    final result =
        await _getTrendingPostsInCommunityUsecase.execute(_currentPage);
    result.fold(
      (l) {
        emit(TrendingState.error(l.message));
      },
      (response) async {
        emit(TrendingState.loaded(
          '',
          '',
          response,
          false,
        ));
      },
    );
  }

  void loadMoreTrends() async {
    _currentPage++;
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) => TrendingState.loaded(
        '',
        '',
        value.response,
        true,
      ),
    ));

    final result =
        await _getTrendingPostsInCommunityUsecase.execute(_currentPage);

    result.fold(
      (l) {
        _currentPage--;
        emit(TrendingState.error(l.message));
      },
      (loadMoreTrends) async {
        final currentState = state;
        currentState.when(
          initial: () {},
          loading: () {},
          loaded: (
            snackBarMessage,
            dialogMessage,
            response,
            isSeeMore,
          ) {
            final updatedData = response.copyWith(
              data: [
                ...(response.data ?? []),
                ...(loadMoreTrends.data ?? []),
              ],
            );

            isLastPage = (response.lastPage != null &&
                _currentPage >= response.lastPage!);
            isLoadingMoreForScroll = false;

            emit(TrendingState.loaded(
              '',
              '',
              updatedData,
              false,
            ));
          },
          error: (error) {},
        );
      },
    );
  }
}
