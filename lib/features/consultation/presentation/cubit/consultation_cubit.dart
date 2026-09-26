import '../../../../exports.dart';

class ConsultationCubit extends Cubit<ConsultationState> {
  ConsultationCubit(this._getCurrentDoctorConsultationUsecase,
      this._getReceivedConsultationUsecase)
      : super(const ConsultationState.initial());
  final GetCurrentDoctorConsultationUsecase
      _getCurrentDoctorConsultationUsecase;
  final GetReceivedConsultationUsecase _getReceivedConsultationUsecase;
  static ConsultationCubit get(context) => BlocProvider.of(context);

  List<GetCurrentDoctorConsultationModelResponse> myConsultations = [];
  List<GetCurrentDoctorConsultationModelResponse> receivedConsultations = [];
  bool isLoadingMy = false;
  bool isLoadingReceived = false;

  getCurrentDoctorConsultations() async {
    isLoadingMy = true;
    emit(const ConsultationState.myConsultationsLoading());

    final result =
        await _getCurrentDoctorConsultationUsecase.execute(NoParams());
    result.fold(
      (l) {
        isLoadingMy = false;
        emit(ConsultationState.error(l.message));
      },
      (response) async {
        isLoadingMy = false;
        myConsultations = response;
        emit(ConsultationState.myConsultationsLoaded(myConsultations));
      },
    );
  }

  getReceivedConsultations() async {
    isLoadingReceived = true;
    emit(const ConsultationState.receivedConsultationsLoading());

    final result = await _getReceivedConsultationUsecase.execute(NoParams());
    result.fold(
      (l) {
        isLoadingReceived = false;
        emit(ConsultationState.error(l.message));
      },
      (response) async {
        isLoadingReceived = false;
        receivedConsultations = response;
        emit(ConsultationState.receivedConsultationsLoaded(
          receivedConsultations,
        ));
      },
    );
  }

  void updateConsultationIsOpen(String consultationId, bool isOpen) {
    myConsultations = _withOpen(myConsultations, consultationId, isOpen);
    receivedConsultations =
        _withOpen(receivedConsultations, consultationId, isOpen);
    emit(
      state.maybeMap(
        receivedConsultationsLoading: (_) =>
            ConsultationState.receivedConsultationsLoaded(
          List.of(receivedConsultations),
        ),
        receivedConsultationsLoaded: (_) =>
            ConsultationState.receivedConsultationsLoaded(
          List.of(receivedConsultations),
        ),
        orElse: () => ConsultationState.myConsultationsLoaded(
          List.of(myConsultations),
        ),
      ),
    );
  }

  List<GetCurrentDoctorConsultationModelResponse> _withOpen(
    List<GetCurrentDoctorConsultationModelResponse> list,
    String consultationId,
    bool isOpen,
  ) {
    return [
      for (final consultation in list)
        if (consultation.id?.toString() == consultationId)
          consultation.copyWith(isOpen: isOpen)
        else
          consultation
    ];
  }
}
