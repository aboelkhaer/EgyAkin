import 'dart:async';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:egy_akin/app/constants/local_storage_key.dart';
import 'package:egy_akin/app/services/local_storage.dart';
import 'package:egy_akin/app/shared/functions/permissions_helper.dart';
import 'package:egy_akin/app/utilities/base_usecase.dart';
import 'package:egy_akin/features/authentication/data/models/authentication_model_response.dart';
import 'package:egy_akin/features/community/presentation/cubit/community_cubit.dart';
import 'package:egy_akin/features/community/presentation/cubit/groups_cubit/groups_cubit.dart';
import 'package:egy_akin/features/community/presentation/cubit/trending_cubit/trending_cubit.dart';
import 'package:egy_akin/features/community_search/presentation/cubit/community_search_cubit.dart';
import 'package:egy_akin/features/consultation/presentation/cubit/consultation_cubit.dart';
import 'package:egy_akin/features/group_details_in_community/presentation/cubit/group_details_in_community_cubit.dart';
import 'package:egy_akin/features/home/presentation/cubit/home_cubit.dart';
import 'package:egy_akin/features/profile/domain/usecases/sign_out_usecase.dart';
import 'package:egy_akin/features/profile/domain/usecases/upload_profile_image_usecase.dart';
import 'package:egy_akin/features/profile/presentation/cubit/profile_state.dart';
import 'package:egy_akin/injection_container.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:egy_akin/app/shared/functions/reduce_image_resolution.dart';
import 'package:egy_akin/app/shared/functions/local_profile_image_helper.dart';

