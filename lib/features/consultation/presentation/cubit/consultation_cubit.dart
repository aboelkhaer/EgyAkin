import 'package:egy_akin/features/consultation/domain/usecases/get_current_doctor_consultation_usecase.dart';
import 'package:egy_akin/features/consultation/presentation/cubit/consultation_state.dart';

import '../../../../exports.dart';

class ConsultationCubit extends Cubit<ConsultationState> {
  ConsultationCubit(this._getCurrentDoctorConsultationUsecase)
      : super(const ConsultationState.initial());
  final GetCurrentDoctorConsultationUsecase
      _getCurrentDoctorConsultationUsecase;
  static ConsultationCubit get(context) => BlocProvider.of(context);

  getCurrentDoctorPatients() async {
    emit(const ConsultationState.loading());

    final result =
        await _getCurrentDoctorConsultationUsecase.execute(NoParams());
    result.fold(
      (l) {
        emit(ConsultationState.error(l.message));
      },
      (response) async {
        emit(ConsultationState.loaded(response));
      },
    );
  }
}
