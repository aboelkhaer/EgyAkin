import 'package:egy_akin/features/all_doctors_patients/presentation/cubit/all_doctors_patients_state.dart';

import '../../../../exports.dart';

class AllDoctorsPatientsCubit extends Cubit<AllDoctorsPatientsState> {
  AllDoctorsPatientsCubit(this._getAllDoctorsPatientsUsecase)
      : super(const AllDoctorsPatientsState.initial());
  final GetAllDoctorsPatientsUsecase _getAllDoctorsPatientsUsecase;
  static AllDoctorsPatientsCubit get(context) => BlocProvider.of(context);

  ScrollController? scrollController;

  getCurrentDoctorPatients() async {
    emit(const AllDoctorsPatientsState.loading());

    final result = await _getAllDoctorsPatientsUsecase.execute(_currentPage);
    result.fold(
      (l) {
        emit(AllDoctorsPatientsState.error(l.message));
      },
      (r) async {
        emit(AllDoctorsPatientsState.loaded(r, false));
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
      loaded: (value) => AllDoctorsPatientsState.loaded(value.response, true),
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
          loaded: (responseData, isSeeMore) {
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
            emit(AllDoctorsPatientsState.loaded(updatedData, false));
          },
          error: (error) {},
        );
      },
    );
  }
}
