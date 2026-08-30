import 'package:egy_akin/features/patient_sections/domain/usecases/make_mark_patient_usecase.dart';
import 'package:egy_akin/features/patient_sections/domain/usecases/make_unmark_patient_usecase.dart';
import 'package:egy_akin/features/patient_sections/presentation/widgets/final_submit_incomplete_dialog.dart';

import '../../../../exports.dart';

class PatientSectionsCubit extends Cubit<PatientSectionsState> {
  PatientSectionsCubit(
    this._getPatientSectionsUsecase,
    this._deletePatientUsecase,
    this._finalSubmitUsecase,
    this._downloadPatientReportUsecase,
    this._makeMarkPatientUsecase,
    this._makeUnMarkPatientUsecase,
  ) : super(const PatientSectionsState.initial());
  static PatientSectionsCubit get(context) => BlocProvider.of(context);
  final GetPatientSectionsUsecase _getPatientSectionsUsecase;
  final DeletePatientUsecase _deletePatientUsecase;
  final FinalSubmitUsecase _finalSubmitUsecase;
  final DownloadPatientReportUsecase _downloadPatientReportUsecase;
  final MakeMarkPatientUsecase _makeMarkPatientUsecase;
  final MakeUnMarkPatientUsecase _makeUnMarkPatientUsecase;
  List<SectionModel>? sectionsDataList;

