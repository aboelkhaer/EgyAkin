import '../../../../exports.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashState.loading());
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
    emit(SplashState.loaded(isAuthentication, isWelcomed));
  }
}
