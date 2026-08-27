import 'package:egy_akin/features/all_doctors_patients/data/models/get_filters_options_model_response.dart';
import 'package:egy_akin/features/all_doctors_patients/domain/usecases/export_patients_usecase.dart';
import 'package:egy_akin/features/all_doctors_patients/presentation/cubit/all_doctors_patients_state.dart';

import '../../../../exports.dart';

class AllDoctorsPatientsCubit extends Cubit<AllDoctorsPatientsState> {
  AllDoctorsPatientsCubit(this._getAllDoctorsPatientsUsecase,
      this._applyPatientsFiltersUsecase, this._exportPatientsUsecase)
      : super(const AllDoctorsPatientsState.initial());
  final GetAllDoctorsPatientsUsecase _getAllDoctorsPatientsUsecase;
  final ApplyPatientsFiltersUsecase _applyPatientsFiltersUsecase;
  final ExportPatientsUsecase _exportPatientsUsecase;
  static AllDoctorsPatientsCubit get(context) => BlocProvider.of(context);
  Map<String, String> formData = {};
  ScrollController? scrollController;
  GetFiltersOptionsModelResponse filtersOptions =
      const GetFiltersOptionsModelResponse(data: []);
  Map<String, TextEditingController> controllers = {};

  void setFiltersForRequest(List<GetFiltersOptionsDataModelResponse>? filters) {
    filtersOptions = GetFiltersOptionsModelResponse(data: filters ?? []);
  }

  textFormFieldControllersInit(
      List<GetFiltersOptionsDataModelResponse> filters) {
    for (var filter in filters) {
      controllers[filter.id.toString()] = TextEditingController(
        text: formData[filter.id.toString()] ?? '',
      );
    }
  }

  void resetFormData() {
    formData.clear();
    controllers.forEach((key, controller) {
      controller.clear();
    });
  }

  /// Builds request map with multiple-type filter values as List; other values stay as String.
  Map<String, dynamic> _formDataToRequestMap() {
    final multipleFilterIds = filtersOptions.data
            ?.where((f) => f.type == 'multiple')
            .map((f) => f.id.toString())
            .toSet() ??
        {};
    final result = <String, dynamic>{};
    for (final e in formData.entries) {
      if (multipleFilterIds.contains(e.key) && e.value.trim().isNotEmpty) {
        result[e.key] = e.value
            .split(',')
            .map((s) => s.trim())
            .where((s) => s.isNotEmpty)
            .toList();
      } else {
        result[e.key] = e.value;
      }
    }
    return result;
  }

  Future<void> getCurrentDoctorPatients({bool showLoading = true}) async {
    if (isClosed) return;
    if (showLoading) {
      emit(const AllDoctorsPatientsState.loading());
    }
    _currentPage = 1;
    isLastPage = false;
    isLoadingMoreForScroll = false;
    isApplyFilterDone = false;

    final result = await _getAllDoctorsPatientsUsecase.execute(_currentPage);
    if (isClosed) return;
    result.fold(
      (l) {
        if (isClosed) return;
        if (showLoading) {
          emit(AllDoctorsPatientsState.error(l.message));
          return;
        }
        emit(state.maybeMap(
          orElse: () => AllDoctorsPatientsState.error(l.message),
          loaded: (value) => AllDoctorsPatientsState.loaded(
            value.response,
            false,
            l.message,
            value.isApplyFilterLoading,
            value.isApplyFilterLoaded,
            value.isExportLoading,
            value.isExportLoaded,
            value.fileUrl,
          ),
        ));
      },
      (r) {
        if (isClosed) return;
        filtersOptions =
            GetFiltersOptionsModelResponse(data: r.filters ?? []);
        final lastPage = r.data?.lastPage ?? 1;
        final currentPage = r.data?.currentPage ?? 1;
        isLastPage = currentPage >= lastPage;
        emit(AllDoctorsPatientsState.loaded(
            r, false, '', false, false, false, false, null));
      },
    );
  }

  /// Loads filter definitions without blanking the UI with a loading state.
  Future<bool> prefetchFilterOptions() async {
    if (filtersOptions.data?.isNotEmpty ?? false) return true;

    final result = await _getAllDoctorsPatientsUsecase.execute(1);
    return result.fold(
      (l) => false,
      (r) {
        filtersOptions =
            GetFiltersOptionsModelResponse(data: r.filters ?? []);
        final alreadyLoaded = state.maybeWhen(
          loaded: (_, __, ___, ____, _____, ______, _______, ________) => true,
          orElse: () => false,
        );
        if (!alreadyLoaded) {
          final lastPage = r.data?.lastPage ?? 1;
          final currentPage = r.data?.currentPage ?? 1;
          isLastPage = currentPage >= lastPage;
          _currentPage = currentPage;
          emit(AllDoctorsPatientsState.loaded(
            r,
            false,
            '',
            false,
            false,
            false,
            false,
            null,
          ));
        } else {
          emit(state.maybeMap(
            orElse: () => state,
            loaded: (value) => AllDoctorsPatientsState.loaded(
              value.response.copyWith(filters: r.filters),
              value.isSeeMore,
              value.message,
              value.isApplyFilterLoading,
              value.isApplyFilterLoaded,
              value.isExportLoading,
              value.isExportLoaded,
              value.fileUrl,
            ),
          ));
        }
        return filtersOptions.data?.isNotEmpty ?? false;
      },
    );
  }

