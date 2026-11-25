
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
