import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class GetAllNotificationUsecase
    implements BaseUseCase<int, GetAllNotificationsModelResponse> {
  final NotificationRepository repository;

  GetAllNotificationUsecase(this.repository);

  @override
  Future<Either<Failure, GetAllNotificationsModelResponse>> excute(
      int page) async {
    return await repository.getAllNotifications(page);
  }
}
