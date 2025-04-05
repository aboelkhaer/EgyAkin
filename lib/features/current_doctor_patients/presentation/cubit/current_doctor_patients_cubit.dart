import '../../../../exports.dart';

class CurrentDoctorPatientsCubit extends Cubit<CurrentDoctorPatientsState> {
  CurrentDoctorPatientsCubit(this._getCurrentDoctorPatientsUsecase)
      : super(const CurrentDoctorPatientsState.initial());
  final GetCurrentDoctorPatientsUsecase _getCurrentDoctorPatientsUsecase;
  static CurrentDoctorPatientsCubit get(context) => BlocProvider.of(context);
  ScrollController? scrollController;

  getCurrentDoctorPatients() async {
    emit(const CurrentDoctorPatientsState.loading());
    _currentPage = 1;

    final result = await _getCurrentDoctorPatientsUsecase.execute(_currentPage);
    result.fold(
      (l) {
        emit(CurrentDoctorPatientsState.error(l.message));
      },
      (r) async {
        emit(CurrentDoctorPatientsState.loaded(r, false));
      },
    );
  }

  bool isLoadingMoreForScroll = false;
  bool isLastPage = false;
  int _currentPage = 1;
  void loadMorePatients() async {
    // Early exit if already on last page
    if (isLastPage) return;

    _currentPage++;
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) =>
          CurrentDoctorPatientsState.loaded(value.response, true),
    ));

    final result = await _getCurrentDoctorPatientsUsecase.execute(_currentPage);

    result.fold(
      (failure) {
        _currentPage--; // Revert page increment on failure
        isLoadingMoreForScroll = false;
        emit(CurrentDoctorPatientsState.error(failure.message));
      },
      (newData) {
        final currentState = state;
        currentState.maybeWhen(
          loaded: (responseData, isSeeMore) {
            // Check if we've reached the last page
            final reachedLastPage =
                _currentPage >= responseData.data!.lastPage!;

            final updatedData = responseData.copyWith(
              data: responseData.data!.copyWith(
                data: [
                  ...responseData.data!.data!,
                  ...newData.data!.data!,
                ],
              ),
            );

            // Update state variables
            isLastPage = reachedLastPage;
            isLoadingMoreForScroll = false;

            emit(CurrentDoctorPatientsState.loaded(
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
