import 'package:egy_akin/features/community/domain/usecases/get_trending_posts_in_community_usecase.dart';
import 'package:egy_akin/features/community/presentation/cubit/trending_cubit/trending_state.dart';

import '../../../../../exports.dart';

class TrendingCubit extends Cubit<TrendingState> {
  TrendingCubit(this._getTrendingPostsInCommunityUsecase)
      : super(const TrendingState.initial());
  static TrendingCubit get(context) => BlocProvider.of(context);
  final GetTrendingPostsInCommunityUsecase _getTrendingPostsInCommunityUsecase;
  int callTrendsTabTimes = 0;
  getTrendingPostsInCommunity() async {
    emit(const TrendingState.loading());
    final result =
        await _getTrendingPostsInCommunityUsecase.execute(NoParams());
    result.fold(
      (l) {
        emit(TrendingState.error(l.message));
      },
      (response) async {
        emit(TrendingState.loaded(
          '',
          '',
          response,
        ));
      },
    );
  }
}
