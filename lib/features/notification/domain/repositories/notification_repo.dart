import 'package:dartz/dartz.dart';

import '../../../../exports.dart';

abstract class NotificationRepository {
  Future<Either<Failure, UpdateNotificationModelResponse>> updateNotification();
  Future<Either<Failure, GetAllNotificationsModelResponse>>
      getAllNotifications();
}
