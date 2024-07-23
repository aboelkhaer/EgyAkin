import 'dart:developer';
import 'dart:io';
import 'package:egy_akin/app/services/local_storage.dart';
import 'package:egy_akin/app/utilities/base_usecase.dart';
import 'package:egy_akin/features/authentication/data/models/authentication_model_response.dart';
import 'package:egy_akin/features/profile/domain/usecases/sign_out_usecase.dart';
import 'package:egy_akin/features/profile/domain/usecases/upload_profile_image_usecase.dart';
import 'package:egy_akin/features/profile/presentation/cubit/profile_state.dart';
import 'package:egy_akin/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
//! don't remove imports

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._uploadProfileImageUsecase, this._signOutUsecase)
      : super(const ProfileState.initial());
  final UploadProfileImageUsecase _uploadProfileImageUsecase;
  final SignOutUsecase _signOutUsecase;
  static ProfileCubit get(context) => BlocProvider.of(context);
  File? imagePicked;
  DoctorModel currentDoctor = const DoctorModel();
  getDoctorDataFromHomeCubit(DoctorModel doctorModel) {
    currentDoctor = doctorModel;
    emit(ProfileState.loaded(doctorModel, false));
  }

  uploadProfileImage() async {
    emit(const ProfileState.loading());
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      final pickedImageFile = File(pickedImage.path);
      imagePicked = pickedImageFile;
      final result = await _uploadProfileImageUsecase.excute(imagePicked!);

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
  }

  signOut() async {
    emit(const ProfileState.signOutLoading());
    final result = await _signOutUsecase.excute(NoParams());

    result.fold(
      (l) {
        emit(ProfileState.error(l.message));
      },
      (r) async {
        await sl<AppPreferences>().removeDoctorData();
        emit(const ProfileState.signOutLoaded());
      },
    );
  }
}
