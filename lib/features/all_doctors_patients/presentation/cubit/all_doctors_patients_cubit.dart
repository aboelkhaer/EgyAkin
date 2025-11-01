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

  getCurrentDoctorPatients() async {
    emit(const AllDoctorsPatientsState.loading());
    _currentPage = 1;

    final result = await _getAllDoctorsPatientsUsecase.execute(_currentPage);
    result.fold(
      (l) {
        emit(AllDoctorsPatientsState.error(l.message));
      },
      (r) async {
        emit(AllDoctorsPatientsState.loaded(
            r, false, '', false, false, false, false, null));
        // getPatientFilters();
      },
    );
  }

  bool isLoadingMoreForScroll = false;
  bool isLastPage = false;
  int _currentPage = 1;
  void loadMorePatients() async {
    _currentPage++;
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) => AllDoctorsPatientsState.loaded(value.response, true,
          '', false, false, value.isExportLoading, value.isExportLoaded, null),
    ));
    final result = await _getAllDoctorsPatientsUsecase.execute(_currentPage);
    result.fold(
      (l) {
        _currentPage--;
        emit(AllDoctorsPatientsState.error(l.message));
      },
      (loadMorePatients) async {
        final currentState = state;
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
          ) {
            final updatedData = responseData.copyWith(
              data: responseData.data!.copyWith(
                data: [
                  ...responseData.data!.data!,
                  ...loadMorePatients.data!.data!
                ],
              ),
            );
            if (_currentPage >= responseData.data!.lastPage!) {
              isLastPage = true;
            } else {
              isLastPage = false;
            }
            isLoadingMoreForScroll = false;
            emit(AllDoctorsPatientsState.loaded(
                updatedData, false, '', false, false, false, false, null));
          },
          error: (error) {},
        );
      },
    );
  }

  int totalPatientInFilter = 0;

  applyPatientFilters(String isOnlyMyPatients) async {
    currentPageInFilter = 1;
    isLastPageFilter = false;

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
            map: formData, page: currentPageInFilter));

    result.fold(
      (l) {
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
    currentPageInFilter++;
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
            map: formData, page: currentPageInFilter));

    result.fold(
      (l) {
        currentPageInFilter--;
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
                  return AllDoctorsPatientsState.loaded(
                      updatedData,
                      false,
                      '',
                      false,
                      false,
                      value.isExportLoading,
                      value.isExportLoaded,
                      null);
                },
              ),
            );
          },
          error: (error) {},
        );
      },
    );
  }

  exportFilteredPatients() async {
    emit(
      state.maybeMap(
        orElse: () => state,
        loaded: (value) {
          return AllDoctorsPatientsState.loaded(
              value.response, false, '', false, false, true, false, null);
        },
      ),
    );
    final result = await _exportPatientsUsecase.execute(NoParams());
    result.fold(
      (l) {
        emit(
          state.maybeMap(
            orElse: () => state,
            loaded: (value) {
              return AllDoctorsPatientsState.loaded(value.response, false,
                  l.message, false, false, false, false, null);
            },
          ),
        );
      },
      (r) {
        emit(
          state.maybeMap(
            orElse: () => state,
            loaded: (value) {
              return AllDoctorsPatientsState.loaded(
                value.response,
                false,
                '',
                false,
                false,
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
