import 'dart:io';

import 'package:egy_akin/features/home/data/models/upload_syndicate_card_model_response.dart';

import '../../../../exports.dart';

abstract class HomeDataSource {
  Future<HomeModelResponse> getHome();
  Future<UploadSyndicateCardModelResponse> uploadSyndicateCard(
      {required File image});
}

class HomeDataSourceImpl implements HomeDataSource {
  final ApiServices _apiServices;

  HomeDataSourceImpl(this._apiServices);

  @override
  Future<HomeModelResponse> getHome() async {
    return await _apiServices.getHome();
  }

  @override
  Future<UploadSyndicateCardModelResponse> uploadSyndicateCard(
      {required File image}) async {
    return await _apiServices.uploadSyndicateCard(image);
  }
}
