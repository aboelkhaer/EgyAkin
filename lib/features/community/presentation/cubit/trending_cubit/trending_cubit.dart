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

  Future<void> getTrendingPostsInCommunity() async {
    if (isClosed) return;
    emit(const TrendingState.loading());
    _currentPage = 1;
    isLastPage = false;
    isLoadingMoreForScroll = false;
    final result =
        await _getTrendingPostsInCommunityUsecase.execute(_currentPage);
    if (isClosed) return;
    result.fold(
      (l) {
        if (isClosed) return;
        emit(TrendingState.error(l.message));
      },
      (response) {
        if (isClosed) return;
        final lastPage = response.lastPage ?? 1;
        final currentPage = response.currentPage ?? 1;
        isLastPage = currentPage >= lastPage ||
            response.nextPageUrl == null ||
            (response.data?.isEmpty ?? true);
        emit(TrendingState.loaded(
          '',
          '',
          response,
          false,
        ));
      },
    );
  }

  /// Force-reload trends (e.g. after creating a post with hashtags).
  Future<void> refreshTrends() async {
    callTrendsTabTimes = 1;
    await getTrendingPostsInCommunity();
  }

  static final RegExp _hashtagPattern = RegExp(
    r'#[a-zA-Z0-9_\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF\uFB50-\uFDFF\uFE70-\uFEFF]+',
  );

  /// Normalized tag keys (no leading `#`, lowercased).
  static List<String> extractHashtagKeys(String? content) {
    if (content == null || content.isEmpty) return const [];
    final seen = <String>{};
    final out = <String>[];
    for (final match in _hashtagPattern.allMatches(content)) {
      final raw = match.group(0);
      if (raw == null || raw.length < 2) continue;
      final key = raw.substring(1).toLowerCase();
      if (key.isEmpty || !seen.add(key)) continue;
      out.add(key);
    }
    return out;
  }

  /// After a post with hashtags is deleted: decrement counts, drop at 0.
  void decrementHashtags(Iterable<String> tagKeys) {
    if (isClosed) return;
    final keys = tagKeys
        .map((t) => t.trim().toLowerCase().replaceFirst(RegExp(r'^#'), ''))
        .where((t) => t.isNotEmpty)
        .toSet();
    if (keys.isEmpty) return;

    final current = state;
    current.maybeWhen(
      loaded: (snack, dialog, response, isSeeMore) {
        final existing = response.data ?? const <TrendModel>[];
        if (existing.isEmpty) return;

        final updated = <TrendModel>[];
        for (final trend in existing) {
          final raw = (trend.tag ?? '').trim();
          final key = raw.startsWith('#')
              ? raw.substring(1).toLowerCase()
              : raw.toLowerCase();
          if (!keys.contains(key)) {
            updated.add(trend);
            continue;
          }
          final nextCount = (trend.usageCount ?? 1) - 1;
          if (nextCount > 0) {
            updated.add(trend.copyWith(usageCount: nextCount));
          }
        }

        emit(TrendingState.loaded(
          snack,
          dialog,
          response.copyWith(
            data: updated,
            total: updated.length,
          ),
          isSeeMore,
        ));
      },
      orElse: () {},
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
