import 'package:egy_akin/features/marked_patients/domain/usecases/get_marked_patients_usecase.dart';
import 'package:egy_akin/features/marked_patients/presentation/cubit/marked_patients_state.dart';

import '../../../../exports.dart';

class MarkedPatientsCubit extends Cubit<MarkedPatientsState> {
  MarkedPatientsCubit(this._getMarkedPatientsUsecase)
      : super(const MarkedPatientsState.initial());
  static MarkedPatientsCubit get(context) => BlocProvider.of(context);
  final GetMarkedPatientsUsecase _getMarkedPatientsUsecase;
  int currentPage = 1;
  bool isLoadingMoreForScroll = false;
  bool isLastPage = false;
  ScrollController? scrollController;

  getMarkedPatients() async {
    emit(const MarkedPatientsState.loading());
    currentPage = 1;
    isLastPage = false;
    final result = await _getMarkedPatientsUsecase.execute(currentPage);
    result.fold(
      (l) {
        emit(MarkedPatientsState.error(l.message));
      },
      (r) {
        // Check if we're on the last page using pagination info from data
        isLastPage = (r.data?.currentPage == r.data?.lastPage) ||
            (r.data?.data == null) ||
            (r.data!.data != null && r.data!.data!.isEmpty) ||
            (r.data?.nextPageUrl == null);
        emit(MarkedPatientsState.loaded(r, false));
      },
    );
  }

  loadMoreMarkedPatients() async {
    if (isLastPage || isLoadingMoreForScroll) return;

    isLoadingMoreForScroll = true;
    currentPage++;

    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) => MarkedPatientsState.loaded(value.response, true),
    ));

    final result = await _getMarkedPatientsUsecase.execute(currentPage);
    result.fold(
      (l) {
        isLoadingMoreForScroll = false;
        currentPage--; // Revert page increment on error
        emit(MarkedPatientsState.error(l.message));
      },
      (r) {
        isLoadingMoreForScroll = false;
        // Check if we're on the last page
        isLastPage = (r.data?.currentPage == r.data?.lastPage) ||
            (r.data?.data == null) ||
            (r.data!.data != null && r.data!.data!.isEmpty) ||
            (r.data?.nextPageUrl == null);

        emit(state.maybeMap(
          orElse: () => state,
          loaded: (value) {
            final existingData = value.response.data?.data ?? [];
            final newData = r.data?.data ?? [];
            return MarkedPatientsState.loaded(
              value.response.copyWith(
                data: value.response.data?.copyWith(
                  data: [...existingData, ...newData],
                  currentPage: r.data?.currentPage,
                  lastPage: r.data?.lastPage,
                  total: r.data?.total,
                  nextPageUrl: r.data?.nextPageUrl,
                ),
              ),
              false,
            );
          },
        ));
      },
    );
  }
}
