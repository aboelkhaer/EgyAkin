import 'package:egy_akin/features/score_history/presentation/cubit/score_history_state.dart';

import '../../../../exports.dart';

class ScoreHistoryCubit extends Cubit<ScoreHistoryState> {
  ScoreHistoryCubit(this._getScoreHistoryUsecase)
      : super(const ScoreHistoryState.initial());
  final GetScoreHistoryUsecase _getScoreHistoryUsecase;
  static ScoreHistoryCubit get(context) => BlocProvider.of(context);

  ScrollController? scrollController;
  bool isLoadingMoreForScroll = false;
  bool isLastPage = false;
  int _currentPage = 1;
  getScoreHistory(String doctorId) async {
    emit(const ScoreHistoryState.loading());
    _currentPage = 1;

    final result = await _getScoreHistoryUsecase.execute(
        GetScoreHistoryUsecaseInput(doctorId: doctorId, page: _currentPage));
    result.fold(
      (l) {
        emit(ScoreHistoryState.error(l.message));
      },
      (response) async {
        emit(ScoreHistoryState.loaded(response.data!, false));
      },
    );
  }

  void loadMorePatients(String doctorId) async {
    _currentPage++;
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) => ScoreHistoryState.loaded(value.scoreHistory, true),
    ));
    final result = await _getScoreHistoryUsecase.execute(
        GetScoreHistoryUsecaseInput(doctorId: doctorId, page: _currentPage));
    result.fold(
      (l) {
        _currentPage--;
        emit(ScoreHistoryState.error(l.message));
      },
      (loadMoreActions) async {
        final currentState = state;
        currentState.when(
          initial: () {},
          loading: () {},
          loaded: (scoreHistory, isSeeMore) {
            final updatedData = scoreHistory.copyWith(
              data: [
                ...scoreHistory.data!,
                ...loadMoreActions.data!.data!,
              ],
            );
            if (_currentPage >= scoreHistory.lastPage!) {
              isLastPage = true;
            } else {
              isLastPage = false;
            }
            isLoadingMoreForScroll = false;
            emit(ScoreHistoryState.loaded(updatedData, false));
          },
          error: (error) {},
        );
      },
    );
  }
}
