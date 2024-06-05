import 'package:egy_akin/features/doctor_info_view/domain/usecases/get_doctor_info_usecase.dart';
import 'package:egy_akin/features/doctor_info_view/presentation/cubit/doctor_info_view_state.dart';

import '../../../../exports.dart';

class DoctorInfoViewCubit extends Cubit<DoctorInfoViewState> {
  DoctorInfoViewCubit(this._getDoctorInfoViewUsecase)
      : super(const DoctorInfoViewState.initial());
  final GetDoctorInfoViewUsecase _getDoctorInfoViewUsecase;
  static DoctorInfoViewCubit get(context) => BlocProvider.of(context);

  getCurrentDoctorPatients(String doctorId) async {
    emit(const DoctorInfoViewState.loading());

    final result = await _getDoctorInfoViewUsecase.excute(doctorId);
    result.fold(
      (l) {
        emit(DoctorInfoViewState.error(l.message));
      },
      (doctorInfo) async {
        emit(DoctorInfoViewState.loaded(doctorInfo));
      },
    );
  }
}
