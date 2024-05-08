import '../../../../exports.dart';

abstract class SearchDataSource {
  Future<GetSearchModelResponse> getSearchHome({
    required String searchContent,
  });
}

class SearchDataSourceImpl implements SearchDataSource {
  final ApiServices _apiServices;

  SearchDataSourceImpl(this._apiServices);

  @override
  Future<GetSearchModelResponse> getSearchHome(
      {required String searchContent}) async {
    return await _apiServices.searchHome(searchContent);
  }
}
