import 'dart:developer';
import 'dart:io';
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
import 'package:egy_akin/features/profile/domain/usecases/sign_out_usecase.dart';
import 'package:egy_akin/features/profile/domain/usecases/upload_profile_image_usecase.dart';
import 'package:egy_akin/features/profile/presentation/cubit/profile_state.dart';
import 'package:egy_akin/injection_container.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:egy_akin/app/shared/functions/reduce_image_resolution.dart';

//! don't remove imports

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._uploadProfileImageUsecase, this._signOutUsecase)
      : super(const ProfileState.initial());
  final UploadProfileImageUsecase _uploadProfileImageUsecase;
  final SignOutUsecase _signOutUsecase;
  static ProfileCubit get(context) => BlocProvider.of(context);
  File? imagePicked;
  DoctorModel currentDoctor = const DoctorModel();
  // getDoctorDataFromHomeCubit(DoctorModel doctorModel) {
  //   currentDoctor = doctorModel;
  //   emit(ProfileState.loaded(doctorModel, false));
  // }

  getDoctorDataFromLocal() async {
    currentDoctor = (await sl<AppPreferences>().getDoctorData())!;
    emit(ProfileState.loaded(currentDoctor, false));
  }

  Future<void> uploadProfileImage() async {
    emit(const ProfileState.loading());
    final picker = ImagePicker();

    try {
      final pickedImage = await picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        final pickedImageFile = File(pickedImage.path);

        // Optimize the picked image
        File optimizedImage;
        try {
          optimizedImage = await optimizeImage(pickedImageFile);
          imagePicked = optimizedImage; // Update with the optimized image
        } catch (e) {
          emit(ProfileState.error('Failed to optimize image: $e'));
          return;
        }

        final result = await _uploadProfileImageUsecase.execute(imagePicked!);

        result.fold(
          (l) {
            emit(ProfileState.error(l.message));
          },
          (r) async {
            log(r.image.toString());
            await sl<AppPreferences>().updateDoctorImageData(r.image!);
            emit(ProfileState.loaded(currentDoctor, true));
          },
        );
      } else {
        emit(ProfileState.loaded(currentDoctor, false));
      }
    } on PlatformException catch (e) {
      if (e.code == 'photo_access_denied') {
        emit(const ProfileState.error(
            'Photo access denied. Please allow photo access from settings.'));
        // openAppSettings();
      } else {
        emit(ProfileState.error('An unexpected error occurred: ${e.message}'));
      }
    } catch (e) {
      emit(ProfileState.error('An unexpected error occurred: $e'));
    }
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

    final result = await _signOutUsecase.execute(NoParams());

    result.fold(
      (l) {
        emit(ProfileState.error(l.message));
      },
      (r) async {
        await sl<AppPreferences>().removeDoctorData();
        await sl<AppPreferences>().removeData(AppLocalStrings.permissions);
        PermissionHelper.clearCache();

        emit(const ProfileState.signOutLoaded());
      },
    );
  }
}
