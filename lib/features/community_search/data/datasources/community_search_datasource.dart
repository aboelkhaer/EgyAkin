
import '../../../../exports.dart';

abstract class CommunitySearchDatasource {
  Future<GetResponseOfSearchModel> getCommunitySearchResponse(
    int page,
    String searchContent,
  );
}

class CommunitySearchDatasourceImpl implements CommunitySearchDatasource {
  final ApiServices _apiServices;

  CommunitySearchDatasourceImpl(this._apiServices);

  @override
  Future<GetResponseOfSearchModel> getCommunitySearchResponse(
    int page,
    String searchContent,
  ) async {
    return await _apiServices.getCommunitySearchResponse(
      page,
      searchContent,
    );
  }
}
