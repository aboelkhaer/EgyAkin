import 'dart:io';

import 'package:dio/dio.dart';
import 'package:egy_akin/app/constants/app_strings.dart';
import 'package:egy_akin/app/services/localization_service.dart';
import 'package:egy_akin/app/utilities/custom_snack_bar.dart';
import 'package:egy_akin/features/community/data/models/get_posts_community_model_response.dart';
import 'package:egy_akin/features/create_post_in_community/data/models/poll_model.dart';
import 'package:egy_akin/features/create_post_in_community/domain/usecases/creat_post_with_text_in_community_usecase.dart';
import 'package:egy_akin/features/create_post_in_community/domain/usecases/create_post_with_image_in_community_usecase.dart';
import 'package:egy_akin/features/create_post_in_community/domain/usecases/edit_post_with_image_in_community_usecase.dart';
import 'package:egy_akin/features/create_post_in_community/domain/usecases/edit_post_with_text_in_community_usecase.dart';
import 'package:egy_akin/features/create_post_in_community/presentation/cubit/create_post_in_community_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'package:image/image.dart' as img;

enum PostImageUploadMode {
  /// Compresses images for quicker upload.
  fast,

  /// Keeps original resolution/quality (slower upload).
  fullQuality,
}

class CreatePostInCommunityCubit extends Cubit<CreatePostInCommunityState> {
  /// Used only for [PostImageUploadMode.fast].
  static const int _uploadMaxLongEdge = 1600;
  static const int _uploadJpegQuality = 82;
  static const int _maxUploadBytes = 1800 * 1024; // ~1.8 MB per image

  CreatePostInCommunityCubit(
    this._createPostInCommunityUsecase,
    this._createPostWithTextInCommunityUsecase,
    this._editPostWithImageInCommunityUsecase,
    this._editPostWithTextInCommunityUsecase,
  ) : super(const CreatePostInCommunityState.loaded(
            0, 0, false, false, false, ''));
  static CreatePostInCommunityCubit get(context) => BlocProvider.of(context);
  final CreatePostWithImageInCommunityUsecase _createPostInCommunityUsecase;
  final CreatePostWithTextInCommunityUsecase
      _createPostWithTextInCommunityUsecase;
  final EditPostWithImageInCommunityUsecase
      _editPostWithImageInCommunityUsecase;
  final EditPostWithTextInCommunityUsecase _editPostWithTextInCommunityUsecase;

  PostCommunityModel? editableFeed;
  String postContent = '';
  List<File> imagesPicked = [];
  PostImageUploadMode uploadMode = PostImageUploadMode.fast;

  void setUploadMode(PostImageUploadMode mode) {
    if (uploadMode == mode) return;
    uploadMode = mode;
    emit(
      state.maybeMap(
        orElse: () => state,
        loaded: (value) => CreatePostInCommunityState.loaded(
          value.postLength,
          value.changeCounter + 1,
          value.isImagePick,
          value.isUploadPostLoading,
          value.isUploadPostLoaded,
          '',
        ),
      ),
    );
  }

  changePostLength(int postLengthValue) {
    emit(
      state.maybeMap(
        orElse: () => state,
        loaded: (value) => CreatePostInCommunityState.loaded(
          postLengthValue,
          value.changeCounter,
          false,
          false,
          false,
          '',
        ),
      ),
    );
  }

  void emitLoadedStateForEditPost(PostCommunityModel feed) {
    editableFeed = feed.copyWith(
      content: feed.content ?? '', // Ensure content is not null
      existingMediaPath: feed.mediaPath,
    );

    emit(
      CreatePostInCommunityState.loaded(
        editableFeed!.content!.length,
        changeCounter,
        false,
        false,
        false,
        '',
      ),
    );
  }

  editFeedContentForEditableFeed(String? editableFeedContent) {
    editableFeed = editableFeed!.copyWith(content: editableFeedContent);
  }

  editFeedPollForEditableFeed(PollModelResponse? editableFeedPoll) {
    editableFeed = editableFeed!.copyWith(poll: editableFeedPoll);
  }

  int changeCounter = 0;
  void removeImage(int index) {
    if (index >= 0 && index < imagesPicked.length) {
      imagesPicked.removeAt(index); // Remove the image at the specified index
      emit(
        state.maybeMap(
          orElse: () => state,
          loaded: (value) => CreatePostInCommunityState.loaded(
            postContent.length,
            value.changeCounter +
                1, // Increment changeCounter to trigger UI update
            false,
            false,
            false,
            '',
          ),
        ),
      );
    }
  }