  int counterChanges = 0;
  refreshScreen() {
    counterChanges += 1;
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) => PatientSectionsState.loaded(
          value.response,
          value.isDelete,
          value.isFinalSubmit,
          '',
          value.isLoading,
          value.reportProgress,
          value.filePath,
          value.isDownloadingReport,
          value.isDownloadedReport,
          counterChanges),
    ));
  }

  getPatientSections(String patientId) async {
    emit(const PatientSectionsState.loading());
    final result = await _getPatientSectionsUsecase.execute(patientId);

    result.fold(
      (l) {
        emit(PatientSectionsState.error(l.message));
      },
      (result) async {
        sectionsDataList = result.data;
        emit(PatientSectionsState.loaded(result, false, false, '', false, 0.0,
            '', false, false, counterChanges));
      },
    );
  }

  /// Refresh sections without a full-screen loading flash.
  Future<void> refreshPatientSections(String patientId) async {
    final result = await _getPatientSectionsUsecase.execute(patientId);
    result.fold(
      (_) {},
      (response) {
        sectionsDataList = response.data;
        emit(state.maybeMap(
          orElse: () => PatientSectionsState.loaded(
            response,
            false,
            false,
            '',
            false,
            0.0,
            '',
            false,
            false,
            counterChanges,
          ),
          loaded: (value) => PatientSectionsState.loaded(
            response,
            value.isDelete,
            value.isFinalSubmit,
            '',
            false,
            value.reportProgress,
            value.filePath,
            value.isDownloadingReport,
            value.isDownloadedReport,
            counterChanges + 1,
          ),
        ));
      },
    );
  }

  /// Optimistically mark a section as completed on the list screen.
  void markSectionCompleted(String sectionId) {
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) {
        final current = value.response.data ?? sectionsDataList ?? const [];
        final updated = current.map((section) {
          if (section.sectionId?.toString() == sectionId) {
            return section.copyWith(sectionStatus: true);
          }
          return section;
        }).toList();
        sectionsDataList = updated;
        return PatientSectionsState.loaded(
          value.response.copyWith(data: updated),
          value.isDelete,
          value.isFinalSubmit,
          '',
          value.isLoading,
          value.reportProgress,
          value.filePath,
          value.isDownloadingReport,
          value.isDownloadedReport,
          counterChanges + 1,
        );
      },
    ));
  }

  deletePatient(String patientId) async {
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) => PatientSectionsState.loaded(value.response, false,
          false, '', true, 0.0, '', false, false, counterChanges),
    ));
    final result = await _deletePatientUsecase.execute(patientId);

    result.fold(
      (l) {
        emit(state.maybeMap(
          orElse: () => state,
          loaded: (value) => PatientSectionsState.loaded(value.response, false,
              false, l.message, false, 0.0, '', false, false, counterChanges),
        ));
      },
      (result) async {
        emit(state.maybeMap(
          orElse: () => state,
          loaded: (value) => PatientSectionsState.loaded(value.response, true,
              false, '', false, 0.0, '', false, false, counterChanges),
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
        loaded: (value) => PatientSectionsState.loaded(value.response, false,
            false, '', true, 0.0, '', false, false, counterChanges),
      ));
      final result = await _finalSubmitUsecase.execute(patientId);

      result.fold(
        (l) {
          emit(state.maybeMap(
            orElse: () => state,
            loaded: (value) => PatientSectionsState.loaded(
                value.response,
                false,
                false,
                l.message,
                false,
                0.0,
                '',
                false,
                false,
                counterChanges),
          ));
        },
        (result) async {
          emit(state.maybeMap(
            orElse: () => state,
            loaded: (value) => PatientSectionsState.loaded(value.response,
                false, true, '', false, 0.0, '', false, false, counterChanges),
          ));
        },
      );
    } else {
      showFinalSubmitIncompleteDialog(
        context: context,
        incompleteSections: sectionsNotCompleted,
        onSubmitAnyway: () async {
          emit(const PatientSectionsState.loading());
          final result = await _finalSubmitUsecase.execute(patientId);

          result.fold(
            (l) {
              emit(PatientSectionsState.error(l.message));
            },
            (result) async {
              emit(PatientSectionsState.loaded(
                  const GetPatientSectionsModelResponse(),
                  false,
                  true,
                  '',
                  false,
                  0.0,
                  '',
                  false,
                  false,
                  counterChanges));
            },
          );
        },
      );
    }
    sectionsNotCompleted = [];
  }

  String reportPdfUrl = '';

  downloadPatientReport(String patientId) async {
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) => PatientSectionsState.loaded(value.response, false,
          false, '', false, 0.0, '', true, false, counterChanges),
    ));
    final result = await _downloadPatientReportUsecase.execute(patientId);

    result.fold(
      (l) {
        emit(state.maybeMap(
          orElse: () => state,
          loaded: (value) => PatientSectionsState.loaded(value.response, false,
              false, l.message, false, 0.0, '', false, false, counterChanges),
        ));
      },
      (result) async {
        reportPdfUrl = result.pdfUrl.toString();

        emit(state.maybeMap(
          orElse: () => state,
          loaded: (value) => PatientSectionsState.loaded(value.response, false,
              false, '', false, 1.0, '', false, true, counterChanges),
        ));
      },
    );
  }

  // Mark patient as bookmarked
  void markPatient(String patientId) async {
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) => PatientSectionsState.loaded(
        value.response.copyWith(isMarked: true),
        value.isDelete,
        value.isFinalSubmit,
        '',
        value.isLoading,
        value.reportProgress,
        value.filePath,
        false,
        false,
        counterChanges,
      ),
    ));
    final result = await _makeMarkPatientUsecase.execute(patientId);
    result.fold(
      (l) {
        // Handle error - could show snackbar or update state
        // emit(state.maybeMap(
        //   orElse: () => state,
        //   loaded: (value) => PatientSectionsState.loaded(
        //     value.response.copyWith(isMarked: true),
        //     value.isDelete,
        //     value.isFinalSubmit,
        //     l.message,
        //     value.isLoading,
        //     value.reportProgress,
        //     value.filePath,
        //     value.isDownloadingReport,
        //     value.isDownloadedReport,
        //     counterChanges,
        //   ),
        // ));
      },
      (r) async {
        // Success - refresh the screen to update bookmark status
        // refreshScreen();
      },
    );
  }

  // Unmark patient (remove bookmark)
  void unmarkPatient(String patientId) async {
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) => PatientSectionsState.loaded(
        value.response.copyWith(isMarked: false),
        value.isDelete,
        value.isFinalSubmit,
        '',
        value.isLoading,
        value.reportProgress,
        value.filePath,
        false,
        false,
        counterChanges,
      ),
    ));
    final result = await _makeUnMarkPatientUsecase.execute(patientId);
    result.fold(
      (l) {
        // Handle error - could show snackbar or update state
        // emit(state.maybeMap(
        //   orElse: () => state,
        //   loaded: (value) => PatientSectionsState.loaded(
        //     value.response.copyWith(isMarked: false),
        //     value.isDelete,
        //     value.isFinalSubmit,
        //     l.message,
        //     value.isLoading,
        //     value.reportProgress,
        //     value.filePath,
        //     value.isDownloadingReport,
        //     value.isDownloadedReport,
        //     counterChanges,
        //   ),
        // ));
      },
      (r) async {
        // Success - refresh the screen to update bookmark status
        // refreshScreen();
      },
    );
  }
}
