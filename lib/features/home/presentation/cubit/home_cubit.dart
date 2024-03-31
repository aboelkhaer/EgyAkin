import 'package:egy_akin/features/home/domain/usecases/get_notifications_usecase.dart';

import '../../../../exports.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._getHomeUsecase, this._getNotificationsUsecase)
      : super(const HomeState.initial());
  static HomeCubit get(context) => BlocProvider.of(context);
  PersistentTabController tabsController =
      PersistentTabController(initialIndex: 0);
  CarouselController carouselController = CarouselController();

  final GetHomeUsecase _getHomeUsecase;
  final GetNotificationsUsecase _getNotificationsUsecase;
  DoctorModel currentDoctorModel = const DoctorModel();
  int dotsPosition = 0;

  getDoctorDataFromLocal() async {
    currentDoctorModel = (await sl<AppPreferences>().getDoctorData())!;
    emit(const HomeState.loading());
    getHome();
    getNotifications();
  }

  changeDotsPositions() {
    emit(
      state.maybeMap(
          orElse: () => state,
          loaded: (value) => HomeState.loaded(
              value.homeData,
              value.currentDoctorModel,
              dotsPosition,
              value.notificationDataModel)),
    );
  }

  getHome() async {
    dotsPosition = 0;
    emit(const HomeState.loading());

    final result = await _getHomeUsecase.excute(NoParams());
    result.fold(
      (l) {
        emit(HomeState.error(l.message));
      },
      (homeData) async {
        emit(HomeState.loaded(
            homeData, currentDoctorModel, dotsPosition, notificationDataModel));
      },
    );
  }

  NotificationModelResponse notificationDataModel =
      const NotificationModelResponse();

  void getNotifications() async {
    emit(const HomeState.loading());

    final result = await _getNotificationsUsecase.excute(NoParams());
    result.fold(
      (l) => emit(HomeState.error(l.message)),
      (data) {
        notificationDataModel = data;
        emit(
          state.maybeMap(
            orElse: () => state,
            loaded: (value) => HomeState.loaded(value.homeData,
                value.currentDoctorModel, value.dotsPosition, data),
          ),
        );
      },
    );
  }
}
