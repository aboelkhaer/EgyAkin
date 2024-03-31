import '../../../../exports.dart';

abstract class NotificationsDataSource {
  Future<UpdateNotificationModelResponse> updateNotifications();
  Future<GetAllNotificationsModelResponse> getAllNotifications();
}

class NotificationsDataSourceImpl implements NotificationsDataSource {
  final ApiServices _apiServices;

  NotificationsDataSourceImpl(this._apiServices);

  @override
  Future<UpdateNotificationModelResponse> updateNotifications() async {
    return await _apiServices.updateNotifications();
  }

  @override
  Future<GetAllNotificationsModelResponse> getAllNotifications() async {
    return await _apiServices.getAllNotifications();
  }
}
