import 'package:egy_akin/features/doctor_info_view/presentation/cubit/doctor_info_view_state.dart';
import '../../../../exports.dart';

class DoctorInfoViewCubit extends Cubit<DoctorInfoViewState> {
  DoctorInfoViewCubit(this._getDoctorInfoViewUsecase)
      : super(const DoctorInfoViewState.initial());
  final GetDoctorInfoViewUsecase _getDoctorInfoViewUsecase;
  static DoctorInfoViewCubit get(context) => BlocProvider.of(context);

  getCurrentDoctorPatients(String doctorId) async {
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
