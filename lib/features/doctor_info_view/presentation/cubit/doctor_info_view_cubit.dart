import 'package:egy_akin/features/doctor_info_view/domain/usecases/get_achievements_usecase.dart';

import '../../../../exports.dart';

class DoctorInfoViewCubit extends Cubit<DoctorInfoViewState> {
  DoctorInfoViewCubit(
      this._getDoctorInfoViewUsecase, this._getAchievementsUsecase)
      : super(const DoctorInfoViewState.initial());
  final GetDoctorInfoViewUsecase _getDoctorInfoViewUsecase;
  final GetAchievementsUsecase _getAchievementsUsecase;
  static DoctorInfoViewCubit get(context) => BlocProvider.of(context);

  getDoctorInfo(String doctorId) async {
    emit(const DoctorInfoViewState.loading());

    final result = await _getDoctorInfoViewUsecase.execute(doctorId);
    result.fold(
      (l) {
        emit(DoctorInfoViewState.error(l.message));
      },
      (doctorInfo) async {
        emit(DoctorInfoViewState.loaded(doctorInfo, false, false, '', null));
      },
    );
    getAchievementsV1(doctorId);
  }

  getAchievementsV2(String doctorId) async {
    emit(const DoctorInfoViewState.loaded(null, true, false, '', null));

    final result = await _getAchievementsUsecase.execute(doctorId);
    result.fold(
      (l) {
        emit(DoctorInfoViewState.error(l.message));
      },
      (achievements) async {
        emit(DoctorInfoViewState.loaded(null, false, true, '', achievements));
      },
    );
  }

  getAchievementsV1(String doctorId) async {
    emit(
      state.maybeMap(
        orElse: () => state,
        loaded: (value) => DoctorInfoViewState.loaded(
          value.doctorInfo,
          true,
          false,
          '',
          null,
        ),
      ),
    );

    final result = await _getAchievementsUsecase.execute(doctorId);
    result.fold(
      (l) {
        emit(
          state.maybeMap(
            orElse: () => state,
            loaded: (value) => DoctorInfoViewState.loaded(
              value.doctorInfo,
              false,
              false,
              l.message,
              null,
            ),
          ),
        );
      },
      (achievements) async {
        emit(
          state.maybeMap(
            orElse: () => state,
            loaded: (value) => DoctorInfoViewState.loaded(
              value.doctorInfo,
              false,
              true,
              '',
              achievements,
            ),
          ),
        );
      },
    );
  }

  // getScoreHistory(String doctorId) async {
  //   emit(
  //     state.maybeMap(
  //       orElse: () => state,
  //       loaded: (value) => DoctorInfoViewState.loaded(
  //         value.doctorInfo,
  //         true,
  //         false,
  //         '',
  //         null,
  //       ),
  //     ),
  //   );

  //   final result = await _getScoreHistoryUsecase.excute(
  //       GetScoreHistoryUsecaseInput(doctorId: doctorId, page: _currentPage));
  //   result.fold(
  //     (l) {
  //       emit(state.maybeMap(
  //         orElse: () => state,
  //         loaded: (value) => DoctorInfoViewState.loaded(
  //           value.doctorInfo,
  //           false,
  //           false,
  //           l.message,
  //           null,
  //         ),
  //       ));
  //     },
  //     (response) async {
  //       emit(state.maybeMap(
  //         orElse: () => state,
  //         loaded: (value) => DoctorInfoViewState.loaded(
  //           value.doctorInfo,
  //           false,
  //           true,
  //           '',
  //           response,
  //         ),
  //       ));
  //     },
  //   );
  // }
}
