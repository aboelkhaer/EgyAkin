import 'dart:developer';

import 'package:egy_akin/features/outcome/domain/usecases/get_outcome_usecase.dart';
import 'package:egy_akin/features/outcome/domain/usecases/submit_outcome_usecase.dart';

import '../../../../exports.dart';

class OutcomeCubit extends Cubit<OutcomeState> {
  OutcomeCubit(this._getOutcomeUsecase, this._submitOutcomeUsecase)
      : super(const OutcomeState.initial());
  final GetOutcomeUsecase _getOutcomeUsecase;
  final SubmitOutcomeUsecase _submitOutcomeUsecase;
  static OutcomeCubit get(context) => BlocProvider.of(context);
  GlobalKey<FormState> outcomeFormKey = GlobalKey<FormState>();
  String? outcomeOfThePatientField;
  String? creatinineOnDischargeField;
  String? durationField;
  String? finalStatusField;
  String? otherField;

  getOutcome(String patientId) async {
    emit(const OutcomeState.loading());
    await Future.delayed(const Duration(
        milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
    final result = await _getOutcomeUsecase.excute(patientId);
    result.fold(
      (l) {
        emit(OutcomeState.error(l.message));
      },
      (response) async {
        log(response.toString());
        emit(OutcomeState.loaded(response, false));
      },
    );
  }

  submitOutcome(String patientId) async {
    emit(const OutcomeState.loading());
    await Future.delayed(const Duration(
        milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
    final result = await _submitOutcomeUsecase.excute(
      SubmitUseCaseInput(
        creatinineOnDischarge: creatinineOnDischargeField!,
        durationField: durationField!,
        finalStatus: finalStatusField!,
        other: otherField!,
        outcomeOfThePatient: outcomeOfThePatientField!,
        patientId: patientId,
      ),
    );
    result.fold(
      (l) {
        emit(OutcomeState.error(l.message));
      },
      (response) async {
        emit(const OutcomeState.loaded(GetOutcomeModelResponse(), true));
        // emit(state.maybeMap(
        //   orElse: () => state,
        //   loaded: (value) => OutcomeState.loaded(value.response, true),
        // ));
      },
    );
  }
}
