import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class GetAllNotificationUsecase
    implements BaseUseCase<NoParams, GetAllNotificationsModelResponse> {
  final NotificationRepository repository;

  GetAllNotificationUsecase(this.repository);

  @override
  Future<Either<Failure, GetAllNotificationsModelResponse>> excute(
      NoParams input) async {
    return await repository.getAllNotifications();
  }
}
