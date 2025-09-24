import 'package:egy_akin/features/more/domain/usecases/change_language_usecase.dart';
import 'package:egy_akin/features/more/presentation/cubit/more_state.dart';

import '../../../../exports.dart';

class MoreCubit extends Cubit<MoreState> {
  MoreCubit(this._changeLanguageUsecase) : super(const MoreState.initial());
  static MoreCubit get(context) => BlocProvider.of(context);
  NotificationServices notificationServices = NotificationServices();
  final ChangeLanguageUsecase _changeLanguageUsecase;
  String fcmToken = '';

  getFcmTokenTest() async {
    emit(const MoreState.loading());

    await notificationServices.getDeviceToken().then((value) {
      fcmToken = value.toString();
    });
    // // String? tokentest =
    // //     await sl<AppPreferences>().getString(AppLocalStrings.fcmTokenKey);
    // fcmToken = tokentest!;
    // log(fcmToken);

    emit(const MoreState.loaded());
  }

  changeLanguage(String locale) async {
    final response = await _changeLanguageUsecase.execute(locale);
    response.fold(
      (l) => emit(MoreState.error(l.message)),
      (r) => emit(const MoreState.loaded()),
    );
  }
}