//! don't remove imports

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._uploadProfileImageUsecase, this._signOutUsecase)
      : super(const ProfileState.initial());
  final UploadProfileImageUsecase _uploadProfileImageUsecase;
  final SignOutUsecase _signOutUsecase;
  static ProfileCubit get(context) => BlocProvider.of(context);
  File? imagePicked;
  bool isPickingImage = false;
  bool isUploadingImage = false;
  /// Bumps after a successful upload so avatar widgets rebuild even if URL is unchanged.
  int imageRevision = 0;
  DoctorModel currentDoctor = const DoctorModel();

  bool get isCameraBusy => isPickingImage || isUploadingImage;

  getDoctorDataFromLocal() async {
    currentDoctor = (await sl<AppPreferences>().getDoctorData())!;
    // Warm local avatar cache so profile opens without network flicker.
    unawaited(LocalProfileImageHelper.ensureCached(currentDoctor.image));
    emit(ProfileState.loaded(currentDoctor, false));
  }

  /// Opens gallery and prepares a local preview. Does not upload yet.
  Future<File?> pickProfileImage() async {
    if (isCameraBusy) return null;
    isPickingImage = true;
    imagePicked = null;
    emit(const ProfileState.loading());
    final picker = ImagePicker();

    try {
      final pickedImage = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );
      if (pickedImage == null) {
        isPickingImage = false;
        imagePicked = null;
        emit(ProfileState.loaded(currentDoctor, false));
        return null;
      }

      try {
        imagePicked = await optimizeImage(File(pickedImage.path));
      } catch (e) {
        isPickingImage = false;
        imagePicked = null;
        emit(ProfileState.error('Failed to optimize image: $e'));
        emit(ProfileState.loaded(currentDoctor, false));
        return null;
      }

      isPickingImage = false;
      emit(ProfileState.loaded(currentDoctor, false));
      return imagePicked;
    } on PlatformException catch (e) {
      isPickingImage = false;
      imagePicked = null;
      if (e.code == 'photo_access_denied') {
        emit(const ProfileState.error(
            'Photo access denied. Please allow photo access from settings.'));
      } else {
        emit(ProfileState.error('An unexpected error occurred: ${e.message}'));
      }
      emit(ProfileState.loaded(currentDoctor, false));
      return null;
    } catch (e) {
      isPickingImage = false;
      imagePicked = null;
      emit(ProfileState.error('An unexpected error occurred: $e'));
      emit(ProfileState.loaded(currentDoctor, false));
      return null;
    }
  }

  void discardPickedProfileImage() {
    imagePicked = null;
    isPickingImage = false;
    isUploadingImage = false;
    emit(ProfileState.loaded(currentDoctor, false));
  }

  /// Uploads the currently picked image after user confirmation.
  Future<void> uploadPickedProfileImage() async {
    if (imagePicked == null || isUploadingImage) return;
    isUploadingImage = true;
    final fileToUpload = imagePicked!;
    // Keep showing the previous avatar until upload finishes.
    emit(const ProfileState.loading());

    try {
      final result = await _uploadProfileImageUsecase.execute(fileToUpload);

      await result.fold(
        (l) async {
          isUploadingImage = false;
          imagePicked = null;
          emit(ProfileState.error(l.message));
          emit(ProfileState.loaded(currentDoctor, false));
        },
        (r) async {
          final newUrl = r.image;
          if (newUrl == null || newUrl.isEmpty) {
            isUploadingImage = false;
            imagePicked = null;
            emit(const ProfileState.error('Failed to update profile image'));
            emit(ProfileState.loaded(currentDoctor, false));
            return;
          }
          await sl<AppPreferences>().updateDoctorImageData(newUrl);
          await LocalProfileImageHelper.saveFromFile(
            fileToUpload,
            remoteUrl: newUrl,
          );
          final previousUrl = currentDoctor.image;
          currentDoctor = currentDoctor.copyWith(image: newUrl);
          if (previousUrl != null && previousUrl.isNotEmpty) {
            await CachedNetworkImage.evictFromCache(previousUrl);
          }
          await CachedNetworkImage.evictFromCache(newUrl);
          isUploadingImage = false;
          imagePicked = null;
          imageRevision++;
          emit(ProfileState.loaded(currentDoctor, true));
        },
      );
    } catch (e) {
      isUploadingImage = false;
      imagePicked = null;
      emit(ProfileState.error('An unexpected error occurred: $e'));
      emit(ProfileState.loaded(currentDoctor, false));
    }
  }

  Future<void> uploadProfileImage() async {
    final picked = await pickProfileImage();
    if (picked == null) return;
    await uploadPickedProfileImage();
  }

  void _resetCubit<T extends Cubit>(T Function() createFn) {
    final cubit = sl<T>();
    sl.unregister<T>();
    if (!cubit.isClosed) {
      cubit.close();
    }
    sl.registerLazySingleton<T>(createFn);
  }

  signOut() async {
    emit(const ProfileState.signOutLoading());
    // Reset each cubit
    _resetCubit<CommunityCubit>(
        () => CommunityCubit(sl(), sl(), sl(), sl(), sl(), sl()));
    _resetCubit<TrendingCubit>(() => TrendingCubit(sl()));
    _resetCubit<GroupsCubit>(
        () => GroupsCubit(sl(), sl(), sl(), sl(), sl(), sl()));
    _resetCubit<GroupDetailsInCommunityCubit>(() =>
        GroupDetailsInCommunityCubit(
            sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl()));
    _resetCubit<CommunitySearchCubit>(
        () => CommunitySearchCubit(sl(), sl(), sl(), sl(), sl()));
    _resetCubit<ConsultationCubit>(
        () => ConsultationCubit(sl(), sl()));
    _resetCubit<HomeCubit>(() => HomeCubit(sl(), sl(), sl(), sl()));

    final result = await _signOutUsecase.execute(NoParams());
    // Always clear local session — logout can 403 for blocked accounts.
    await sl<AppPreferences>().removeDoctorData();
    await sl<AppPreferences>().removeData(AppLocalStrings.permissions);
    await LocalProfileImageHelper.clear();
    PermissionHelper.clearCache();

    result.fold(
      (l) {
        debugPrint('Logout failed: ${l.message}');
        emit(const ProfileState.signOutLoaded());
      },
      (r) async {
        emit(const ProfileState.signOutLoaded());
      },
    );
  }
}