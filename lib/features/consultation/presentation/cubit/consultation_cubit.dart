import '../../../../exports.dart';

class ConsultationCubit extends Cubit<ConsultationState> {
  ConsultationCubit(this._getCurrentDoctorConsultationUsecase,
      this._getReceivedConsultationUsecase)
      : super(const ConsultationState.initial());
  final GetCurrentDoctorConsultationUsecase
      _getCurrentDoctorConsultationUsecase;
  final GetReceivedConsultationUsecase _getReceivedConsultationUsecase;
  static ConsultationCubit get(context) => BlocProvider.of(context);

  getCurrentDoctorConsultations() async {
    emit(const ConsultationState.myConsultationsLoading());

    final result =
        await _getCurrentDoctorConsultationUsecase.execute(NoParams());
    result.fold(
      (l) {
        emit(ConsultationState.error(l.message));
      },
      (response) async {
        emit(ConsultationState.myConsultationsLoaded(response));
      },
    );
  }

  getReceivedConsultations() async {
    emit(const ConsultationState.receivedConsultationsLoading());

    final result = await _getReceivedConsultationUsecase.execute(NoParams());
    result.fold(
      (l) {
        emit(ConsultationState.error(l.message));
      },
      (response) async {
        emit(ConsultationState.receivedConsultationsLoaded(response));
      },
    );
  }
}
