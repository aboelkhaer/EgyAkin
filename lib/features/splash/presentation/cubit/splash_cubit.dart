import 'package:egy_akin/app/services/native_shared_auth.dart';
import 'package:egy_akin/features/chat/data/services/chat_realtime_service.dart';

import '../../../../exports.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit(this._getAppSettingsUsecase) : super(const SplashState.loading());
  final GetAppSettingsUsecase _getAppSettingsUsecase;
  static SplashCubit get(context) => BlocProvider.of(context);

  Future<void> loadData() async {
    bool isAuthentication = false;
    String? token =
        await sl<AppPreferences>().getString(AppLocalStrings.keyToken);
    bool? isWelcomed =
        await sl<AppPreferences>().getBool(AppLocalStrings.isWelcomed) ?? false;
    // Sessions from before the NotificationService extension shipped.
    unawaited(NativeSharedAuth.save(token));
    if (token != null && token != AppStrings.empty) {
      isAuthentication = true;
      // Go Online during splash (before Home / any screen) so peers see
      // Online within ~1s — not only after opening a chat room.
      if (sl.isRegistered<ChatRealtimeService>()) {
        unawaited(sl<ChatRealtimeService>().bootstrapFromLocalSession());
      }
    }
    await Future.delayed(const Duration(seconds: AppStrings.splashDelay));
    bool appFreeze = false;
    bool forceUpdate = false;
    final result = await _getAppSettingsUsecase.execute(NoParams());
    result.fold(
      (l) {
        appFreeze = false;
        forceUpdate = false;
      },
      (settings) {
        appFreeze = settings.appFreeze ?? false;
        forceUpdate = settings.forceUpdate ?? false;
      },
    );

    emit(SplashState.loaded(
      isAuthentication,
      isWelcomed,
      appFreeze,
      forceUpdate,
    ));
  }
}
