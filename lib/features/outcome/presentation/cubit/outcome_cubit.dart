import '../../../../exports.dart';

class OutcomeCubit extends Cubit<OutcomeState> {
  OutcomeCubit(this._getOutcomeUsecase, this._submitOutcomeUsecase)
      : super(const OutcomeState.initial());
  final GetOutcomeUsecase _getOutcomeUsecase;
  final SubmitOutcomeUsecase _submitOutcomeUsecase;
  static OutcomeCubit get(context) => BlocProvider.of(context);
  GlobalKey<FormState> outcomeFormKey = GlobalKey<FormState>();
  Map<String, dynamic> formData = {};

  getOutcome(String patientId) async {
    emit(const OutcomeState.loading());
    await Future.delayed(const Duration(
        milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
    final result = await _getOutcomeUsecase
        .excute(GetOutcomeUsecaseInput(sectionId: '8', patientId: patientId));
    result.fold(
      (l) {
        emit(OutcomeState.error(l.message));
      },
      (response) async {
        emit(OutcomeState.loaded(response, false, ''));
      },
    );
  }

  submitOutcome(String patientId) async {
    emit(const OutcomeState.loading());
    await Future.delayed(const Duration(
        milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
    final result = await _submitOutcomeUsecase.excute(
      SubmitUseCaseInput(
        patientId: patientId,
        sectionId: '8',
        map: formData,
      ),
    );
    result.fold(
      (l) {
        emit(OutcomeState.error(l.message));
      },
      (response) async {
        emit(OutcomeState.loaded(
            const GetOutcomeModelResponse(), true, response.message!));
      },
    );
  }
}
