import 'dart:io';
import '../../../../exports.dart';

abstract class ProfileDataSource {
  Future<UploadProfileImageModelResponse> uploadProfileImage({
    required File image,
  });
  Future<SignOutModelResponse> signOut();
}

class ProfileDataSourceImpl implements ProfileDataSource {
  final ApiServices _apiServices;

  ProfileDataSourceImpl(this._apiServices);

  @override
  Future<UploadProfileImageModelResponse> uploadProfileImage(
      {required File image}) async {
    return await _apiServices.uploadProfileImage(image);
  }

  @override
  Future<SignOutModelResponse> signOut() async {
    return await _apiServices.signOut();
  }
}
