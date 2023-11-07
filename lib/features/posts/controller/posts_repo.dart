import '../../../exports.dart';

class PostsRepository {
  ApiServices apiServices;
  PostsRepository({required this.apiServices});
  NetworkInfoImpl networkInfo = Get.find<NetworkInfoImpl>();
}
