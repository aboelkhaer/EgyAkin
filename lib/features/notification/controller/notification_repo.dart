import '../../../exports.dart';

class NotificationRepository {
  ApiServices apiServices;
  NotificationRepository({required this.apiServices});
  NetworkInfoImpl networkInfo = Get.find<NetworkInfoImpl>();
}
