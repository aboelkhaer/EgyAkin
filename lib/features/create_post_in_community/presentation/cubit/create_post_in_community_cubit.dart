import 'dart:io';

import 'package:egy_akin/app/utilities/custom_snack_bar.dart';
import 'package:egy_akin/features/create_post_in_community/domain/usecases/creat_post_with_text_in_community_usecase.dart';
import 'package:egy_akin/features/create_post_in_community/domain/usecases/create_post_with_image_in_community_usecase.dart';
import 'package:egy_akin/features/create_post_in_community/presentation/cubit/create_post_in_community_state.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'package:image/image.dart' as img;

class CreatePostInCommunityCubit extends Cubit<CreatePostInCommunityState> {
  CreatePostInCommunityCubit(this._createPostInCommunityUsecase,
      this._createPostWithTextInCommunityUsecase)
      : super(const CreatePostInCommunityState.loaded(
            0, 0, false, false, false, ''));
  static CreatePostInCommunityCubit get(context) => BlocProvider.of(context);
  final CreatePostWithImageInCommunityUsecase _createPostInCommunityUsecase;
  final CreatePostWithTextInCommunityUsecase
      _createPostWithTextInCommunityUsecase;

  String postContent = '';
  File? imagePicked;

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

  int changeCounter = 0;
  removePickedImage() {
    imagePicked = null;
    changeCounter++;
    emit(
      state.maybeMap(
        orElse: () => state,
        loaded: (value) => CreatePostInCommunityState.loaded(
          postContent.length,
          changeCounter,
          false,
          false,
          false,
          '',
        ),
      ),
    );
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

    final pickedFile = await _pickImage(source);
    if (pickedFile == null) {
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

    // final optimizedFile = await _optimizeImage(File(pickedFile.path), 80);
    imagePicked = File(pickedFile.path);
    // final optimizedFile = await _optimizeImage(File(pickedFile.path), 80);
    // imagePicked = optimizedFile;

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

  Future<XFile?> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    return await picker.pickImage(source: source);
  }

  Future<File> _optimizeImage(File imageFile, int qualityPercentage) async {
    final tempDir = await getTemporaryDirectory();
    final optimizedImagePath = '${tempDir.path}/optimized_image.jpg';

    // Use compute to process the image in a background thread
    final optimizedImageFile = await compute(
      _processImage,
      {
        'imageFile': imageFile,
        'optimizedImagePath': optimizedImagePath,
        'qualityPercentage': qualityPercentage, // Pass quality here
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

  submitPost(context) async {
    if (imagePicked == null && postContent.trim() == '') {
      customSnackBar(context: context, message: 'Write something to publish.');
      return;
    }
    if (imagePicked != null) {
      createPostWithImageInCommunity();
      return;
    }
    if (imagePicked == null && postContent != '') {
      createPostWithTextInCommunity();
      return;
    }
  }

  createPostWithImageInCommunity() async {
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
    final optimizedFile = await _optimizeImage(imagePicked!, 80);

    final result = await _createPostInCommunityUsecase.execute(
      CreatePostWithImageInCommunityUsecaseInput(
        postContent: postContent.trim(),
        image: optimizedFile,
        mediaType: 'image',
        visibility: 'Public',
        groupId: null,
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

  createPostWithTextInCommunity() async {
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
        mediaType: '',
        visibility: 'Public',
        groupId: null,
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
