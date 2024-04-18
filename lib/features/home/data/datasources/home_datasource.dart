import '../../../../exports.dart';

abstract class HomeDataSource {
  Future<HomeModelResponse> getHome();
}

class HomeDataSourceImpl implements HomeDataSource {
  final ApiServices _apiServices;

  HomeDataSourceImpl(this._apiServices);

  @override
  Future<HomeModelResponse> getHome() async {
    return await _apiServices.getHome();
  }
}
