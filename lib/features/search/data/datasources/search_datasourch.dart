import '../../../../exports.dart';

abstract class SearchDataSource {
  Future<GetSearchModelResponse> getSearchHome({
    required String searchContent,
    required int page,
  });
}

class SearchDataSourceImpl implements SearchDataSource {
  final ApiServices _apiServices;

  SearchDataSourceImpl(this._apiServices);

  @override
  Future<GetSearchModelResponse> getSearchHome(
      {required String searchContent, required int page}) async {
    return await _apiServices.searchHome(searchContent, page);
  }
}
