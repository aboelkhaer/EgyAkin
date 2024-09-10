import 'dart:io';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:egy_akin/app/services/local_storage.dart';
import 'package:egy_akin/app/utilities/base_usecase.dart';
import 'package:egy_akin/features/authentication/data/models/authentication_model_response.dart';
import 'package:egy_akin/features/home/data/models/home_model_response.dart';
import 'package:egy_akin/features/home/domain/usecases/get_home_usecase.dart';
import 'package:egy_akin/features/home/domain/usecases/upload_syndicate_card_usecase.dart';
import 'package:egy_akin/features/home/presentation/cubit/home_state.dart';
import 'package:egy_akin/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(
    this._getHomeUsecase,
    this._uploadSyndicateCardUsecase,
  ) : super(const HomeState.initial());
  static HomeCubit get(context) => BlocProvider.of(context);
  PersistentTabController tabsController =
      PersistentTabController(initialIndex: 0);
  CarouselController carouselController = CarouselController();
  ScrollController scrollController = ScrollController();
  final GetHomeUsecase _getHomeUsecase;
  final UploadSyndicateCardUsecase _uploadSyndicateCardUsecase;
  DoctorModel currentDoctorModel = const DoctorModel();
  int dotsPosition = 0;
  bool? accountVerification;
  String? doctorPatientCount;
  String? doctorScore;
  bool isUnreadNotification = false;
  String isSyndicateCardRequired = '';
  String currentDoctorRole = '';
  HomeModelResponse homeDataModel = const HomeModelResponse();

  final GlobalKey addPatientKey = GlobalKey();
  final GlobalKey topDoctorKey = GlobalKey();
  final GlobalKey yourPatientKey = GlobalKey();

  refreshScreenOnly() {
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) => HomeState.loaded(
          value.homeData,
          value.currentDoctorModel,
          value.dotsPosition,
          value.homeIndex,
          value.isUploadingSyndicateCard,
          value.isUploadedSyndicateCard,
          ''),
    ));
  }

  getDoctorDataFromLocal() async {
    currentDoctorModel = (await sl<AppPreferences>().getDoctorData())!;

    // emit(const HomeState.loading());
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) => HomeState.loaded(
          value.homeData,
          currentDoctorModel,
          dotsPosition,
          value.homeIndex,
          value.isUploadingSyndicateCard,
          value.isUploadedSyndicateCard,
          ''),
    ));
    getHome();
  }

  // @override
  // Future<void> close() {
  //   scrollController.dispose();
  //   return super.close();
  // }

  hideHomeHeader() {
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) => HomeState.loaded(
          value.homeData,
          value.currentDoctorModel,
          value.dotsPosition,
          tabsController.index,
          value.isUploadingSyndicateCard,
          value.isUploadedSyndicateCard,
          ''),
    ));
  }

  changeDotsPositions() {
    emit(
      state.maybeMap(
          orElse: () => state,
          loaded: (value) => HomeState.loaded(
                value.homeData,
                value.currentDoctorModel,
                dotsPosition,
                tabsController.index,
                value.isUploadingSyndicateCard,
                value.isUploadedSyndicateCard,
                '',
              )),
    );
  }

  getHome() async {
    dotsPosition = 0;
    emit(const HomeState.loading());

    final result = await _getHomeUsecase.execute(NoParams());
    result.fold(
      (l) {
        emit(HomeState.error(l.message));
      },
      (homeData) async {
        accountVerification = homeData.verified!;
        if (int.parse(homeData.unreadCount!) > 0) {
          isUnreadNotification = true;
        } else {
          isUnreadNotification = false;
        }
        doctorPatientCount = homeData.doctorPatientCount.toString();
        doctorScore = homeData.scoreValue.toString();
        isSyndicateCardRequired = homeData.isSyndicateCardRequired.toString();
        currentDoctorRole = homeData.role.toString();
        homeDataModel = homeData;
        emit(HomeState.loaded(homeData, currentDoctorModel, dotsPosition,
            tabsController.index, false, false, ''));
      },
    );
  }

  File? imagePicked;

  uploadSyndicateCard() async {
    emit(
      state.maybeMap(
          orElse: () => state,
          loaded: (value) => HomeState.loaded(
                value.homeData,
                value.currentDoctorModel,
                value.dotsPosition,
                tabsController.index,
                true,
                false,
                '',
              )),
    );
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      final pickedImageFile = File(pickedImage.path);
      imagePicked = pickedImageFile;
      final result = await _uploadSyndicateCardUsecase.execute(imagePicked!);

      result.fold(
        (l) {
          emit(
            state.maybeMap(
                orElse: () => state,
                loaded: (value) => HomeState.loaded(
                      value.homeData,
                      value.currentDoctorModel,
                      value.dotsPosition,
                      tabsController.index,
                      false,
                      false,
                      l.message,
                    )),
          );
        },
        (r) async {
          // log(r.image.toString());
          emit(
            state.maybeMap(
                orElse: () => state,
                loaded: (value) => HomeState.loaded(
                      value.homeData,
                      value.currentDoctorModel,
                      value.dotsPosition,
                      tabsController.index,
                      false,
                      true,
                      r.message!,
                    )),
          );
        },
      );
    } else {
      emit(
        state.maybeMap(
            orElse: () => state,
            loaded: (value) => HomeState.loaded(
                  value.homeData,
                  value.currentDoctorModel,
                  value.dotsPosition,
                  tabsController.index,
                  false,
                  false,
                  '',
                )),
      );
    }
  }
}
