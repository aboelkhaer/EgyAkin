import 'package:egy_akin/features/community_search/data/models/get_response_of_search_model.dart';

import '../../../../exports.dart';

abstract class CommunitySearchDatasource {
  Future<GetResponseOfSearchModel> getCommunitySearchResponse(
    String searchContent,
  );
}

class CommunitySearchDatasourceImpl implements CommunitySearchDatasource {
  final ApiServices _apiServices;

  CommunitySearchDatasourceImpl(this._apiServices);

  @override
  Future<GetResponseOfSearchModel> getCommunitySearchResponse(
    String searchContent,
  ) async {
    return await _apiServices.getCommunitySearchResponse(
      searchContent,
    );
  }
}
