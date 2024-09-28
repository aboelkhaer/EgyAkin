import 'dart:developer';
import 'dart:io';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:egy_akin/app/constants/local_storage_key.dart';
import 'package:egy_akin/app/services/local_storage.dart';
import 'package:egy_akin/app/shared/functions/reduce_image_resolution.dart';
import 'package:egy_akin/app/utilities/base_usecase.dart';
import 'package:egy_akin/features/authentication/data/models/authentication_model_response.dart';
import 'package:egy_akin/features/home/data/models/home_model_response.dart';
import 'package:egy_akin/features/home/domain/usecases/get_home_usecase.dart';
import 'package:egy_akin/features/home/domain/usecases/upload_syndicate_card_usecase.dart';
import 'package:egy_akin/features/home/presentation/cubit/home_state.dart';
import 'package:egy_akin/features/profile/domain/usecases/sign_out_usecase.dart';
import 'package:egy_akin/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(
    this._getHomeUsecase,
    this._uploadSyndicateCardUsecase,
    this._signOutUsecase,
  ) : super(const HomeState.initial());
  static HomeCubit get(context) => BlocProvider.of(context);
  PersistentTabController tabsController =
      PersistentTabController(initialIndex: 0);
  CarouselSliderController carouselController = CarouselSliderController();
  ScrollController scrollController = ScrollController();
  final GetHomeUsecase _getHomeUsecase;
  final UploadSyndicateCardUsecase _uploadSyndicateCardUsecase;
  final SignOutUsecase _signOutUsecase;
  DoctorModel currentDoctorModel = const DoctorModel();
  int dotsPosition = 0;
  bool? accountVerification;
  String? doctorPatientCount;
  String? doctorScore;
  bool isUnreadNotification = false;
  String isSyndicateCardRequired = '';
  String currentDoctorRole = '';
  String currentUserVersion = '';
  bool getCurrentUserVersion = false;

  HomeModelResponse homeDataModel = const HomeModelResponse(
    data: HomeDataModelResponse(
      allPatients: [],
      currentPatients: [],
      topDoctors: [],
      pendingSyndicateCard: [],
      posts: [],
    ),
  );

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
        '',
        checkUpdateMessageCounter,
        false,
      ),
    ));
  }

  removeDoctorInDoctorsActivation(String doctorId) async {
    if (homeDataModel.data == null ||
        homeDataModel.data!.pendingSyndicateCard == null) {
      debugPrint('No data or pendingSyndicateCard is null');
      return;
    }

    debugPrint(
        'Before removal: ${homeDataModel.data!.pendingSyndicateCard!.length}');
    debugPrint(
        'Doctors before removal: ${homeDataModel.data!.pendingSyndicateCard!.map((d) => d.id)}');

    // Filter out the doctor with the matching doctorId
    final updatedDoctorsActivation = homeDataModel.data!.pendingSyndicateCard!
        .where((doctor) => doctor.id.toString() != doctorId)
        .toList();

    debugPrint('After removal: ${updatedDoctorsActivation.length}');

    // Update homeDataModel with the new list of pendingSyndicateCard
    homeDataModel = homeDataModel.copyWith(
      data: homeDataModel.data!.copyWith(
        pendingSyndicateCard: updatedDoctorsActivation,
      ),
    );

    // Emit the updated state with the new homeDataModel
    emit(
      state.maybeMap(
        orElse: () => state,
        loaded: (value) => HomeState.loaded(
          homeDataModel,
          value.currentDoctorModel,
          value.dotsPosition,
          tabsController.index,
          value.isUploadingSyndicateCard,
          value.isUploadedSyndicateCard,
          '',
          value.checkUpdateMessageCounter,
          value.isUserBlocked,
        ),
      ),
    );
  }

  bool isUpdateMessageHidden = true;

  int checkUpdateMessageCounter = 0;

  getUpdateMessageStatusFromLocal() async {
    if (checkUpdateMessageCounter == 0) {
      isUpdateMessageHidden = (await sl<AppPreferences>()
              .getBool(AppLocalStrings.isUpdateMessageHidden)) ??
          false;
      checkUpdateMessageCounter++;
    }
  }

  setUpdateMessageStatusToLocal() async {
    isUpdateMessageHidden = true;
    (await sl<AppPreferences>()
        .setBool(AppLocalStrings.isUpdateMessageHidden, true));
  }

  getDoctorDataFromLocal() async {
    currentDoctorModel = (await sl<AppPreferences>().getDoctorData())!;
    if (getCurrentUserVersion == false) {
      currentUserVersion = (await sl<AppPreferences>()
          .getString(AppLocalStrings.userAppVersion))!;
      getCurrentUserVersion = true;

      log('$currentUserVersion moatz123');
    }

    // Safely emit state only if the Cubit is not closed
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) => HomeState.loaded(
        value.homeData,
        currentDoctorModel,
        dotsPosition,
        value.homeIndex,
        value.isUploadingSyndicateCard,
        value.isUploadedSyndicateCard,
        '',
        checkUpdateMessageCounter,
        false,
      ),
    ));
  }

  hideHomeHeader(int tabIndex) {
    emit(state.maybeMap(
      orElse: () => state,
      loading: (value) => HomeState.loading(tabIndex),
      loaded: (value) => HomeState.loaded(
        value.homeData,
        value.currentDoctorModel,
        value.dotsPosition,
        tabsController.index,
        value.isUploadingSyndicateCard,
        value.isUploadedSyndicateCard,
        '',
        checkUpdateMessageCounter,
        false,
      ),
    ));
  }

  void changeDotsPositions() {
    emit(
      state.maybeMap(
        orElse: () => state,
        loaded: (value) => HomeState.loaded(
          value.homeData,
          value.currentDoctorModel,
          dotsPosition, // Update dotsPosition
          tabsController.index,
          value.isUploadingSyndicateCard,
          value.isUploadedSyndicateCard,
          '',
          checkUpdateMessageCounter,
          false,
        ),
      ),
    );
  }

  Future<void> getHome() async {
    if (isClosed) return; // Prevents further execution

    dotsPosition = 0;
    emit(HomeState.loading(tabsController.index));

    // Get doctor data from local storage and update messages
    getDoctorDataFromLocal();
    getUpdateMessageStatusFromLocal();

    // Fetch home data from the use case
    final result = await _getHomeUsecase.execute(NoParams());

    result.fold(
      (l) {
        if (!isClosed) {
          emit(HomeState.error(l.message));
        }
      },
      (homeData) async {
        // Update the relevant data
        accountVerification = homeData.verified!;
        isUnreadNotification = int.parse(homeData.unreadCount!) > 0;
        doctorPatientCount = homeData.doctorPatientCount.toString();
        doctorScore = homeData.scoreValue.toString();
        isSyndicateCardRequired = homeData.isSyndicateCardRequired.toString();
        currentDoctorRole = homeData.role.toString();
        homeDataModel = homeData;

        // Only emit new state if the Cubit is still active
        emit(
          HomeState.loaded(
            homeData,
            currentDoctorModel,
            dotsPosition,
            tabsController.index,
            false,
            false,
            '',
            checkUpdateMessageCounter,
            false,
          ),
        );
      },
    );
  }

  File? imagePicked;

  Future<void> uploadSyndicateCard() async {
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
          checkUpdateMessageCounter,
          false,
        ),
      ),
    );

    final picker = ImagePicker();

    try {
      final pickedImage = await picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        final pickedImageFile = File(pickedImage.path);
        imagePicked = pickedImageFile;

        // Optimize the image before uploading
        try {
          File optimizedImage = await optimizeImage(imagePicked!);
          imagePicked = optimizedImage; // Update with the optimized image
        } catch (e) {
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
                'Failed to optimize image: $e',
                checkUpdateMessageCounter,
                false,
              ),
            ),
          );
          return;
        }

        // Proceed with uploading the optimized image
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
                  checkUpdateMessageCounter,
                  false,
                ),
              ),
            );
          },
          (r) async {
            final updatedHomeDataModel =
                homeDataModel.copyWith(isSyndicateCardRequired: 'Pending');
            emit(
              state.maybeMap(
                orElse: () => state,
                loaded: (value) => HomeState.loaded(
                  updatedHomeDataModel,
                  value.currentDoctorModel,
                  value.dotsPosition,
                  tabsController.index,
                  false,
                  true,
                  r.message!,
                  checkUpdateMessageCounter,
                  false,
                ),
              ),
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
              checkUpdateMessageCounter,
              false,
            ),
          ),
        );
      }
    } on PlatformException catch (e) {
      if (e.code == 'photo_access_denied') {
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
              'Photo access denied. Please allow photo access from settings.',
              checkUpdateMessageCounter,
              false,
            ),
          ),
        );

        openAppSettings();
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
              'An unexpected error occurred: ${e.message}',
              checkUpdateMessageCounter,
              false,
            ),
          ),
        );
      }
    } catch (e) {
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
            'An unexpected error occurred: $e',
            checkUpdateMessageCounter,
            false,
          ),
        ),
      );
    }
  }

  signOut() async {
    emit(
      state.maybeMap(
        orElse: () => state,
        loaded: (value) => HomeState.loaded(
          value.homeData,
          value.currentDoctorModel,
          value.dotsPosition,
          tabsController.index,
          value.isUploadingSyndicateCard,
          value.isUploadedSyndicateCard,
          '',
          checkUpdateMessageCounter,
          true,
        ),
      ),
    );
    final result = await _signOutUsecase.execute(NoParams());

    result.fold(
      (l) {
        debugPrint(l.message);
      },
      (r) async {
        await sl<AppPreferences>().removeDoctorData();
      },
    );
  }

  removeNotificationCount() {
    HomeModelResponse updatedHomeDataModel =
        homeDataModel.copyWith(unreadCount: '0');
    emit(
      state.maybeMap(
        orElse: () => state,
        loaded: (value) => HomeState.loaded(
          updatedHomeDataModel,
          value.currentDoctorModel,
          value.dotsPosition,
          tabsController.index,
          value.isUploadingSyndicateCard,
          value.isUploadedSyndicateCard,
          '',
          checkUpdateMessageCounter,
          value.isUserBlocked,
        ),
      ),
    );
  }
}
