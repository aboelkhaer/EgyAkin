import 'dart:io';

class AiFormUploadState {
  final List<File> selectedImages;
  final List<File> selectedFiles;
  final bool isSubmitting;
  final bool isPickingImages;
  final bool isPickingFiles;
  final String loadingStep;
  final String errorMessage;
  final Map<String, dynamic>? answersMap;

  const AiFormUploadState({
    this.selectedImages = const [],
    this.selectedFiles = const [],
    this.isSubmitting = false,
    this.isPickingImages = false,
    this.isPickingFiles = false,
    this.loadingStep = '',
    this.errorMessage = '',
    this.answersMap,
  });

  bool get hasSelection => selectedImages.isNotEmpty || selectedFiles.isNotEmpty;

  AiFormUploadState copyWith({
    List<File>? selectedImages,
    List<File>? selectedFiles,
    bool? isSubmitting,
    bool? isPickingImages,
    bool? isPickingFiles,
    String? loadingStep,
    String? errorMessage,
    Map<String, dynamic>? answersMap,
    bool clearAnswers = false,
  }) {
    return AiFormUploadState(
      selectedImages: selectedImages ?? this.selectedImages,
      selectedFiles: selectedFiles ?? this.selectedFiles,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isPickingImages: isPickingImages ?? this.isPickingImages,
      isPickingFiles: isPickingFiles ?? this.isPickingFiles,
      loadingStep: loadingStep ?? this.loadingStep,
      errorMessage: errorMessage ?? this.errorMessage,
      answersMap: clearAnswers ? null : (answersMap ?? this.answersMap),
    );
  }
}
