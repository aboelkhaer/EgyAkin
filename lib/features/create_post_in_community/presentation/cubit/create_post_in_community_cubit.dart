import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:egy_akin/app/utilities/custom_snack_bar.dart';
import 'package:egy_akin/features/community/data/models/get_posts_community_model_response.dart';
import 'package:egy_akin/features/community/domain/usecases/add_option_on_poll_usecase.dart';
import 'package:egy_akin/features/create_post_in_community/data/models/poll_model.dart';
import 'package:egy_akin/features/create_post_in_community/domain/usecases/creat_post_with_text_in_community_usecase.dart';
import 'package:egy_akin/features/create_post_in_community/domain/usecases/create_post_with_image_in_community_usecase.dart';
import 'package:egy_akin/features/create_post_in_community/domain/usecases/edit_post_with_image_in_community_usecase.dart';
import 'package:egy_akin/features/create_post_in_community/domain/usecases/edit_post_with_text_in_community_usecase.dart';
import 'package:egy_akin/features/create_post_in_community/presentation/cubit/create_post_in_community_state.dart';
import 'package:flutter/foundation.dart';

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

  emitLoadedStateForEditPost(PostCommunityModel feed) {
    editableFeed = feed;

    if (editableFeed!.content == null) {
      editableFeed = editableFeed!.copyWith(content: '');
    }
    emit(
      CreatePostInCommunityState.loaded(editableFeed!.content!.length,
          changeCounter, false, false, false, ''),
    );
  }

  editFeedContentForEditableFeed(String? editableFeedContent) {
    editableFeed = editableFeed!.copyWith(content: editableFeedContent);
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

  Future<void> pickImageAndShowIt(bool isCamera) async {
    emit(
      state.maybeMap(
        orElse: () => state,
        loaded: (value) => CreatePostInCommunityState.loaded(
          postContent.length,
          value.changeCounter,
          true,
          false,
          false,
          '',
        ),
      ),
    );

    final source = await pickImageSource(isCamera);
    if (source == null) {
      emit(
        state.maybeMap(
          orElse: () => state,
          loaded: (value) => CreatePostInCommunityState.loaded(
            postContent.length,
            value.changeCounter,
            false,
            false,
            false,
            '',
          ),
        ),
      );
      return;
    }

    final pickedFiles = await _pickImages(source); // Pick multiple images
    if (pickedFiles.isEmpty) {
      emit(
        state.maybeMap(
          orElse: () => state,
          loaded: (value) => CreatePostInCommunityState.loaded(
            postContent.length,
            value.changeCounter,
            false,
            false,
            false,
            '',
          ),
        ),
      );
      return;
    }

    // Add picked images to the list
    for (final pickedFile in pickedFiles) {
      final optimizedFile = await _optimizeImage(File(pickedFile.path), 80);
      imagesPicked.add(optimizedFile);
    }

    emit(
      state.maybeMap(
        orElse: () => state,
        loaded: (value) => CreatePostInCommunityState.loaded(
          postContent.length,
          value.changeCounter,
          false,
          false,
          false,
          '',
        ),
      ),
    );
  }

  Future<ImageSource?> pickImageSource(bool isCamera) async {
    return isCamera ? ImageSource.camera : ImageSource.gallery;
  }

  Future<List<XFile>> _pickImages(ImageSource source) async {
    final picker = ImagePicker();
    return await picker.pickMultiImage(); // Pick multiple images
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
          message: 'Write something to publish.',
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
          editableFeed!.mediaPath == null) {
        customSnackBar(
          context: context,
          message: 'Write something to publish.',
        );
        return;
      }
      if (imagesPicked.isNotEmpty) {
        editPostWithImageInCommunity(groupId); // Handle multiple images
        return;
      }
      if (imagesPicked.isEmpty &&
          editableFeed!.content != null &&
          editableFeed!.content != '' &&
          editableFeed!.mediaPath != null) {
        editPostWithTextInCommunity(groupId, null);
        return;
      }
      if (imagesPicked.isEmpty &&
          editableFeed!.content != null &&
          editableFeed!.content != '' &&
          editableFeed!.mediaPath == null) {
        log('text type');
        editPostWithTextInCommunity(groupId, 'text');
        return;
      }
    }
  }

  void removeMediaPathInEditableFeed(int index) {
    if (editableFeed != null && editableFeed!.mediaPath != null) {
      // Create a modifiable copy of the list
      final updatedMediaPaths = List<String>.from(editableFeed!.mediaPath!);
      updatedMediaPaths.removeAt(index);

      // Create a new editableFeed with updated mediaPath
      editableFeed = editableFeed!.copyWith(mediaPath: updatedMediaPaths);

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

  Future<void> editPostWithImageInCommunity(String? groupId) async {
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
        postContent: editableFeed!.content,
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
        debugPrint("Edit Success: ${response.message}");

        // Optional: Clear image state
        imagesPicked.clear();
      },
    );
  }

  editPostWithTextInCommunity(String? groupId, String? mediaType) async {
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
