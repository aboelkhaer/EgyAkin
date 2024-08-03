import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/splash/data/models/get_app_settings_model_response.dart';
import 'package:egy_akin/features/splash/domain/repositories/splash_repo.dart';
import '../../../../exports.dart';

class GetAppSettingsUsecase
    implements BaseUseCase<NoParams, GetAppSettingsModelResponse> {
  final SplashRepository repository;

  GetAppSettingsUsecase(this.repository);

  @override
  Future<Either<Failure, GetAppSettingsModelResponse>> execute(
      NoParams input) async {
    return await repository.getAppSettings();
  }
}
