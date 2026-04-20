import 'package:egy_akin/features/all_doctors_patients/domain/usecases/export_patients_usecase.dart';
import 'package:egy_akin/features/all_doctors_patients/domain/usecases/apply_patients_filters_usecase.dart';
import 'package:egy_akin/features/all_doctors_patients/data/models/get_filters_options_model_response.dart';

import '../../../../exports.dart';

class CurrentDoctorPatientsCubit extends Cubit<CurrentDoctorPatientsState> {
  CurrentDoctorPatientsCubit(this._getCurrentDoctorPatientsUsecase,
      this._exportPatientsUsecase, this._applyPatientsFiltersUsecase)
      : super(const CurrentDoctorPatientsState.initial());
  final GetCurrentDoctorPatientsUsecase _getCurrentDoctorPatientsUsecase;
  final ExportPatientsUsecase _exportPatientsUsecase;
  final ApplyPatientsFiltersUsecase _applyPatientsFiltersUsecase;
  static CurrentDoctorPatientsCubit get(context) => BlocProvider.of(context);
  ScrollController? scrollController;
  Map<String, String> formData = {};
  Map<String, TextEditingController> controllers = {};
  GetFiltersOptionsModelResponse filtersOptions =
      const GetFiltersOptionsModelResponse(data: []);
  bool isApplyFilterDone = false;
  bool isLoadingMoreForScrollForFilter = false;
  bool isLastPageFilter = false;
  int currentPageInFilter = 1;
  int totalPatientInFilter = 0;

  getCurrentDoctorPatients() async {
    emit(const CurrentDoctorPatientsState.loading());
    _currentPage = 1;

    final result = await _getCurrentDoctorPatientsUsecase.execute(_currentPage);
    result.fold(
      (l) {
        emit(CurrentDoctorPatientsState.error(l.message));
      },
      (r) async {
        filtersOptions = GetFiltersOptionsModelResponse(data: r.filters ?? []);
        emit(CurrentDoctorPatientsState.loaded(
            r, false, '', false, false, false, false, null, null, 0));
      },
    );
  }

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

  void resetFormData() {
    formData.clear();
    controllers.forEach((key, controller) {
      controller.clear();
    });
  }

