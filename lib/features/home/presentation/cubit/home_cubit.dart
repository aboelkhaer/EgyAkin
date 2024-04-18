import '../../../../exports.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(
    this._getHomeUsecase,
  ) : super(const HomeState.initial());
  static HomeCubit get(context) => BlocProvider.of(context);
  PersistentTabController tabsController =
      PersistentTabController(initialIndex: 0);
  CarouselController carouselController = CarouselController();
  ScrollController scrollController = ScrollController();
  final GetHomeUsecase _getHomeUsecase;
  DoctorModel currentDoctorModel = const DoctorModel();
  int dotsPosition = 0;

  getDoctorDataFromLocal() async {
    currentDoctorModel = (await sl<AppPreferences>().getDoctorData())!;
    emit(const HomeState.loading());
    getHome();
  }

  @override
  Future<void> close() {
    scrollController.dispose();
    return super.close();
  }

  hideHomeHeader() {
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) => HomeState.loaded(value.homeData,
          value.currentDoctorModel, value.dotsPosition, tabsController.index),
    ));
  }

  changeDotsPositions() {
    emit(
      state.maybeMap(
          orElse: () => state,
          loaded: (value) => HomeState.loaded(value.homeData,
              value.currentDoctorModel, dotsPosition, tabsController.index)),
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
            homeData, currentDoctorModel, dotsPosition, tabsController.index));
      },
    );
  }
}
