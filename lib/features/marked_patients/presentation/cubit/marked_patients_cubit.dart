import 'package:egy_akin/features/marked_patients/data/models/get_marked_patients_model_response.dart';
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

  bool get hasLoadedList => state.maybeWhen(
        loaded: (_, __) => true,
        orElse: () => false,
      );

  Future<void> ensureMarkedPatientsLoaded() async {
    if (hasLoadedList) return;
    await getMarkedPatients();
  }

  /// Removes [patientId] from the loaded list. Returns the removed item if found.
  PatientHomeDataModel? removePatientById(String patientId) {
    PatientHomeDataModel? removed;
    state.maybeWhen(
      orElse: () {},
      loaded: (response, isSeeMore) {
        final list = [...(response.data?.data ?? const <PatientHomeDataModel>[])];
        final index = list.indexWhere(
          (p) => p.id?.toString() == patientId,
        );
        if (index < 0) return;
        removed = list.removeAt(index);
        final previousTotal = response.data?.total;
        emit(
          MarkedPatientsState.loaded(
            response.copyWith(
              data: response.data?.copyWith(
                data: list,
                total: previousTotal == null
                    ? list.length
                    : (previousTotal - 1).clamp(0, previousTotal),
              ),
            ),
            false,
          ),
        );
      },
    );
    return removed;
  }

  /// Inserts [patient] at the top of the loaded list if it is not already there.
  void addPatientIfAbsent(PatientHomeDataModel patient) {
    state.maybeWhen(
      orElse: () {},
      loaded: (response, isSeeMore) {
        final list = [...(response.data?.data ?? const <PatientHomeDataModel>[])];
        if (list.any((p) => p.id?.toString() == patient.id?.toString())) {
          return;
        }
        final next = [patient, ...list];
        final previousTotal = response.data?.total;
        final nested = response.data;
        emit(
          MarkedPatientsState.loaded(
            response.copyWith(
              data: nested == null
                  ? GetMarkedPatientsDataModelResponse(
                      data: next,
                      total: next.length,
                    )
                  : nested.copyWith(
                      data: next,
                      total: previousTotal == null
                          ? next.length
                          : previousTotal + 1,
                    ),
            ),
            false,
          ),
        );
      },
    );
  }

  Future<void> getMarkedPatients() async {
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
