import 'package:egy_akin/features/home/data/models/notification_model_response.dart';

import '../../../../exports.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepository {
  Future<Either<Failure, HomeModelResponse>> getHome();
  Future<Either<Failure, NotificationModelResponse>> getNotifications();
}
