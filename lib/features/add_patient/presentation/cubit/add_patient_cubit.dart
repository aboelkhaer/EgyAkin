import 'package:egy_akin/features/add_patient/data/models/get_patient_history_for_add_patient.dart';
import 'package:egy_akin/features/add_patient/domain/usecases/get_patient_history_for_add_patient_usecase.dart';
import 'package:egy_akin/features/add_patient/presentation/cubit/add_patient_state.dart';

import '../../../../exports.dart';

class AddPatientCubit extends Cubit<AddPatientState> {
  AddPatientCubit(this._getPatientHistoryForAddPatientUsecase)
      : super(const AddPatientState.initial());
  static AddPatientCubit get(context) => BlocProvider.of(context);
  final GetPatientHistoryForAddPatientUsecase
      _getPatientHistoryForAddPatientUsecase;

  GlobalKey<FormState> addPatientKeyForm = GlobalKey<FormState>();
  List<QuestionModel>? questionModelList = [];
  Map<String, dynamic> formData = {};

  getPatientHistoryForAddPatient() async {
    emit(const AddPatientState.loading());
    await Future.delayed(const Duration(
        milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
    final result = await _getPatientHistoryForAddPatientUsecase.excute('1');
    result.fold(
      (l) {
        emit(AddPatientState.error(l.message));
      },
      (response) async {
        emit(AddPatientState.loaded(response.data ?? []));
      },
    );
  }
}
