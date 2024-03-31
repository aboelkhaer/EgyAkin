import 'package:egy_akin/features/home/data/models/notification_model_response.dart';

import '../../../../exports.dart';

abstract class HomeDataSource {
  Future<HomeModelResponse> getHome();
  Future<NotificationModelResponse> getNotifications();
}

class HomeDataSourceImpl implements HomeDataSource {
  final ApiServices _apiServices;

  HomeDataSourceImpl(this._apiServices);

  @override
  Future<HomeModelResponse> getHome() async {
    return await _apiServices.getHome();
  }

  @override
  Future<NotificationModelResponse> getNotifications() async {
    return await _apiServices.getNotifications();
  }
}
