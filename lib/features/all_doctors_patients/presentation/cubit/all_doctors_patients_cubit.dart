import 'package:egy_akin/features/all_doctors_patients/data/models/get_filters_options_model_response.dart';
import 'package:egy_akin/features/all_doctors_patients/domain/usecases/apply_patients_filters_usecase.dart';
import 'package:egy_akin/features/all_doctors_patients/domain/usecases/get_filters_options_usecase.dart';
import 'package:egy_akin/features/all_doctors_patients/presentation/cubit/all_doctors_patients_state.dart';

import '../../../../exports.dart';

class AllDoctorsPatientsCubit extends Cubit<AllDoctorsPatientsState> {
  AllDoctorsPatientsCubit(this._getAllDoctorsPatientsUsecase,
      this._getFiltersOptionsUsecase, this._applyPatientsFiltersUsecase)
      : super(const AllDoctorsPatientsState.initial());
  final GetAllDoctorsPatientsUsecase _getAllDoctorsPatientsUsecase;
  final GetFiltersOptionsUsecase _getFiltersOptionsUsecase;
  final ApplyPatientsFiltersUsecase _applyPatientsFiltersUsecase;
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

    final result = await _getAllDoctorsPatientsUsecase.execute(_currentPage);
    result.fold(
      (l) {
        emit(AllDoctorsPatientsState.error(l.message));
      },
      (r) async {
        emit(AllDoctorsPatientsState.loaded(
          r,
          false,
          false,
          false,
          '',
          filtersOptions,
          false,
          false,
        ));
        getPatientFilters();
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
      loaded: (value) => AllDoctorsPatientsState.loaded(
        value.response,
        true,
        false,
        false,
        '',
        filtersOptions,
        false,
        false,
      ),
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
            isFilterLoading,
            isFilterLoaded,
            message,
            filters,
            isApplyFilterLoading,
            isApplyFilterLoaded,
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
              updatedData,
              false,
              false,
              false,
              '',
              filtersOptions,
              false,
              false,
            ));
          },
          error: (error) {},
        );
      },
    );
  }

  getPatientFilters() async {
    emit(
      state.maybeMap(
        orElse: () => state,
        loaded: (value) => AllDoctorsPatientsState.loaded(
          value.response,
          value.isSeeMore,
          true,
          false,
          '',
          filtersOptions,
          false,
          false,
        ),
      ),
    );

    final result = await _getFiltersOptionsUsecase.execute(NoParams());

    result.fold(
      (l) {
        emit(
          state.maybeMap(
            orElse: () => state,
            loaded: (value) => AllDoctorsPatientsState.loaded(
              value.response,
              value.isSeeMore,
              false,
              false,
              l.message,
              filtersOptions,
              false,
              false,
            ),
          ),
        );
      },
      (r) async {
        filtersOptions = r;
        emit(
          state.maybeMap(
            orElse: () => state,
            loaded: (value) => AllDoctorsPatientsState.loaded(
              value.response,
              value.isSeeMore,
              false,
              true,
              '',
              filtersOptions,
              false,
              false,
            ),
          ),
        );
      },
    );
  }

  applyPatientFilters() async {
    emit(
      state.maybeMap(
        orElse: () => state,
        loaded: (value) => AllDoctorsPatientsState.loaded(
          value.response,
          value.isSeeMore,
          false,
          false,
          '',
          value.filters,
          true,
          false,
        ),
      ),
    );

    final result = await _applyPatientsFiltersUsecase.execute(formData);

    result.fold(
      (l) {
        emit(
          state.maybeMap(
            orElse: () => state,
            loaded: (value) => AllDoctorsPatientsState.loaded(
              value.response,
              value.isSeeMore,
              false,
              false,
              l.message,
              value.filters,
              false,
              false,
            ),
          ),
        );
      },
      (r) async {
        debugPrint(r.message);
        emit(
          state.maybeMap(
            orElse: () => state,
            loaded: (value) => AllDoctorsPatientsState.loaded(
              value.response,
              value.isSeeMore,
              false,
              false,
              '',
              value.filters,
              false,
              true,
            ),
          ),
        );
        // emit(AllDoctorsPatientsState.loaded(response, isSeeMore, isFilterLoading, isFilterLoaded, message, filters, isApplyFilterLoading, isApplyFilterLoaded))
      },
    );
  }
}
