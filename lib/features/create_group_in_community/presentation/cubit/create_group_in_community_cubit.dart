import 'dart:io';

import 'package:egy_akin/app/utilities/enums.dart';
import 'package:egy_akin/features/create_group_in_community/domain/usecases/create_group_in_community_usecase.dart';
import 'package:egy_akin/features/create_group_in_community/presentation/cubit/create_group_in_community_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class CreateGroupInCommunityCubit extends Cubit<CreateGroupInCommunityState> {
  CreateGroupInCommunityCubit(this._createGroupInCommunityUsecase)
      : super(const CreateGroupInCommunityState.loaded(
          '',
          '',
          false,
          false,
          0,
          false,
          false,
        ));
  static CreateGroupInCommunityCubit get(context) => BlocProvider.of(context);
  final CreateGroupInCommunityUsecase _createGroupInCommunityUsecase;

  File? imagePickedForGroupHeader;
  File? imagePickedForGroupImage;
  String groupHeaderText = '';
  String groupDescriptionText = '';
  GroupPrivacy _privacy = GroupPrivacy.public;
  GroupPrivacy get privacy => _privacy;

  set privacySetValue(GroupPrivacy value) {
    _privacy = value;
  }

  int counterChanges = 0;
  int imageQuality = 10;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickGroupHeaderImage() async {
    emit(
      state.maybeMap(
        orElse: () => state,
        loaded: (value) => CreateGroupInCommunityState.loaded(
          '',
          '',
          true,
          false,
          counterChanges,
          false,
          false,
        ),
      ),
    );
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: imageQuality,
    );
    if (pickedFile == null) {
      emit(
        state.maybeMap(
          orElse: () => state,
          loaded: (value) => CreateGroupInCommunityState.loaded(
            '',
            '',
            false,
            false,
            counterChanges,
            false,
            false,
          ),
        ),
      );
      return;
    }

    imagePickedForGroupHeader = File(pickedFile.path);
    emit(
      state.maybeMap(
        orElse: () => state,
        loaded: (value) => CreateGroupInCommunityState.loaded(
          '',
          '',
          false,
          false,
          counterChanges,
          false,
          false,
        ),
      ),
    );
  }

  Future<void> pickGroupImage() async {
    emit(
      state.maybeMap(
        orElse: () => state,
        loaded: (value) => CreateGroupInCommunityState.loaded(
          '',
          '',
          false,
          true,
          counterChanges,
          false,
          false,
        ),
      ),
    );
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: imageQuality,
    );
    if (pickedFile == null) {
      emit(
        state.maybeMap(
          orElse: () => state,
          loaded: (value) => CreateGroupInCommunityState.loaded(
            '',
            '',
            false,
            false,
            counterChanges,
            false,
            false,
          ),
        ),
      );
      return;
    }
    imagePickedForGroupImage = File(pickedFile.path);
    emit(
      state.maybeMap(
        orElse: () => state,
        loaded: (value) => CreateGroupInCommunityState.loaded(
          '',
          '',
          false,
          false,
          counterChanges,
          false,
          false,
        ),
      ),
    );
  }

  void setPrivacy(GroupPrivacy privacy) {
    _privacy = privacy;
    counterChanges++;
    emit(
      state.maybeMap(
        orElse: () => state,
        loaded: (value) => CreateGroupInCommunityState.loaded(
          '',
          '',
          false,
          false,
          counterChanges,
          false,
          false,
        ),
      ),
    );
  }

  createGroup() async {
    if (imagePickedForGroupHeader == null) {
      emit(
        state.maybeMap(
          orElse: () => state,
          loaded: (value) => CreateGroupInCommunityState.loaded(
            'Cover image is required.',
            '',
            false,
            false,
            counterChanges,
            false,
            false,
          ),
        ),
      );
      return;
    }
    if (imagePickedForGroupImage == null) {
      emit(
        state.maybeMap(
          orElse: () => state,
          loaded: (value) => CreateGroupInCommunityState.loaded(
            'Group image is required.',
            '',
            false,
            false,
            counterChanges,
            false,
            false,
          ),
        ),
      );
      return;
    }

    emit(
      state.maybeMap(
        orElse: () => state,
        loaded: (value) => CreateGroupInCommunityState.loaded(
          '',
          '',
          false,
          false,
          counterChanges,
          true,
          false,
        ),
      ),
    );

    final result = await _createGroupInCommunityUsecase.execute(
      CreateGroupInCommunityUsecaseInput(
        headerImage: imagePickedForGroupHeader,
        groupImage: imagePickedForGroupImage,
        name: groupHeaderText,
        description: groupDescriptionText,
        privacy: privacy.name,
      ),
    );
    result.fold(
      (l) {
        emit(
          state.maybeMap(
            orElse: () => state,
            loaded: (value) => CreateGroupInCommunityState.loaded(
              l.message,
              '',
              false,
              false,
              counterChanges,
              false,
              false,
            ),
          ),
        );
      },
      (response) async {
        emit(
          state.maybeMap(
            orElse: () => state,
            loaded: (value) => CreateGroupInCommunityState.loaded(
              response.message.toString(),
              '',
              false,
              false,
              counterChanges,
              false,
              true,
            ),
          ),
        );
      },
    );
  }
}