  Future<void> pickImageAndShowIt(bool isCamera, BuildContext context) async {
    try {
      // Show loading immediately so the tap feels responsive.
      emit(loadingState());
      await Future<void>.delayed(const Duration(milliseconds: 80));

      final source = isCamera ? ImageSource.camera : ImageSource.gallery;
      final pickedFiles = await _pickImages(source, isCamera);

      if (pickedFiles.isEmpty) {
        emit(loadedState());
        return;
      }

      imagesPicked.addAll(pickedFiles.map((x) => File(x.path)));
      emit(loadedState());
    } catch (e) {
      debugPrint('Error picking images: $e');
      emit(loadedState(
          errorMessage: LocalizationService.instance
              .translate(AppStrings.failedToPickImages)));
    }
  }

  Future<List<XFile>> _pickImages(ImageSource source, bool isCamera) async {
    final picker = ImagePicker();

    if (isCamera) {
      final image = await picker.pickImage(
        source: source,
        imageQuality: 100,
        requestFullMetadata: false,
      );
      return image != null ? [image] : [];
    }

    return picker.pickMultiImage(requestFullMetadata: false);
  }

  CreatePostInCommunityState loadingState() {
    return state.maybeMap(
      orElse: () => state,
      loaded: (value) => CreatePostInCommunityState.loaded(
        postContent.length,
        value.changeCounter + 1,
        true, // isImagePick
        false,
        false,
        '',
      ),
    );
  }

  CreatePostInCommunityState loadedState({String? errorMessage}) {
    return state.maybeMap(
      orElse: () => state,
      loaded: (value) => CreatePostInCommunityState.loaded(
        postContent.length,
        value.changeCounter + 1,
        false,
        false,
        false,
        errorMessage ?? '',
      ),
    );
  }

  /// Prepares files based on [uploadMode] right before upload.
  Future<List<File>> _filesForUpload() async {
    if (imagesPicked.isEmpty) return const [];

    if (uploadMode == PostImageUploadMode.fast) {
      return Future.wait(imagesPicked.map(_optimizeImage));
    }

    return Future.wait(imagesPicked.map(_prepareFullQualityFile));
  }

  Future<File> _prepareFullQualityFile(File imageFile) async {
    final ext = imageFile.path.split('.').last.toLowerCase();
    const passthrough = {'jpg', 'jpeg', 'png', 'webp', 'gif'};
    if (passthrough.contains(ext)) {
      return imageFile;
    }

    final tempDir = await getTemporaryDirectory();
    final outPath =
        '${tempDir.path}/full_q_${DateTime.now().microsecondsSinceEpoch}.jpg';
    return compute(_convertToJpegFullQuality, {
      'imageFile': imageFile,
      'outPath': outPath,
    });
  }

  static File _convertToJpegFullQuality(Map<String, dynamic> params) {
    final imageFile = params['imageFile'] as File;
    final outPath = params['outPath'] as String;
    final decoded = img.decodeImage(imageFile.readAsBytesSync());
    if (decoded == null) {
      throw StateError('Unable to decode image: ${imageFile.path}');
    }
    final bytes = img.encodeJpg(decoded, quality: 100);
    return File(outPath)..writeAsBytesSync(bytes);
  }

  Future<File> _optimizeImage(File imageFile) async {
    final tempDir = await getTemporaryDirectory();
    final uniqueSuffix = DateTime.now().microsecondsSinceEpoch.toString();
    final optimizedImagePath =
        '${tempDir.path}/optimized_image_$uniqueSuffix.jpg';

    return compute(
      _processImage,
      {
        'imageFile': imageFile,
        'optimizedImagePath': optimizedImagePath,
        'maxLongEdge': _uploadMaxLongEdge,
        'jpegQuality': _uploadJpegQuality,
        'maxBytes': _maxUploadBytes,
      },
    );
  }

  static File _processImage(Map<String, dynamic> params) {
    final imageFile = params['imageFile'] as File;
    final optimizedImagePath = params['optimizedImagePath'] as String;
    final maxLongEdge = params['maxLongEdge'] as int;
    final jpegQuality = params['jpegQuality'] as int;
    final maxBytes = params['maxBytes'] as int;

    final image = img.decodeImage(imageFile.readAsBytesSync())!;

    final longEdge = image.width > image.height ? image.width : image.height;
    img.Image processed = image;

    if (longEdge > maxLongEdge) {
      final aspectRatio = image.width / image.height;
      late final int newWidth;
      late final int newHeight;

      if (image.width >= image.height) {
        newWidth = maxLongEdge;
        newHeight = (maxLongEdge / aspectRatio).round();
      } else {
        newHeight = maxLongEdge;
        newWidth = (maxLongEdge * aspectRatio).round();
      }

      processed = img.copyResize(
        image,
        width: newWidth,
        height: newHeight,
        interpolation: img.Interpolation.linear,
      );
    }

    var quality = jpegQuality;
    var bytes = img.encodeJpg(processed, quality: quality);

    while (bytes.length > maxBytes && quality > 70) {
      quality -= 5;
      bytes = img.encodeJpg(processed, quality: quality);
    }

    return File(optimizedImagePath)..writeAsBytesSync(bytes);
  }

