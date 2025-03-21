import 'package:egy_akin/features/community/domain/usecases/get_poll_voters_usecase.dart';
import 'package:egy_akin/features/poll_voters/presentation/cubit/poll_voters_state.dart';

import '../../../../exports.dart';

class PollVotersCubit extends Cubit<PollVotersState> {
  PollVotersCubit(this._getPollVotersUsecase)
      : super(const PollVotersState.initial());
  final GetPollVotersUsecase _getPollVotersUsecase;
  int changeCounter = 0;
  ScrollController? scrollController;
  bool isLoadingMoreForScroll = false;
  bool isLastPage = false;
  int _currentPage = 1;

  getPollVoters(
    String pollId,
    String optionId,
  ) async {
    emit(const PollVotersState.loading());
    _currentPage = 1;
    final result = await _getPollVotersUsecase.execute(
      GetPollVotersUsecaseInput(
        pollId: pollId,
        optionId: optionId,
        page: _currentPage,
      ),
    );
    result.fold(
      (l) {
        emit(PollVotersState.error(l.message));
      },
      (response) async {
        emit(
          PollVotersState.loaded(
            response,
            '',
            '',
            false,
            changeCounter,
          ),
        );
      },
    );
  }

  // loadMorePollVoters(
  //   String pollId,
  //   String optionId,
  // ) async {
  //   _currentPage++;
  //   emit(state.maybeMap(
  //     orElse: () => state,
  //     loaded: (value) => PollVotersState.loaded(
  //       value.response,
  //       '',
  //       '',
  //       true,
  //       changeCounter,
  //     ),
  //   ));
  //   final result = await _getPollVotersUsecase.execute(
  //     GetPollVotersUsecaseInput(
  //       pollId: pollId,
  //       optionId: optionId,
  //       page: _currentPage,
  //     ),
  //   );
  //   result.fold(
  //     (l) {
  //       _currentPage--;
  //       emit(PollVotersState.error(l.message));
  //     },
  //     (loadMoreVoters) async {
  //       final currentState = state;
  //       currentState.when(
  //         initial: () {},
  //         loading: () {},
  //         loaded: (
  //           response,
  //           snackBarMessage,
  //           dialogMessage,
  //           isSeeMore,
  //           changeCounter,
  //         ) {
  //           final updatedData = response.copyWith(
  //             data: [
  //               ...response.data!,
  //               ...loadMoreVoters.data!,
  //             ],
  //           );
  //           if (_currentPage >= response.lastPage!) {
  //             isLastPage = true;
  //           } else {
  //             isLastPage = false;
  //           }
  //           isLoadingMoreForScroll = false;
  //           emit(ScoreHistoryState.loaded(updatedData, false));
  //         },
  //         error: (error) {},
  //       );
  //     },
  //   );
  // }
}
