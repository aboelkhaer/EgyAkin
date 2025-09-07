import 'dart:developer';
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

class CreatePostInCommunityCubit extends Cubit<CreatePostInCommunityState> {
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
  // PollModel? poll;
  String postContent = '';
  List<File> imagesPicked = [];

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
      emit(loadingState()); // Show loading state

      final source = isCamera ? ImageSource.camera : ImageSource.gallery;
      final pickedFiles = await _pickImages(source, isCamera);

      if (pickedFiles.isEmpty) {
        emit(loadedState()); // Return to loaded state if no images selected
        return;
      }

      // Process images
      for (final pickedFile in pickedFiles) {
        final optimizedFile = await _optimizeImage(File(pickedFile.path), 80);
        imagesPicked.add(optimizedFile);
      }

      emit(loadedState()); // Update with new images
    } catch (e) {
      debugPrint('Error picking images: $e');
      emit(loadedState(errorMessage: LocalizationService.instance.translate(AppStrings.failedToPickImages)));
    }
  }

  Future<List<XFile>> _pickImages(ImageSource source, bool isCamera) async {
    final picker = ImagePicker();

    if (isCamera) {
      // Handle single image from camera
      final image = await picker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 80,
      );
      return image != null ? [image] : [];
    } else {
      // Handle multiple images from gallery
      return await picker.pickMultiImage(
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 80,
      );
    }
  }

// Helper methods for state management
  CreatePostInCommunityState loadingState() {
    return state.maybeMap(
      orElse: () => state,
      loaded: (value) => CreatePostInCommunityState.loaded(
        postContent.length,
        value.changeCounter + 1,
        true, // isLoading
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
        false, // isLoading
        false,
        false,
        errorMessage ?? '',
      ),
    );
  }

  Future<File> _optimizeImage(File imageFile, int qualityPercentage) async {
    final tempDir = await getTemporaryDirectory();
    final uniqueSuffix = DateTime.now().microsecondsSinceEpoch.toString();
    final optimizedImagePath =
        '${tempDir.path}/optimized_image_$uniqueSuffix.jpg';

    final optimizedImageFile = await compute(
      _processImage,
      {
        'imageFile': imageFile,
        'optimizedImagePath': optimizedImagePath,
        'qualityPercentage': qualityPercentage,
      },
    );

    return optimizedImageFile;
  }

  // Background processing function
  static File _processImage(Map<String, dynamic> params) {
    final imageFile = params['imageFile'] as File;
    final optimizedImagePath = params['optimizedImagePath'] as String;
    final qualityPercentage = params['qualityPercentage'] as int;

    // Decode the image
    final image = img.decodeImage(imageFile.readAsBytesSync())!;

    // Calculate new dimensions to maintain the aspect ratio
    const maxDimension = 1024;
    final aspectRatio = image.width / image.height;
    int newWidth, newHeight;

    if (image.width > image.height) {
      newWidth = maxDimension;
      newHeight = (maxDimension / aspectRatio).round();
    } else {
      newHeight = maxDimension;
      newWidth = (maxDimension * aspectRatio).round();
    }

    // Resize the image while maintaining aspect ratio
    final resizedImage = img.copyResize(
      image,
      width: newWidth,
      height: newHeight,
      interpolation: img.Interpolation.cubic, // Higher quality resizing
    );

    // Save the optimized image with the provided quality percentage
    final optimizedImageFile = File(optimizedImagePath)
      ..writeAsBytesSync(
          img.encodeJpg(resizedImage, quality: qualityPercentage));

    return optimizedImageFile;
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
          message: LocalizationService.instance.translate(AppStrings.writeSomethingToPublish),
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
          message: LocalizationService.instance.translate(AppStrings.writeSomethingToPublish),
        );
        return;
      }
      if (imagesPicked.isNotEmpty ||
          editableFeed!.existingMediaPath!.isNotEmpty) {
        editPostWithImageInCommunity(groupId, context); // Handle multiple images
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
          true, // isLoading
          false,
          '',
        ),
      ),
    );

    // Step 1: Copy picked images to unique paths
    final tempDir = await getTemporaryDirectory();
    final List<File> uniquelyCopiedImages = [];

    for (final image in imagesPicked) {
      final uniqueSuffix = DateTime.now().microsecondsSinceEpoch.toString();
      final newImagePath = '${tempDir.path}/copied_$uniqueSuffix.jpg';
      final copiedImage = await image.copy(newImagePath);
      uniquelyCopiedImages.add(copiedImage);
    }

    // Step 2: Optimize copied images
    final optimizedFiles = await Future.wait(
      uniquelyCopiedImages.map((file) => _optimizeImage(file, 80)),
    );

    // Step 3: Convert to multipart files
    final multipartFiles = await convertFilesToMultipart(optimizedFiles);

    // Step 4: Execute post creation use case
    final result = await _createPostInCommunityUsecase.execute(
      CreatePostWithImageInCommunityUsecaseInput(
        postContent: postContent.trim(),
        images: multipartFiles,
        mediaType: 'image',
        visibility: 'Public',
        groupId: groupId,
      ),
    );

    // Step 5: Handle result
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
        debugPrint("Post Success: ${response.message}");

        // Optional: clear images after post
        imagesPicked.clear();
      },
    );
  }

  Future<void> editPostWithImageInCommunity(String? groupId,  context) async {
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
            LocalizationService.instance.translate(AppStrings.noPostDataAvailableForEditing),
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
      final tempDir = await getTemporaryDirectory();
      final List<File> uniquelyCopiedImages = [];

      for (final image in imagesPicked) {
        final uniqueSuffix = DateTime.now().microsecondsSinceEpoch.toString();
        final newImagePath = '${tempDir.path}/copied_edit_$uniqueSuffix.jpg';
        final copiedImage = await image.copy(newImagePath);
        uniquelyCopiedImages.add(copiedImage);
      }

      final optimizedFiles = await Future.wait(
        uniquelyCopiedImages.map((file) => _optimizeImage(file, 80)),
      );

      final multipartFiles = await convertFilesToMultipart(optimizedFiles);


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
