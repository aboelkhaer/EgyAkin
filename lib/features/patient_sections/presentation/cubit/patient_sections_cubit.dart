import '../../../../exports.dart';

class PatientSectionsCubit extends Cubit<PatientSectionsState> {
  PatientSectionsCubit(this._getPatientSectionsUsecase,
      this._deletePatientUsecase, this._finalSubmitUsecase)
      : super(const PatientSectionsState.initial());
  static PatientSectionsCubit get(context) => BlocProvider.of(context);
  final GetPatientSectionsUsecase _getPatientSectionsUsecase;
  final DeletePatientUsecase _deletePatientUsecase;
  final FinalSubmitUsecase _finalSubmitUsecase;
  List<SectionModel>? sectionsDataList;

  getPatientSections(String patientId) async {
    emit(const PatientSectionsState.loading());
    final result = await _getPatientSectionsUsecase.excute(patientId);

    result.fold(
      (l) {
        emit(PatientSectionsState.error(l.message));
      },
      (result) async {
        sectionsDataList = result.data;
        emit(PatientSectionsState.loaded(result, false, false, '', false));
      },
    );
  }

  deletePatient(String patientId) async {
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) =>
          PatientSectionsState.loaded(value.response, false, false, '', true),
    ));
    final result = await _deletePatientUsecase.excute(patientId);

    result.fold(
      (l) {
        emit(state.maybeMap(
          orElse: () => state,
          loaded: (value) => PatientSectionsState.loaded(
              value.response, false, false, l.message, false),
        ));
      },
      (result) async {
        emit(state.maybeMap(
          orElse: () => state,
          loaded: (value) => PatientSectionsState.loaded(
              value.response, true, false, '', false),
        ));
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
      emit(state.maybeMap(
        orElse: () => state,
        loaded: (value) =>
            PatientSectionsState.loaded(value.response, false, false, '', true),
      ));
      final result = await _finalSubmitUsecase.excute(patientId);

      result.fold(
        (l) {
          emit(state.maybeMap(
            orElse: () => state,
            loaded: (value) => PatientSectionsState.loaded(
                value.response, false, false, l.message, false),
          ));
        },
        (result) async {
          emit(state.maybeMap(
            orElse: () => state,
            loaded: (value) => PatientSectionsState.loaded(
                value.response, false, true, '', false),
          ));
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
                    GetPatientSectionsModelResponse(), false, true, '', false));
              },
            );
          });
    }
    sectionsNotCompleted = [];
  }
}
