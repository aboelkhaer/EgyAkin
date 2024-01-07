import '../../../exports.dart';

class EmailVerificationRepository {
  ApiServices apiServices;
  NetworkInfoImpl networkInfo = Get.find<NetworkInfoImpl>();

  EmailVerificationRepository({
    required this.apiServices,
  });
}