  submitPost(
    context,
    String? groupId,
    PollModel? pollModel,
  ) async {
    if (editableFeed == null) {
      // For new posts
      if (imagesPicked.isEmpty && postContent.trim() == '') {
        customSnackBar(
          context: context,
          message: LocalizationService.instance
              .translate(AppStrings.writeSomethingToPublish),
        );
        return;
      }
      if (imagesPicked.isNotEmpty) {
        createPostWithImageInCommunity(groupId); // Handle multiple images
        return;
      }
      if (imagesPicked.isEmpty && postContent != '') {
        createPostWithTextInCommunity(groupId, pollModel ?? const PollModel());
        return;
      }
    } else {
      // For editing posts
      if (imagesPicked.isEmpty &&
          editableFeed!.content!.trim() == '' &&
          editableFeed!.mediaPath!.isEmpty) {
        customSnackBar(
          context: context,
          message: LocalizationService.instance
              .translate(AppStrings.writeSomethingToPublish),
        );
        return;
      }
      if (imagesPicked.isNotEmpty ||
          editableFeed!.existingMediaPath!.isNotEmpty) {
        editPostWithImageInCommunity(
            groupId, context); // Handle multiple images
        return;
      }
      // if (pollModel != null) {
      //   createPostWithTextInCommunity(groupId, pollModel);
      // }
      if (imagesPicked.isEmpty &&
          editableFeed!.content != null &&
          editableFeed!.content != '' &&
          editableFeed!.mediaPath!.isNotEmpty) {
        editPostWithTextInCommunity(
            groupId, null, pollModel ?? const PollModel());
        return;
      }
      if (imagesPicked.isEmpty &&
          editableFeed!.content != null &&
          editableFeed!.content != '' &&
          editableFeed!.mediaPath!.isEmpty) {
        editPostWithTextInCommunity(groupId, pollModel == null ? 'text' : null,
            pollModel ?? const PollModel());
        return;
      }
    }
  }

  void removeMediaPathInEditableFeed(int index) {
    if (editableFeed != null && editableFeed!.mediaPath!.isNotEmpty) {
      // Create a modifiable copy of the list
      final updatedMediaPaths = List<String>.from(editableFeed!.mediaPath!);
      updatedMediaPaths.removeAt(index);

      // Create a new editableFeed with updated mediaPath
      editableFeed = editableFeed!.copyWith(
        mediaPath: updatedMediaPaths,
        existingMediaPath: updatedMediaPaths,
      );
      // existingMediaPaths = updatedMediaPaths;

      emit(
        state.maybeMap(
          orElse: () => state,
          loaded: (value) => CreatePostInCommunityState.loaded(
            value.postLength,
            value.changeCounter + 1,
            false,
            false,
            false,
            '',
          ),
        ),
      );
    }
  }

