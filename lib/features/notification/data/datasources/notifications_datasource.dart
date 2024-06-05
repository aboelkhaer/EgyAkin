import '../../../../exports.dart';

abstract class NotificationsDataSource {
  Future<UpdateNotificationModelResponse> updateNotifications();
  Future<GetAllNotificationsModelResponse> getAllNotifications(int page);
}

class NotificationsDataSourceImpl implements NotificationsDataSource {
  final ApiServices _apiServices;

  NotificationsDataSourceImpl(this._apiServices);

  @override
  Future<UpdateNotificationModelResponse> updateNotifications() async {
    return await _apiServices.updateNotifications();
  }

  @override
  Future<GetAllNotificationsModelResponse> getAllNotifications(int page) async {
    return await _apiServices.getAllNotifications(page);
  }
}
