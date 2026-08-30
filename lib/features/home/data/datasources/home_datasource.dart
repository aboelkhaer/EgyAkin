import 'dart:io';

import '../../../../exports.dart';
import 'package:egy_akin/features/home/data/models/user_me_response.dart';

abstract class HomeDataSource {
  Future<HomeModelResponse> getHome();
  Future<UserMeResponse> getUserMe();
  Future<UploadSyndicateCardModelResponse> uploadSyndicateCard(
      {required File image});
  Future<GetPermissionsModelResponse> getRolePermissions();
}

class HomeDataSourceImpl implements HomeDataSource {
  final ApiServices _apiServices;

  HomeDataSourceImpl(this._apiServices);

  @override
  Future<HomeModelResponse> getHome() async {
    return await _apiServices.getHome();
  }

  @override
  Future<UserMeResponse> getUserMe() async {
    return await _apiServices.getUserMe();
  }

  @override
  Future<UploadSyndicateCardModelResponse> uploadSyndicateCard(
      {required File image}) async {
    return await _apiServices.uploadSyndicateCard(image);
  }

  @override
  Future<GetPermissionsModelResponse> getRolePermissions() async {
    return await _apiServices.getRolePermissions();
  }
}