  Future<List<MultipartFile>> convertFilesToMultipart(List<File> files) async {
    return Future.wait(
      files.map((file) async {
        return await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
        );
      }),
    );
  }

  Future<void> createPostWithImageInCommunity(String? groupId) async {
    emit(
      state.maybeMap(
        orElse: () => state,
        loaded: (value) => CreatePostInCommunityState.loaded(
          value.postLength,
          value.changeCounter,
          false,
          true,
          false,
          '',
        ),
      ),
    );

    try {
      final files = await _filesForUpload();
      final multipartFiles = await convertFilesToMultipart(files);
      final result = await _createPostInCommunityUsecase.execute(
        CreatePostWithImageInCommunityUsecaseInput(
          postContent: postContent.trim(),
          images: multipartFiles,
          mediaType: 'image',
          visibility: 'Public',
          groupId: groupId,
        ),
      );

      result.fold(
        (l) {
          emit(
            state.maybeMap(
              orElse: () => state,
              loaded: (value) => CreatePostInCommunityState.loaded(
                value.postLength,
                value.changeCounter,
                false,
                false,
                false,
                l.message,
              ),
            ),
          );
        },
        (response) {
          emit(
            state.maybeMap(
              orElse: () => state,
              loaded: (value) => CreatePostInCommunityState.loaded(
                value.postLength,
                value.changeCounter,
                false,
                false,
                true,
                '',
              ),
            ),
          );
          debugPrint('Post Success: ${response.message}');
          imagesPicked.clear();
        },
      );
    } catch (e) {
      debugPrint('createPostWithImageInCommunity error: $e');
      emit(
        state.maybeMap(
          orElse: () => state,
          loaded: (value) => CreatePostInCommunityState.loaded(
            value.postLength,
            value.changeCounter,
            false,
            false,
            false,
            LocalizationService.instance
                .translate(AppStrings.somethingWentWrong),
          ),
        ),
      );
    }
  }

  Future<void> editPostWithImageInCommunity(String? groupId, context) async {
    if (editableFeed == null) {
      emit(
        state.maybeMap(
          orElse: () => state,
          loaded: (value) => CreatePostInCommunityState.loaded(
            value.postLength,
            value.changeCounter,
            false,
            false,
            false,
            LocalizationService.instance
                .translate(AppStrings.noPostDataAvailableForEditing),
          ),
        ),
      );
      return;
    }

    emit(
      state.maybeMap(
        orElse: () => state,
        loaded: (value) => CreatePostInCommunityState.loaded(
          value.postLength,
          value.changeCounter,
          false,
          true,
          false,
          '',
        ),
      ),
    );

    try {
      final files = await _filesForUpload();
      final multipartFiles = await convertFilesToMultipart(files);

      final result = await _editPostWithImageInCommunityUsecase.execute(
        EditPostWithImageInCommunityUsecaseInput(
          postId: editableFeed!.id.toString(),
          postContent: editableFeed!.content ?? '',
          images: multipartFiles,
          mediaType: 'image',
          visibility: 'Public',
          groupId: groupId,
          existingMediaPath: editableFeed!.existingMediaPath!,
        ),
      );

      result.fold(
        (failure) {
          emit(
            state.maybeMap(
              orElse: () => state,
              loaded: (value) => CreatePostInCommunityState.loaded(
                value.postLength,
                value.changeCounter,
                false,
                false,
                false,
                failure.message,
              ),
            ),
          );
        },
        (success) {
          emit(
            state.maybeMap(
              orElse: () => state,
              loaded: (value) => CreatePostInCommunityState.loaded(
                value.postLength,
                value.changeCounter,
                false,
                false,
                true,
                '',
              ),
            ),
          );
          imagesPicked.clear();
        },
      );
    } catch (e) {
      emit(
        state.maybeMap(
          orElse: () => state,
          loaded: (value) => CreatePostInCommunityState.loaded(
            value.postLength,
            value.changeCounter,
            false,
            false,
            false,
            'An error occurred: $e',
          ),
        ),
      );
    }
  }

  editPostWithTextInCommunity(
    String? groupId,
    String? mediaType,
    PollModel? pollModel,
  ) async {
    emit(
      state.maybeMap(
        orElse: () => state,
        loaded: (value) => CreatePostInCommunityState.loaded(
          value.postLength,
          value.changeCounter,
          false,
          true,
          false,
          '',
        ),
      ),
    );

    final result = await _editPostWithTextInCommunityUsecase.execute(
      EditPostWithTextInCommunityUsecaseInput(
        postId: editableFeed!.id.toString(),
        postContent: editableFeed!.content!.trim(),
        mediaType: mediaType,
        visibility: 'Public',
        groupId: groupId,
        pollModel: pollModel,
      ),
    );
    result.fold(
      (l) {
        emit(
          state.maybeMap(
            orElse: () => state,
            loaded: (value) => CreatePostInCommunityState.loaded(
              value.postLength,
              value.changeCounter,
              false,
              false,
              false,
              l.message,
            ),
          ),
        );
      },
      (response) async {
        emit(
          state.maybeMap(
            orElse: () => state,
            loaded: (value) => CreatePostInCommunityState.loaded(
              value.postLength,
              value.changeCounter,
              false,
              false,
              true,
              '',
            ),
          ),
        );
        debugPrint(response.message);
      },
    );
  }

  createPostWithTextInCommunity(
    String? groupId,
    PollModel? pollModel,
  ) async {
    emit(
      state.maybeMap(
        orElse: () => state,
        loaded: (value) => CreatePostInCommunityState.loaded(
          value.postLength,
          value.changeCounter,
          false,
          true,
          false,
          '',
        ),
      ),
    );
    final result = await _createPostWithTextInCommunityUsecase.execute(
      CreatePostWithTextInCommunityUsecaseInput(
        postContent: postContent,
        mediaType: null,
        visibility: 'Public',
        groupId: groupId,
        pollModel: pollModel,
      ),
    );
    result.fold(
      (l) {
        emit(
          state.maybeMap(
            orElse: () => state,
            loaded: (value) => CreatePostInCommunityState.loaded(
              value.postLength,
              value.changeCounter,
              false,
              false,
              false,
              l.message,
            ),
          ),
        );
      },
      (response) async {
        emit(
          state.maybeMap(
            orElse: () => state,
            loaded: (value) => CreatePostInCommunityState.loaded(
              value.postLength,
              value.changeCounter,
              false,
              false,
              true,
              '',
            ),
          ),
        );
        debugPrint(response.message);
      },
    );
  }
}
