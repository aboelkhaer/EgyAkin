import 'dart:convert';
import 'dart:io';

import '../../../../exports.dart';
import '../../domain/usecases/process_section_record_usecase.dart';
import 'record_state.dart';

class RecordCubit extends Cubit<RecordState> {
  RecordCubit(this._processSectionRecordUsecase) : super(const RecordState());

  final ProcessSectionRecordUsecase _processSectionRecordUsecase;

  Future<void> processSection({
    required String sectionId,
    required File audioFile,
  }) async {
    emit(state.copyWith(
      analysisPhase: RecordAnalysisPhase.uploading,
      analysisProgress: 0.25,
      analysisStepLabel: 'Uploading audio...',
      clearErrorMessage: true,
      clearAnswersMap: true,
    ));

    unawaited(_maybeAdvanceToAnalyzingPhase());

    final result = await _processSectionRecordUsecase.execute(
      ProcessSectionRecordParams(
        sectionId: sectionId,
        audioFile: audioFile,
      ),
    );

    result.fold(
      (failure) {
        emit(state.copyWith(
          analysisPhase: RecordAnalysisPhase.idle,
          analysisProgress: 0,
          clearAnalysisStepLabel: true,
          errorMessage: failure.message,
        ));
      },
      (ProcessSectionModelResponse response) {
        final answers = _answersFromProcessSectionResponse(response);
        if (answers == null) {
          emit(state.copyWith(
            analysisPhase: RecordAnalysisPhase.idle,
            analysisProgress: 0,
            clearAnalysisStepLabel: true,
            errorMessage: 'Invalid response format',
          ));
          return;
        }

        emit(state.copyWith(
          analysisPhase: RecordAnalysisPhase.fillingForm,
          analysisProgress: 0,
          analysisStepLabel: 'Filling form with audio data...',
          answersMap: answers,
        ));
      },
    );
  }

  Future<void> _maybeAdvanceToAnalyzingPhase() async {
    await Future<void>.delayed(const Duration(milliseconds: 550));
    if (isClosed) return;
    if (state.analysisPhase != RecordAnalysisPhase.uploading) return;
    emit(state.copyWith(
      analysisPhase: RecordAnalysisPhase.analyzing,
      analysisProgress: 0.65,
      analysisStepLabel: 'Analyzing audio with AI...',
    ));
  }

  void clearResult() {
    emit(const RecordState());
  }

  void resetAnalysis() {
    emit(state.copyWith(
      analysisPhase: RecordAnalysisPhase.idle,
      analysisProgress: 0,
      clearAnalysisStepLabel: true,
      clearAnswersMap: true,
      clearErrorMessage: true,
    ));
  }

  void clearErrorMessageOnly() {
    emit(state.copyWith(clearErrorMessage: true));
  }

  /// Builds a map for [applyVoiceAnswers]: prefers `data` questions with
  /// answers, then JSON in top-level [extracted_text], else raw `extracted_text`.
  Map<String, dynamic>? _answersFromProcessSectionResponse(
    ProcessSectionModelResponse response,
  ) {
    final questions = response.data;
    if (questions != null && questions.isNotEmpty) {
      final map = <String, dynamic>{};
      for (final q in questions) {
        if (q.answer == null) continue;
        final id = q.id;
        if (id != null) {
          map[id.toString()] = q.answer;
        }
        final qText = q.question?.trim().toLowerCase();
        if (qText != null && qText.isNotEmpty) {
          map[qText] = q.answer;
        }
      }
      if (map.isNotEmpty) return map;
    }

    final text = response.resolvedExtractedText;
    if (text == null || text.isEmpty) return null;

    try {
      final decoded = jsonDecode(text);
      if (decoded is Map<String, dynamic>) {
        return decoded;
      }
    } catch (_) {
      // Not JSON; fall through to raw string map.
    }

    return {'extracted_text': text};
  }
}
