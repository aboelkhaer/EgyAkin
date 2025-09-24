import 'package:egy_akin/features/more/data/models/change_language_model_response.dart';

import '../../../../exports.dart';

abstract class MoreDataSource {
  Future<ChangeLanguageModelResponse> changeLanguage(String local);
}

class MoreDataSourceImpl implements MoreDataSource {
  final ApiServices _apiServices;

  MoreDataSourceImpl(this._apiServices);

  @override
  Future<ChangeLanguageModelResponse> changeLanguage(String local) async {
    return await _apiServices.changeLanguage(local);
  }


}
