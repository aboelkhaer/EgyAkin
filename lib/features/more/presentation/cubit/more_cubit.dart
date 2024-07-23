
import 'package:egy_akin/features/more/presentation/cubit/more_state.dart';

import '../../../../exports.dart';

class MoreCubit extends Cubit<MoreState> {
  MoreCubit() : super(const MoreState.initial());
  static MoreCubit get(context) => BlocProvider.of(context);
  NotificationServices notificationServices = NotificationServices();
  String fcmToken = '';

  getFcmTokenTest() async {
    emit(const MoreState.loading());

    await notificationServices.getDeviceToken().then((value) {
      fcmToken = value;
    });
    // String? tokentest =
    //     await sl<AppPreferences>().getString(AppLocalStrings.fcmTokenKey);
    // fcmToken = tokentest!;

    emit(const MoreState.loaded());
  }
}
