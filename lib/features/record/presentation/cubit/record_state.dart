enum RecordAnalysisPhase {
  idle,
  uploading,
  analyzing,
  fillingForm,
}

class RecordState {
  final RecordAnalysisPhase analysisPhase;
  final double analysisProgress;
  final String? analysisStepLabel;
  final Map<String, dynamic>? answersMap;
  final String? errorMessage;

  const RecordState({
    this.analysisPhase = RecordAnalysisPhase.idle,
    this.analysisProgress = 0,
    this.analysisStepLabel,
    this.answersMap,
    this.errorMessage,
  });

  bool get isAnalysisBusy =>
      analysisPhase == RecordAnalysisPhase.uploading ||
      analysisPhase == RecordAnalysisPhase.analyzing ||
      analysisPhase == RecordAnalysisPhase.fillingForm;

  RecordState copyWith({
    RecordAnalysisPhase? analysisPhase,
    double? analysisProgress,
    String? analysisStepLabel,
    bool clearAnalysisStepLabel = false,
    Map<String, dynamic>? answersMap,
    bool clearAnswersMap = false,
    String? errorMessage,
    bool clearErrorMessage = false,
  }) {
    return RecordState(
      analysisPhase: analysisPhase ?? this.analysisPhase,
      analysisProgress: analysisProgress ?? this.analysisProgress,
      analysisStepLabel: clearAnalysisStepLabel
          ? null
          : (analysisStepLabel ?? this.analysisStepLabel),
      answersMap: clearAnswersMap ? null : (answersMap ?? this.answersMap),
      errorMessage:
          clearErrorMessage ? null : (errorMessage ?? this.errorMessage),
    );
  }
}