  applyPatientFilters(String isOnlyMyPatients) async {
    currentPageInFilter = 1;
    isLastPageFilter = false;

    emit(
      state.maybeMap(
        orElse: () => state,
        loaded: (value) => CurrentDoctorPatientsState.loaded(
          value.response,
          value.isSeeMore,
          '',
          true,
          false,
          value.isExportLoading,
          value.isExportLoaded,
          value.fileUrl,
          value.filters,
          value.totalPatientInFilter,
        ),
      ),
    );
    formData['only_my_patients'] = isOnlyMyPatients;

    final result = await _applyPatientsFiltersUsecase.execute(
        ApplyPatientsFiltersUsecaseInput(
            map: _formDataToRequestMap(), page: currentPageInFilter));

    result.fold(
      (l) {
        emit(
          state.maybeMap(
            orElse: () => state,
            loaded: (value) => CurrentDoctorPatientsState.loaded(
              value.response,
              value.isSeeMore,
              l.message,
              false,
              false,
              value.isExportLoading,
              value.isExportLoaded,
              value.fileUrl,
              value.filters,
              value.totalPatientInFilter,
            ),
          ),
        );
      },
      (r) async {
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
              return CurrentDoctorPatientsState.loaded(
                updatedData,
                value.isSeeMore,
                '',
                false,
                true,
                value.isExportLoading,
                value.isExportLoaded,
                value.fileUrl,
                value.filters,
                totalPatientInFilter,
              );
            },
          ),
        );
      },
    );
  }

  applyPatientFiltersLoadMore() async {
    currentPageInFilter++;
    emit(
      state.maybeMap(
        orElse: () => state,
        loaded: (value) => CurrentDoctorPatientsState.loaded(
          value.response,
          true,
          '',
          false,
          false,
          value.isExportLoading,
          value.isExportLoaded,
          value.fileUrl,
          value.filters,
          value.totalPatientInFilter,
        ),
      ),
    );

    final result = await _applyPatientsFiltersUsecase.execute(
        ApplyPatientsFiltersUsecaseInput(
            map: _formDataToRequestMap(), page: currentPageInFilter));

    result.fold(
      (l) {
        currentPageInFilter--;
        emit(
          state.maybeMap(
            orElse: () => state,
            loaded: (value) => CurrentDoctorPatientsState.loaded(
              value.response,
              false,
              l.message,
              false,
              false,
              value.isExportLoading,
              value.isExportLoaded,
              value.fileUrl,
              value.filters,
              value.totalPatientInFilter,
            ),
          ),
        );
      },
      (r) async {
        final currentState = state;
        totalPatientInFilter = r.pagination!.total!;

        currentState.when(
          initial: () {},
          loading: () {},
          loaded: (
            responseData,
            isSeeMore,
            message,
            isApplyFilterLoading,
            isApplyFilterLoaded,
            isExportLoading,
            isExportLoaded,
            fileUrl,
            filters,
            totalPatientInFilter,
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

            emit(
              state.maybeMap(
                orElse: () => state,
                loaded: (value) {
                  return CurrentDoctorPatientsState.loaded(
                    updatedData,
                    false,
                    '',
                    false,
                    false,
                    value.isExportLoading,
                    value.isExportLoaded,
                    value.fileUrl,
                    value.filters,
                    value.totalPatientInFilter,
                  );
                },
              ),
            );
          },
          error: (error) {},
        );
      },
    );
  }

  exportFilteredPatients(bool isOnlyMyPatients) async {
    emit(
      state.maybeMap(
        orElse: () => state,
        loaded: (value) {
          return CurrentDoctorPatientsState.loaded(
              value.response,
              value.isSeeMore,
              value.message,
              value.isApplyFilterLoading,
              value.isApplyFilterLoaded,
              true,
              false,
              null,
              value.filters,
              value.totalPatientInFilter);
        },
      ),
    );
    final result = await _exportPatientsUsecase.execute(isOnlyMyPatients);
    result.fold(
      (l) {
        emit(
          state.maybeMap(
            orElse: () => state,
            loaded: (value) {
              return CurrentDoctorPatientsState.loaded(
                  value.response,
                  value.isSeeMore,
                  l.message,
                  value.isApplyFilterLoading,
                  value.isApplyFilterLoaded,
                  false,
                  false,
                  null,
                  value.filters,
                  value.totalPatientInFilter);
            },
          ),
        );
      },
      (r) {
        emit(
          state.maybeMap(
            orElse: () => state,
            loaded: (value) {
              return CurrentDoctorPatientsState.loaded(
                value.response,
                value.isSeeMore,
                value.message,
                value.isApplyFilterLoading,
                value.isApplyFilterLoaded,
                false,
                true,
                r.fileUrl,
                value.filters,
                value.totalPatientInFilter,
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
      loaded: (value) => CurrentDoctorPatientsState.loaded(
          value.response,
          value.isSeeMore,
          value.message,
          value.isApplyFilterLoading,
          value.isApplyFilterLoaded,
          false,
          false,
          null,
          value.filters,
          value.totalPatientInFilter),
    ));
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
      loaded: (value) => CurrentDoctorPatientsState.loaded(
          value.response,
          true,
          value.message,
          value.isApplyFilterLoading,
          value.isApplyFilterLoaded,
          value.isExportLoading,
          value.isExportLoaded,
          value.fileUrl,
          value.filters,
          value.totalPatientInFilter),
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
          loaded: (responseData,
              isSeeMore,
              message,
              isApplyFilterLoading,
              isApplyFilterLoaded,
              isExportLoading,
              isExportLoaded,
              fileUrl,
              filters,
              totalPatientInFilter) {
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
              message,
              isApplyFilterLoading,
              isApplyFilterLoaded,
              isExportLoading,
              isExportLoaded,
              fileUrl,
              filters,
              totalPatientInFilter,
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
