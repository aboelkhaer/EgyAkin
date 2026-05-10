import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';

import '../../../../exports.dart';
import '../../domain/usecases/upload_ai_form_files_usecase.dart';
import 'ai_form_upload_state.dart';

class AiFormUploadCubit extends Cubit<AiFormUploadState> {
  AiFormUploadCubit(this._uploadAiFormFilesUsecase)
      : super(const AiFormUploadState());

  final UploadAiFormFilesUsecase _uploadAiFormFilesUsecase;

  Future<void> pickImages() async {
    emit(state.copyWith(isPickingImages: true, errorMessage: ''));
    final images = await ImagePicker().pickMultiImage(imageQuality: 85);
    if (images.isEmpty) {
      emit(state.copyWith(isPickingImages: false));
      return;
    }
    final resizedImages = await Future.wait(
      images.map((e) => _resizeImageTo1024(File(e.path))),
    );
    emit(state.copyWith(
      selectedImages: resizedImages,
      isPickingImages: false,
      errorMessage: '',
    ));
  }

  Future<void> pickFiles() async {
    emit(state.copyWith(isPickingFiles: true, errorMessage: ''));
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result == null || result.files.isEmpty) {
      emit(state.copyWith(isPickingFiles: false));
      return;
    }
    final files = result.files
        .where((e) => e.path != null)
        .map((e) => File(e.path!))
        .toList();
    emit(state.copyWith(
      selectedFiles: files,
      isPickingFiles: false,
      errorMessage: '',
    ));
  }

  void clearImageAt(int index) {
    final updated = List<File>.from(state.selectedImages)..removeAt(index);
    emit(state.copyWith(selectedImages: updated));
  }

  void clearFileAt(int index) {
    final updated = List<File>.from(state.selectedFiles)..removeAt(index);
    emit(state.copyWith(selectedFiles: updated));
  }

  Future<void> submit(String sectionId) async {
    if (!state.hasSelection) {
      emit(state.copyWith(errorMessage: 'Please add at least one image or file.'));
      return;
    }

    emit(state.copyWith(
      isSubmitting: true,
      loadingStep: 'Uploading files...',
      errorMessage: '',
      clearAnswers: true,
    ));

    await Future<void>.delayed(const Duration(milliseconds: 450));
    emit(state.copyWith(loadingStep: 'Analyzing data with AI...'));

    final result = await _uploadAiFormFilesUsecase.execute(
      UploadAiFormFilesUsecaseInput(
        sectionId: sectionId,
        imageFiles: state.selectedImages,
        attachmentFiles: state.selectedFiles,
      ),
    );

    result.fold(
      (failure) {
        emit(state.copyWith(
          isSubmitting: false,
          loadingStep: '',
          errorMessage: failure.message,
        ));
      },
      (response) {
        emit(state.copyWith(loadingStep: 'Filling form with results...'));
        final answers = response.toAnswersMap();
        if (answers == null) {
          emit(state.copyWith(
            isSubmitting: false,
            loadingStep: '',
            errorMessage: 'Invalid response format',
          ));
          return;
        }
        emit(state.copyWith(
          isSubmitting: false,
          loadingStep: '',
          answersMap: answers,
        ));
      },
    );
  }

  Future<File> _resizeImageTo1024(File originalFile) async {
    try {
      final resizedPath = await compute<String, String?>(
        _resizeImageFilePathTo1024,
        originalFile.path,
      );
      if (resizedPath == null || resizedPath.isEmpty) return originalFile;
      return File(resizedPath);
    } catch (_) {
      return originalFile;
    }
  }

}

String? _resizeImageFilePathTo1024(String sourcePath) {
  try {
    final originalFile = File(sourcePath);
    final bytes = originalFile.readAsBytesSync();
    final decoded = img.decodeImage(bytes);
    if (decoded == null) return null;

    final resized = img.copyResizeCropSquare(decoded, size: 1024);
    final jpgBytes = img.encodeJpg(resized, quality: 90);
    final fileName = sourcePath.split(Platform.pathSeparator).last;
    final targetPath =
        '${Directory.systemTemp.path}/ai_1024_${DateTime.now().microsecondsSinceEpoch}_$fileName.jpg';
    final resizedFile = File(targetPath);
    resizedFile.writeAsBytesSync(jpgBytes, flush: true);
    return targetPath;
  } catch (_) {
    return null;
  }
}
