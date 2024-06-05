import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

class UpdateNotificationUsecase
    implements BaseUseCase<NoParams, UpdateNotificationModelResponse> {
  final NotificationRepository repository;

  UpdateNotificationUsecase(this.repository);

  @override
  Future<Either<Failure, UpdateNotificationModelResponse>> excute(
      NoParams input) async {
    return await repository.updateNotification();
  }
}
