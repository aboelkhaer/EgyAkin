import 'package:egy_akin/features/profile_patients/domain/usecases/get_profile_patients_usecase.dart';
import 'package:egy_akin/features/profile_patients/presentation/cubit/profile_patients_state.dart';

import '../../../../exports.dart';

class ProfilePatientsCubit extends Cubit<ProfilePatientsState> {
  ProfilePatientsCubit(this._getProfilePatientsUsecase)
      : super(const ProfilePatientsState.initial());
  final GetProfilePatientsUsecase _getProfilePatientsUsecase;
  static ProfilePatientsCubit get(context) => BlocProvider.of(context);

  ScrollController? scrollController;
  bool isLoadingMoreForScroll = false;
  bool isLastPage = false;
  int _currentPage = 1;

  getProfilePatients(String doctorId) async {
    emit(const ProfilePatientsState.loading());

    final result = await _getProfilePatientsUsecase.excute(
      GetProfilePatientsUsecaseInput(
        doctorId: doctorId,
        page: _currentPage,
      ),
    );
    result.fold(
      (l) {
        emit(ProfilePatientsState.error(l.message));
      },
      (r) async {
        emit(ProfilePatientsState.loaded(r, false));
      },
    );
  }

  void loadMorePatients(String doctorId) async {
    _currentPage++;
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) => ProfilePatientsState.loaded(value.response, true),
    ));
    final result = await _getProfilePatientsUsecase.excute(
      GetProfilePatientsUsecaseInput(
        doctorId: doctorId,
        page: _currentPage,
      ),
    );
    result.fold(
      (l) {
        _currentPage--;
        emit(ProfilePatientsState.error(l.message));
      },
      (loadMorePatients) async {
        final currentState = state;
        currentState.when(
          initial: () {},
          loading: () {},
          loaded: (responseData, isSeeMore) {
            // final updatedData = responseData.copyWith(
            //   data: responseData.data!.copyWith(
            //     data: [
            //       ...responseData.data!.data!,
            //       ...loadMorePatients.data!.data!
            //     ],
            //   ),
            // );
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
            emit(ProfilePatientsState.loaded(updatedData, false));
          },
          error: (error) {},
        );
      },
    );
  }
}
