import '../../../../exports.dart';
import 'package:dartz/dartz.dart';

abstract class SplashRepository {
  Future<Either<Failure, GetAppSettingsModelResponse>> getAppSettings();
}
