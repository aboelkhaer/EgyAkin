import 'package:egy_akin/features/current_doctor_patients/domain/usecases/get_current_doctor_patients_usecase.dart';

import '../../../../exports.dart';

class CurrentDoctorPatientsCubit extends Cubit<CurrentDoctorPatientsState> {
  CurrentDoctorPatientsCubit(this._getCurrentDoctorPatientsUsecase)
      : super(const CurrentDoctorPatientsState.initial());
  final GetCurrentDoctorPatientsUsecase _getCurrentDoctorPatientsUsecase;
  static CurrentDoctorPatientsCubit get(context) => BlocProvider.of(context);
  ScrollController scrollController = ScrollController();

  getCurrentDoctorPatients() async {
    emit(const CurrentDoctorPatientsState.loading());

    final result = await _getCurrentDoctorPatientsUsecase.excute(_currentPage);
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
  int _currentPage = 1;
  void loadMorePatients() async {
    _currentPage++;
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) =>
          CurrentDoctorPatientsState.loaded(value.response, true),
    ));
    final result = await _getCurrentDoctorPatientsUsecase.excute(_currentPage);
    result.fold(
      (l) {
        _currentPage--;
        emit(CurrentDoctorPatientsState.error(l.message));
      },
      (loadMorePatients) async {
        final currentState = state;
        currentState.when(
          initial: () {},
          loading: () {},
          loaded: (responseData, isSeeMore) {
            final updatedData = responseData.copyWith(
              data: responseData.data!.copyWith(
                data: [
                  ...responseData.data!.data!,
                  ...loadMorePatients.data!.data!
                ],
              ),
            );
            isLoadingMoreForScroll = false;
            emit(CurrentDoctorPatientsState.loaded(updatedData, false));
          },
          error: (error) {},
        );
      },
    );
  }
}
