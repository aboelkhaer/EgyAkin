import 'package:egy_akin/features/all_doctor_posts/data/models/get_all_doctor_posts_model_response.dart';

import '../../../../exports.dart';

abstract class AllDoctorPostsDatasource {
  Future<GetAllDoctorPostsModelResponse> getAllDoctorPosts(
      String doctorId, int page);
}

class AllDoctorPostsDatasourceImpl implements AllDoctorPostsDatasource {
  final ApiServices _apiServices;

  AllDoctorPostsDatasourceImpl(this._apiServices);

  @override
  Future<GetAllDoctorPostsModelResponse> getAllDoctorPosts(
      String doctorId, int page) async {
    return await _apiServices.getAllDoctorPosts(doctorId, page);
  }
}
