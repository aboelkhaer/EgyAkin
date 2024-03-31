import 'package:dartz/dartz.dart';

import '../../../../exports.dart';

class NotificationRepositoryImpl extends NotificationRepository {
  final NotificationsDataSource notificationsDataSource;
  final NetworkInfo networkInfo;

  NotificationRepositoryImpl(this.notificationsDataSource, this.networkInfo);

  @override
  Future<Either<Failure, UpdateNotificationModelResponse>>
      updateNotification() async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response = await notificationsDataSource.updateNotifications();
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }

  @override
  Future<Either<Failure, GetAllNotificationsModelResponse>>
      getAllNotifications() async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response = await notificationsDataSource.getAllNotifications();
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }
}
