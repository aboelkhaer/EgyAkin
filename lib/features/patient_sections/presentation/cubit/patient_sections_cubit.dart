import 'package:dio/dio.dart';

import '../../../../exports.dart';

class PatientSectionsCubit extends Cubit<PatientSectionsState> {
  PatientSectionsCubit(
      this._getPatientSectionsUsecase,
      this._deletePatientUsecase,
      this._finalSubmitUsecase,
      this._downloadPatientReportUsecase,
      this._dio)
      : super(const PatientSectionsState.initial());
  static PatientSectionsCubit get(context) => BlocProvider.of(context);
  final GetPatientSectionsUsecase _getPatientSectionsUsecase;
  final DeletePatientUsecase _deletePatientUsecase;
  final FinalSubmitUsecase _finalSubmitUsecase;
  final DownloadPatientReportUsecase _downloadPatientReportUsecase;
  List<SectionModel>? sectionsDataList;
  final Dio _dio;

  getPatientSections(String patientId) async {
    emit(const PatientSectionsState.loading());
    final result = await _getPatientSectionsUsecase.execute(patientId);

    result.fold(
      (l) {
        emit(PatientSectionsState.error(l.message));
      },
      (result) async {
        sectionsDataList = result.data;
        emit(PatientSectionsState.loaded(
            result, false, false, '', false, 0.0, '', false, false));
      },
    );
  }

  deletePatient(String patientId) async {
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) => PatientSectionsState.loaded(
          value.response, false, false, '', true, 0.0, '', false, false),
    ));
    final result = await _deletePatientUsecase.execute(patientId);

    result.fold(
      (l) {
        emit(state.maybeMap(
          orElse: () => state,
          loaded: (value) => PatientSectionsState.loaded(value.response, false,
              false, l.message, false, 0.0, '', false, false),
        ));
      },
      (result) async {
        emit(state.maybeMap(
          orElse: () => state,
          loaded: (value) => PatientSectionsState.loaded(
              value.response, true, false, '', false, 0.0, '', false, false),
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
        loaded: (value) => PatientSectionsState.loaded(
            value.response, false, false, '', true, 0.0, '', false, false),
      ));
      final result = await _finalSubmitUsecase.execute(patientId);

      result.fold(
        (l) {
          emit(state.maybeMap(
            orElse: () => state,
            loaded: (value) => PatientSectionsState.loaded(value.response,
                false, false, l.message, false, 0.0, '', false, false),
          ));
        },
        (result) async {
          emit(state.maybeMap(
            orElse: () => state,
            loaded: (value) => PatientSectionsState.loaded(
                value.response, false, true, '', false, 0.0, '', false, false),
          ));
        },
      );
    } else {
      showCustomDialog(
          context: context,
          title: context.tr(AppStrings.youLeftSomeSectionsInBinding),
          // description:
          //     'You left sections not completed, you sure want to continue?',
          description: sectionsNotCompleted,
          noColoredButtonOnTap: () => Navigator.of(context).pop(),
          coloredButtonText: context.tr(AppStrings.submit),
          noColoredButtonText: context.tr(AppStrings.cancel),

          coloredButtonOnTap: () async {
            Navigator.of(context).pop();
            emit(const PatientSectionsState.loading());
            final result = await _finalSubmitUsecase.execute(patientId);

            result.fold(
              (l) {
                emit(PatientSectionsState.error(l.message));
              },
              (result) async {
                emit(const PatientSectionsState.loaded(
                    GetPatientSectionsModelResponse(),
                    false,
                    true,
                    '',
                    false,
                    0.0,
                    '',
                    false,
                    false));
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
      loaded: (value) => PatientSectionsState.loaded(
          value.response, false, false, '', false, 0.0, '', true, false),
    ));
    final result = await _downloadPatientReportUsecase.execute(patientId);

    result.fold(
      (l) {
        emit(state.maybeMap(
          orElse: () => state,
          loaded: (value) => PatientSectionsState.loaded(value.response, false,
              false, l.message, false, 0.0, '', false, false),
        ));
      },
      (result) async {
        reportPdfUrl = result.pdfUrl.toString();

        emit(state.maybeMap(
          orElse: () => state,
          loaded: (value) => PatientSectionsState.loaded(
              value.response, false, false, '', false, 1.0, '', false, true),
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
}
