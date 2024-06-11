import 'package:egy_akin/features/splash/data/models/get_app_settings_model_response.dart';

import '../../../../exports.dart';

abstract class SplashDataSource {
  Future<GetAppSettingsModelResponse> getAppSettings();
}

class SplashDataSourceImpl implements SplashDataSource {
  final ApiServices _apiServices;

  SplashDataSourceImpl(this._apiServices);

  @override
  Future<GetAppSettingsModelResponse> getAppSettings() async {
    return await _apiServices.getAppSettings();
  }
}
