import '../../../../exports.dart';

abstract class SearchDataSource {
  Future<GetSearchModelResponse> getSearchHome({
    required String patient,
    required String dose,
  });
}

class SearchDataSourceImpl implements SearchDataSource {
  final ApiServices _apiServices;

  SearchDataSourceImpl(this._apiServices);

  @override
  Future<GetSearchModelResponse> getSearchHome(
      {required String patient, required String dose}) async {
    return await _apiServices.searchHome(patient, dose);
  }
}