  bool isLoadingMoreForScroll = false;
  bool isLastPage = false;
  int _currentPage = 1;
  void loadMorePatients() async {
    if (isClosed || isLastPage || isApplyFilterDone) {
      isLoadingMoreForScroll = false;
      return;
    }
    _currentPage++;
    if (isClosed) return;
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) => AllDoctorsPatientsState.loaded(
        value.response,
        true,
        '',
        value.isApplyFilterLoading,
        value.isApplyFilterLoaded,
        value.isExportLoading,
        value.isExportLoaded,
        value.fileUrl,
      ),
    ));
    final result = await _getAllDoctorsPatientsUsecase.execute(_currentPage);
    if (isClosed) return;
    result.fold(
      (l) {
        _currentPage--;
        isLoadingMoreForScroll = false;
        if (isClosed) return;
        emit(state.maybeMap(
          orElse: () => AllDoctorsPatientsState.error(l.message),
          loaded: (value) => AllDoctorsPatientsState.loaded(
            value.response,
            false,
            l.message,
            value.isApplyFilterLoading,
            value.isApplyFilterLoaded,
            value.isExportLoading,
            value.isExportLoaded,
            value.fileUrl,
          ),
        ));
      },
      (loadMorePatients) async {
        if (isClosed) return;
        final currentState = state;
        currentState.when(
          initial: () {
            isLoadingMoreForScroll = false;
          },
          loading: () {
            isLoadingMoreForScroll = false;
          },
          loaded: (
            responseData,
            isSeeMore,
            message,
            isApplyFilterLoading,
            isApplyFilterLoaded,
            isExportLoading,
            isExportLoaded,
            fileUrl,
          ) {
            final pageLast = loadMorePatients.data?.lastPage ??
                responseData.data?.lastPage ??
                1;
            isLastPage = _currentPage >= pageLast;
            isLoadingMoreForScroll = false;
            final updatedData = responseData.copyWith(
              data: responseData.data!.copyWith(
                data: [
                  ...responseData.data!.data!,
                  ...?loadMorePatients.data?.data,
                ],
                currentPage: loadMorePatients.data?.currentPage,
                lastPage: pageLast,
                total: loadMorePatients.data?.total ?? responseData.data?.total,
              ),
            );
            emit(AllDoctorsPatientsState.loaded(
              updatedData,
              false,
              '',
              isApplyFilterLoading,
              isApplyFilterLoaded,
              isExportLoading,
              isExportLoaded,
              fileUrl,
            ));
          },
          error: (error) {
            isLoadingMoreForScroll = false;
          },
        );
      },
    );
  }

  int totalPatientInFilter = 0;

  applyPatientFilters(String isOnlyMyPatients) async {
    currentPageInFilter = 1;
    isLastPageFilter = false;
    isLoadingMoreForScrollForFilter = false;

    if (isClosed) return;
    emit(
      state.maybeMap(
        orElse: () => state,
        loaded: (value) => AllDoctorsPatientsState.loaded(
            value.response,
            value.isSeeMore,
            '',
            true,
            false,
            value.isExportLoading,
            value.isExportLoaded,
            null),
      ),
    );
    formData['only_my_patients'] = isOnlyMyPatients;

    final result = await _applyPatientsFiltersUsecase.execute(
        ApplyPatientsFiltersUsecaseInput(
            map: _formDataToRequestMap(), page: currentPageInFilter));

    if (isClosed) return;

    result.fold(
      (l) {
        if (isClosed) return;
        emit(
          state.maybeMap(
            orElse: () => state,
            loaded: (value) => AllDoctorsPatientsState.loaded(
                value.response,
                value.isSeeMore,
                l.message,
                false,
                false,
                value.isExportLoading,
                value.isExportLoaded,
                null),
          ),
        );
      },
      (r) async {
        if (isClosed) return;
        totalPatientInFilter = r.pagination!.total!;
        isApplyFilterDone = true;
        emit(
          state.maybeMap(
            orElse: () => state,
            loaded: (value) {
              var updatedData = value.response.copyWith(
                data: value.response.data!.copyWith(
                  data: r.data,
                ),
              );
              return AllDoctorsPatientsState.loaded(
                  updatedData,
                  value.isSeeMore,
                  '',
                  false,
                  true,
                  value.isExportLoading,
                  value.isExportLoaded,
                  null);
            },
          ),
        );
      },
    );
  }

  bool isApplyFilterDone = false;
  bool isLoadingMoreForScrollForFilter = false;
  bool isLastPageFilter = false;
  int currentPageInFilter = 1;
  applyPatientFiltersLoadMore() async {
    if (isClosed || isLastPageFilter) {
      isLoadingMoreForScrollForFilter = false;
      return;
    }
    currentPageInFilter++;
    if (isClosed) return;
    emit(
      state.maybeMap(
        orElse: () => state,
        loaded: (value) => AllDoctorsPatientsState.loaded(
            value.response,
            true,
            '',
            false,
            false,
            value.isExportLoading,
            value.isExportLoaded,
            null),
      ),
    );

    final result = await _applyPatientsFiltersUsecase.execute(
        ApplyPatientsFiltersUsecaseInput(
            map: _formDataToRequestMap(), page: currentPageInFilter));

    if (isClosed) return;

    result.fold(
      (l) {
        currentPageInFilter--;
        isLoadingMoreForScrollForFilter = false;
        if (isClosed) return;
        emit(
          state.maybeMap(
            orElse: () => state,
            loaded: (value) => AllDoctorsPatientsState.loaded(
                value.response,
                false,
                l.message,
                false,
                false,
                value.isExportLoading,
                value.isExportLoaded,
                null),
          ),
        );
      },
      (r) async {
        if (isClosed) return;
        final currentState = state;
        totalPatientInFilter = r.pagination!.total!;

        currentState.when(
          initial: () {
            isLoadingMoreForScrollForFilter = false;
          },
          loading: () {
            isLoadingMoreForScrollForFilter = false;
          },
          loaded: (
            responseData,
            isSeeMore,
            message,
            isApplyFilterLoading,
            isApplyFilterLoaded,
            isExportLoading,
            isExportLoaded,
            fileUrl,
          ) {
            final updatedData = responseData.copyWith(
              data: responseData.data!.copyWith(
                data: [
                  ...responseData.data!.data!,
                  ...r.data!,
                ],
              ),
            );
            if (currentPageInFilter >= r.pagination!.lastPage!) {
              isLastPageFilter = true;
            } else {
              isLastPageFilter = false;
            }
            isLoadingMoreForScrollForFilter = false;

            if (isClosed) return;
            emit(
              state.maybeMap(
                orElse: () => state,
                loaded: (value) {
                  return AllDoctorsPatientsState.loaded(
                      updatedData,
                      false,
                      '',
                      false,
                      true,
                      value.isExportLoading,
                      value.isExportLoaded,
                      null);
                },
              ),
            );
          },
          error: (error) {
            isLoadingMoreForScrollForFilter = false;
          },
        );
      },
    );
  }

  Map<String, dynamic> _exportRequestMap(bool isOnlyMyPatients) {
    final map = _formDataToRequestMap();
    map['only_my_patients'] = isOnlyMyPatients;
    return map;
  }

  exportFilteredPatients(bool isOnlyMyPatients) async {
    if (isClosed) return;
    emit(
      state.maybeMap(
        orElse: () => state,
        loaded: (value) {
          return AllDoctorsPatientsState.loaded(
              value.response,
              value.isSeeMore,
              '',
              value.isApplyFilterLoading,
              value.isApplyFilterLoaded,
              true,
              false,
              null);
        },
      ),
    );
    final result =
        await _exportPatientsUsecase.execute(_exportRequestMap(isOnlyMyPatients));
    if (isClosed) return;
    result.fold(
      (l) {
        if (isClosed) return;
        emit(
          state.maybeMap(
            orElse: () => state,
            loaded: (value) {
              return AllDoctorsPatientsState.loaded(
                  value.response,
                  value.isSeeMore,
                  l.message,
                  value.isApplyFilterLoading,
                  value.isApplyFilterLoaded,
                  false,
                  false,
                  null);
            },
          ),
        );
      },
      (r) {
        if (isClosed) return;
        emit(
          state.maybeMap(
            orElse: () => state,
            loaded: (value) {
              return AllDoctorsPatientsState.loaded(
                value.response,
                value.isSeeMore,
                '',
                value.isApplyFilterLoading,
                value.isApplyFilterLoaded,
                false,
                true,
                r.fileUrl,
              );
            },
          ),
        );
      },
    );
  }

  resetExportState() {
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) => AllDoctorsPatientsState.loaded(
          value.response, false, '', false, false, false, false, null),
    ));
  }
}
