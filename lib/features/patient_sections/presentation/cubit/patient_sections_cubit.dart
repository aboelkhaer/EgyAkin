import 'package:egy_akin/features/patient_sections/domain/usecases/delete_patient_usecase.dart';
import 'package:egy_akin/features/patient_sections/domain/usecases/final_submit_usecase.dart';

import '../../../../exports.dart';

class PatientSectionsCubit extends Cubit<PatientSectionsState> {
  PatientSectionsCubit(this._getPatientSectionsUsecase,
      this._deletePatientUsecase, this._finalSubmitUsecase)
      : super(const PatientSectionsState.initial());
  static PatientSectionsCubit get(context) => BlocProvider.of(context);
  final GetPatientSectionsUsecase _getPatientSectionsUsecase;
  final DeletePatientUsecase _deletePatientUsecase;
  final FinalSubmitUsecase _finalSubmitUsecase;
  List<GetPatientSectionsDataModelResponse>? sectionsDataList;

  getPatientSections(String patientId) async {
    emit(const PatientSectionsState.loading());
    final result = await _getPatientSectionsUsecase.excute(patientId);

    result.fold(
      (l) {
        emit(PatientSectionsState.error(l.message));
      },
      (result) async {
        sectionsDataList = result.data;
        emit(PatientSectionsState.loaded(result, false, false));
      },
    );
  }

  deletePatient(String patientId) async {
    emit(const PatientSectionsState.loading());
    final result = await _deletePatientUsecase.excute(patientId);

    result.fold(
      (l) {
        emit(PatientSectionsState.error(l.message));
      },
      (result) async {
        emit(const PatientSectionsState.loaded(
            GetPatientSectionsModelResponse(), true, false));
      },
    );
  }

  finalSubmit(String patientId, context) async {
    List<String> sectionsNotCompleted = [];
    await Future.forEach(sectionsDataList!, (element) async {
      if (element.sectionStatus! == false) {
        sectionsNotCompleted.add(element.sectionName!);
      }
    });

    if (sectionsNotCompleted.isEmpty) {
      final result = await _finalSubmitUsecase.excute(patientId);

      result.fold(
        (l) {
          emit(PatientSectionsState.error(l.message));
        },
        (result) async {
          emit(const PatientSectionsState.loaded(
              GetPatientSectionsModelResponse(), false, true));
        },
      );
    } else {
      showCustomDialog(
          context: context,
          title: 'You left some sections in binding, continue?',
          // description:
          //     'You left sections not completed, you sure want to continue?',
          description: sectionsNotCompleted,
          noColoredBottonOnTap: () => Navigator.of(context).pop(),
          coloredBottonText: 'Submit',
          noColoredBottonText: 'Cancel',
          coloredBottonOnTap: () async {
            Navigator.of(context).pop();
            emit(const PatientSectionsState.loading());
            final result = await _finalSubmitUsecase.excute(patientId);

            result.fold(
              (l) {
                emit(PatientSectionsState.error(l.message));
              },
              (result) async {
                emit(const PatientSectionsState.loaded(
                    GetPatientSectionsModelResponse(), false, true));
              },
            );
          });
    }
    sectionsNotCompleted = [];
  }
}
