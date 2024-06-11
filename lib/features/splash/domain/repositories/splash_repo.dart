import 'package:egy_akin/features/splash/data/models/get_app_settings_model_response.dart';

import '../../../../exports.dart';
import 'package:dartz/dartz.dart';

abstract class SplashRepository {
  Future<Either<Failure, GetAppSettingsModelResponse>> getAppSettings();
}
