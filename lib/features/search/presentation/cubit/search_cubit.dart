import '../../../../exports.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this._getSearchHomeUsecase) : super(const SearchState.initial());
  final GetSearchHomeUsecase _getSearchHomeUsecase;
  static SearchCubit get(context) => BlocProvider.of(context);

  TextEditingController searchController = TextEditingController();
  ScrollController? searchScrollController;

  bool patientOrDoctorOrHospital = false;
  bool dose = true;

  getSearchHome(bool isVerifiedUser) async {
    if (searchController.text.trim().isNotEmpty) {
      emit(const SearchState.loading());
      // _currentPage = 1;
      String patientValue = '';
      String doseValue = '';
      if (patientOrDoctorOrHospital) {
        patientValue = searchController.text;
      }
      if (dose) {
        doseValue = searchController.text;
      }

      final result = await _getSearchHomeUsecase.execute(
        GetSearchHomeUsecaseInput(patient: isVerifiedUser ? patientValue : '', dose: doseValue),
      );
      result.fold(
        (l) => emit(SearchState.error(l.message)),
        (r) {
          emit(SearchState.loaded(r.data!.patients, r.data!.doses));
        },
      );
    }
  }

  // void loadMorePatients() async {
  //   _currentPage++;
  //   emit(state.maybeMap(
  //     orElse: () => state,
  //     loaded: (value) => SearchState.loaded(value.response, true),
  //   ));
  //   final result = await _getSearchHomeUsecase.excute(
  //     GetSearchHomeUsecaseInput(
  //         searchContent: searchController.text, page: _currentPage),
  //   );
  //   result.fold(
  //     (l) {
  //       _currentPage--;
  //       emit(SearchState.error(l.message));
  //     },
  //     (loadMorePatients) async {
  //       final currentState = state;
  //       currentState.when(
  //         initial: () {},
  //         loading: () {},
  //         loaded: (responseData, isSeeMore) {
  //           final updatedData = responseData!.copyWith(
  //             data: responseData.data!.copyWith(
  //               data: [
  //                 ...responseData.data!.data!,
  //                 ...loadMorePatients.data!.data!
  //               ],
  //             ),
  //           );
  //           if (_currentPage >= responseData.data!.lastPage!) {
  //             isLastPage = true;
  //           } else {
  //             isLastPage = false;
  //           }
  //           isLoadingMoreForScroll = false;
  //           emit(SearchState.loaded(updatedData, false));
  //         },
  //         error: (error) {},
  //       );
  //     },
  //   );
  // }
}
