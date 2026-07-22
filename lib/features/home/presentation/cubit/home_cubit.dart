import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:egy_akin/app/constants/local_storage_key.dart';
import 'package:egy_akin/app/routes/app_routes.dart';
import 'package:egy_akin/app/services/local_storage.dart';
import 'package:egy_akin/app/shared/functions/app_routes_args.dart';
import 'package:egy_akin/app/shared/functions/permissions_helper.dart';
import 'package:egy_akin/app/shared/permissions/app_permissions.dart';
import 'package:egy_akin/app/shared/functions/app_update_message_utils.dart';
import 'package:egy_akin/app/shared/functions/reduce_image_resolution.dart';
import 'package:egy_akin/app/utilities/base_usecase.dart';
import 'dart:convert';
import 'package:egy_akin/features/authentication/data/models/authentication_model_response.dart';
import 'package:egy_akin/features/home/data/models/home_model_response.dart';
import 'package:egy_akin/features/home/domain/usecases/get_home_usecase.dart';
import 'package:egy_akin/features/home/domain/usecases/get_role_permissions_usecase.dart';
import 'package:egy_akin/features/home/domain/usecases/upload_syndicate_card_usecase.dart';
import 'package:egy_akin/features/home/presentation/cubit/home_state.dart';
import 'package:egy_akin/features/profile/domain/usecases/sign_out_usecase.dart';
import 'package:egy_akin/injection_container.dart';
import 'package:egy_akin/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(
    this._getHomeUsecase,
    this._uploadSyndicateCardUsecase,
    this._signOutUsecase,
    this._getRolePermissionsUsecase,
  ) : super(const HomeState.initial());
  static HomeCubit get(context) => BlocProvider.of(context);
  PersistentTabController tabsController =
      PersistentTabController(initialIndex: 0);
  CarouselSliderController carouselController = CarouselSliderController();
  late ScrollController homeTabScrollController;
  final GetHomeUsecase _getHomeUsecase;
  final UploadSyndicateCardUsecase _uploadSyndicateCardUsecase;
  final SignOutUsecase _signOutUsecase;
  final GetRolePermissionsUsecase _getRolePermissionsUsecase;
  DoctorModel currentDoctorModel = const DoctorModel();
  int dotsPosition = 0;
  int _cacheClearCounter = 0;
  bool? accountVerification;
  String? doctorPatientCount;
  String? doctorScore;
  bool isUnreadNotification = false;
  String isSyndicateCardRequired = '';
  String currentDoctorRole = '';
  String currentUserVersion = '';
  String currentUserBuildNumber = '';
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
        value.changesCounter,
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
          value.changesCounter,
        ),
      ),
    );
  }

  bool shouldShowUpdateMessage = false;

  int checkUpdateMessageCounter = 0;

  getUpdateMessageStatusFromLocal() async {
    if (checkUpdateMessageCounter == 0) {
      shouldShowUpdateMessage =
          await AppUpdateMessageUtils.shouldShow(sl<AppPreferences>());
      checkUpdateMessageCounter++;
    }
  }

  setUpdateMessageStatusToLocal() async {
    shouldShowUpdateMessage = false;
    await AppUpdateMessageUtils.markDismissed(sl<AppPreferences>());
  }

  getDoctorDataFromLocal() async {
    currentDoctorModel = (await sl<AppPreferences>().getDoctorData())!;
    if (getCurrentUserVersion == false) {
      currentUserVersion = (await sl<AppPreferences>()
          .getString(AppLocalStrings.userAppVersion))!;

      // Get build number from package info
      try {
        final packageInfo = await PackageInfo.fromPlatform();
        currentUserBuildNumber = packageInfo.buildNumber;
      } catch (e) {
        debugPrint('Failed to get build number: $e');
        currentUserBuildNumber = '';
      }

      getCurrentUserVersion = true;
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
        value.changesCounter,
      ),
    ));
  }

  bool? isExistVerificationBanner;

  checkVerifyBanner() async {
    isExistVerificationBanner = (await sl<AppPreferences>()
            .getBool(AppLocalStrings.isExistVerificationBanner)) ??
        false;
  }

  int changesCounter = 0;
  setVerifyBanner() async {
    isExistVerificationBanner = (await sl<AppPreferences>()
        .setBool(AppLocalStrings.isExistVerificationBanner, true));

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
        value.checkUpdateMessageCounter,
        value.isUserBlocked,
        changesCounter + 1,
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
        value.changesCounter,
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
          false, value.changesCounter,
        ),
      ),
    );
  }

  clearCacheForNetworkImages() async {
    try {
      await CachedNetworkImage.evictFromCache('');
      await DefaultCacheManager().emptyCache();
      debugPrint('Cache cleared successfully');
    } catch (e) {
      debugPrint('Error clearing cache: $e');
    }
  }

  Future<void> getHome() async {
    if (isClosed) return; // Prevents further execution

    // Clear cached network images every 5 calls
    _cacheClearCounter++;
    if (_cacheClearCounter >= 5) {
      clearCacheForNetworkImages();
      _cacheClearCounter = 0; // Reset counter
      debugPrint('Cache cleared after 5 calls');
    }

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

        // Keep local doctor userType in sync with the latest value from home
        if (homeData.userType != null && homeData.userType!.isNotEmpty) {
          final localDoctor = await sl<AppPreferences>().getDoctorData();
          if (localDoctor != null &&
              localDoctor.userType != homeData.userType) {
            final updatedDoctor =
                localDoctor.copyWith(userType: homeData.userType);
            await sl<AppPreferences>().setDoctorData(updatedDoctor);
          }
        }

        checkVerifyBanner();

        // Fetch and save permissions when missing (e.g. after register) or when backend says they changed
        final permissionsJson =
            await sl<AppPreferences>().getString(AppLocalStrings.permissions);
        final hasNoPermissions =
            permissionsJson == null || permissionsJson.isEmpty;
        if (hasNoPermissions || homeData.permissionsChanged == true) {
          await _updatePermissions();
        }

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
            changesCounter,
          ),
        );
      },
    );
    // Check if user has accessHome permission
    final hasAccessHome =
        await PermissionHelper.hasPermission(AppPermissions.accessHome);
    if (!hasAccessHome) {
      navigatorKey.currentState?.pushNamed(
        AppRoutes.community,
        arguments: AppRoutesArgs.communityRouteArgs(
          homeDataModel: homeDataModel,
          currentDoctorModel: currentDoctorModel,
          initialTab: 0,
        ),
      );
    }
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
          value.changesCounter,
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
                value.changesCounter,
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
                  value.changesCounter,
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
                  value.changesCounter,
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
              value.changesCounter,
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
              value.changesCounter,
            ),
          ),
        );

        // openAppSettings();
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
              value.changesCounter,
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
            value.changesCounter,
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
          value.changesCounter,
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

  signOutForUnUnauthenticated() async {
    await sl<AppPreferences>().removeDoctorData();
  }

  removeNotificationCount() {
    log('done');
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
          value.changesCounter,
        ),
      ),
    );
  }

  Future<void> _updatePermissions() async {
    final result = await _getRolePermissionsUsecase.execute(NoParams());

    await result.fold<Future<void>>(
      (l) async {
        debugPrint('Error updating permissions: ${l.message}');
      },
      (response) async {
        // Save permissions to local storage
        if (response.permissions != null && response.permissions!.isNotEmpty) {
          final permissionsJson = jsonEncode(response.permissions!);
          await sl<AppPreferences>()
              .setData(AppLocalStrings.permissions, permissionsJson);
          // Refresh permission cache
          await PermissionHelper.refreshPermissions();
          debugPrint('Permissions updated successfully');
        }
      },
    );
  }
}
