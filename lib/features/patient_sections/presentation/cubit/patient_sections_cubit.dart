import 'package:egy_akin/features/patient_sections/domain/usecases/make_mark_patient_usecase.dart';
import 'package:egy_akin/features/patient_sections/domain/usecases/make_unmark_patient_usecase.dart';

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
          value.message,
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
      showCustomDialog(
          context: context,
          title: LocalizationService.instance
              .translate(AppStrings.youLeftSomeSectionsInBinding),
          // description:
          //     'You left sections not completed, you sure want to continue?',
          description: sectionsNotCompleted,
          noColoredButtonOnTap: () => Navigator.of(context).pop(),
          coloredButtonText:
              LocalizationService.instance.translate(AppStrings.submit),
          noColoredButtonText:
              LocalizationService.instance.translate(AppStrings.cancel),
          coloredButtonOnTap: () async {
            Navigator.of(context).pop();
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
          });
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

        // try {
        //   final directory = await getApplicationDocumentsDirectory();
        //   final filePath = '${directory.path}/report_$patientId.pdf';
        //   final file = File(filePath);
        //   await _dio.download(
        //     result.pdfUrl.toString(),
        //     filePath,
        //     onReceiveProgress: (received, total) {
        //       if (total != -1) {
        //         final progress = received / total;
        //         emit(state.maybeMap(
        //           orElse: () => state,
        //           loaded: (value) => PatientSectionsState.loaded(
        //             value.response,
        //             false,
        //             false,
        //             '',
        //             true,
        //             progress,
        //             '',
        //             true,
        //             false,
        //           ),
        //         ));
        //       }
        //     },
        //   );

        //   emit(state.maybeMap(
        //     orElse: () => state,
        //     loaded: (value) => PatientSectionsState.loaded(value.response,
        //         false, false, '', false, 1.0, filePath, false, true),
        //   ));
        // } catch (error) {
        //   emit(state.maybeMap(
        //     orElse: () => state,
        //     loaded: (value) => PatientSectionsState.loaded(
        //       value.response,
        //       false,
        //       false,
        //       error.toString(),
        //       false,
        //       0.0,
        //       '',
        //       false,
        //       false,
        //     ),
        //   ));
        // }
      },
    );
  }

  // Mark patient as bookmarked
  void markPatient(String patientId) async {
    final result = await _makeMarkPatientUsecase.execute(patientId);
    result.fold(
      (l) {
        // Handle error - could show snackbar or update state
        emit(state.maybeMap(
          orElse: () => state,
          loaded: (value) => PatientSectionsState.loaded(
            value.response,
            value.isDelete,
            value.isFinalSubmit,
            l.message,
            value.isLoading,
            value.reportProgress,
            value.filePath,
            value.isDownloadingReport,
            value.isDownloadedReport,
            counterChanges,
          ),
        ));
      },
      (r) async {
        // Success - refresh the screen to update bookmark status
        refreshScreen();
      },
    );
  }

  // Unmark patient (remove bookmark)
  void unmarkPatient(String patientId) async {
    final result = await _makeUnMarkPatientUsecase.execute(patientId);
    result.fold(
      (l) {
        // Handle error - could show snackbar or update state
        emit(state.maybeMap(
          orElse: () => state,
          loaded: (value) => PatientSectionsState.loaded(
            value.response,
            value.isDelete,
            value.isFinalSubmit,
            l.message,
            value.isLoading,
            value.reportProgress,
            value.filePath,
            value.isDownloadingReport,
            value.isDownloadedReport,
            counterChanges,
          ),
        ));
      },
      (r) async {
        // Success - refresh the screen to update bookmark status
        refreshScreen();
      },
    );
  }
}
