import 'dart:developer';

import 'package:egy_akin/features/splash/domain/usecases/get_app_settings_usecase.dart';

import '../../../../exports.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit(this._getAppSettingsUsecase) : super(const SplashState.loading());
  final GetAppSettingsUsecase _getAppSettingsUsecase;
  static SplashCubit get(context) => BlocProvider.of(context);

  Future<void> loadData() async {
    bool isAuthentication = false;
    await Future.delayed(const Duration(seconds: AppStrings.splashDelay));
    String? token =
        await sl<AppPreferences>().getString(AppLocalStrings.keyToken);
    bool? isWelcomed =
        await sl<AppPreferences>().getBool(AppLocalStrings.isWelcomed) ?? false;
    if (token != null && token != AppStrings.empty) {
      isAuthentication = true;
    }
    bool appFreeze = false;
    bool forceUpdate = false;
    final result = await _getAppSettingsUsecase.execute(NoParams());
    result.fold(
      (l) {
        appFreeze = false;
        forceUpdate = false;
      },
      (result) async {
        appFreeze = result.appFreeze!;
        forceUpdate = result.forceUpdate!;
      },
    );
    log('$appFreeze moatz123');

    emit(SplashState.loaded(
        isAuthentication, isWelcomed, appFreeze, forceUpdate));
  }
}
