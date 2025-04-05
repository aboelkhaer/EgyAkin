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
    // Add this check at the start of the method
    if (isLastPage || isLoadingMoreForScroll) return;

    isLoadingMoreForScroll = true;
    _currentPage++;

    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) => TrendingState.loaded(
        '',
        '',
        value.response,
        true, // Show loading indicator
      ),
    ));

    final result =
        await _getTrendingPostsInCommunityUsecase.execute(_currentPage);

    result.fold(
      (failure) {
        _currentPage--; // Rollback page increment on failure
        isLoadingMoreForScroll = false;
        emit(TrendingState.error(failure.message));
      },
      (newData) {
        final currentState = state;
        currentState.maybeWhen(
          loaded: (_, __, response, ___) {
            // Check if we've reached the last page
            isLastPage = (response.lastPage != null &&
                _currentPage >= response.lastPage!);

            final updatedData = response.copyWith(
              data: [
                ...(response.data ?? []),
                ...(newData.data ?? []),
              ],
            );

            isLoadingMoreForScroll = false;

            emit(TrendingState.loaded(
              '',
              '',
              updatedData,
              false, // Hide loading indicator
            ));
          },
          orElse: () {
            isLoadingMoreForScroll = false;
          },
        );
      },
    );
  }
}
