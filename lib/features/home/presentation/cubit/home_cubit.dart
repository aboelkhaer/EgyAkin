import 'dart:async';
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
import 'package:egy_akin/app/shared/functions/local_profile_image_helper.dart';
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
  // keepScrollOffset: false — HomeCubit is a singleton. After route rebuilds,
  // restoring the old offset puts the dashboard/skeleton mid-page.
  ScrollController homeTabScrollController =
      ScrollController(keepScrollOffset: false);

  /// Bumped whenever home reload shows the skeleton so the scroll view remounts at 0.
  int homeScrollEpoch = 0;

  void resetHomeTabScrollToTop() {
    final controller = homeTabScrollController;
    if (!controller.hasClients) return;
    for (final position in List<ScrollPosition>.from(controller.positions)) {
      if (position.pixels != 0) {
        position.jumpTo(0);
      }
    }
  }

  void prepareHomeTabScrollForReload() {
    homeScrollEpoch++;
    resetHomeTabScrollToTop();
  }

  /// `user_type == normal` → no Home / Patients tabs; Community is the root.
  /// Prefer local doctor type so loading UI matches before home API returns.
  bool get hideClinicalTabs {
    final type =
        (currentDoctorModel.userType ?? homeDataModel.userType ?? '')
            .trim()
            .toLowerCase();
    return type == 'normal';
  }

  bool get showClinicalTabs => !hideClinicalTabs;

  /// Clinical: Home(0) Patients(1) Community(2) Profile(3)
  /// Normal:   Community(0) Notifications(1) Profile(2)
  int get communityTabIndex => hideClinicalTabs ? 0 : 2;
  int get notificationsTabIndex => 1; // only used when hideClinicalTabs
  int get profileTabIndex => hideClinicalTabs ? 2 : 3;
  int get patientsTabIndex => 1;
  int get homeTabIndex => 0;

  /// Maps legacy full-nav indices (routes still use 0..4 with old Inbox at 3)
  /// onto the active bar (Inbox removed for all users).
  int mapNavPage(int page) {
    if (showClinicalTabs) {
      switch (page) {
        case 0:
          return homeTabIndex;
        case 1:
          return patientsTabIndex;
        case 2:
          return communityTabIndex;
        case 3:
          // Legacy inbox → community (inbox tab removed).
          return communityTabIndex;
        case 4:
          return profileTabIndex;
        default:
          if (page < 0) return 0;
          return profileTabIndex;
      }
    }
    switch (page) {
      case 3:
        return notificationsTabIndex;
      case 4:
        return profileTabIndex;
      case 0:
      case 1:
      case 2:
      default:
        return communityTabIndex;
    }
  }

  void jumpToCommunityTab() {
    jumpToTabSafe(communityTabIndex);
  }

  void jumpToProfileTab() {
    jumpToTabSafe(profileTabIndex);
  }

  void jumpToNotificationsTab() {
    if (!hideClinicalTabs) return;
    jumpToTabSafe(notificationsTabIndex);
  }

  void jumpToPatientsTab() {
    if (hideClinicalTabs) {
      jumpToCommunityTab();
      return;
    }
    jumpToTabSafe(patientsTabIndex);
  }

  int get _maxTabIndex => hideClinicalTabs ? 2 : 3;

  /// Keeps PersistentTabController inside the active nav length (avoids
  /// RangeError when switching medical_statistics → normal).
  void jumpToTabSafe(int index) {
    if (isClosed) return;
    final safe = index.clamp(0, _maxTabIndex);
    if (tabsController.index != safe) {
      tabsController.jumpToTab(safe);
    }
    hideHomeHeader(safe);
  }

  /// Remaps a leftover full-nav index after the tab set changes.
  void clampTabIndexToCurrentNav({int? preferLegacyPage}) {
    if (isClosed) return;
    if (preferLegacyPage != null) {
      jumpToTabSafe(mapNavPage(preferLegacyPage));
      return;
    }
    if (tabsController.index > _maxTabIndex) {
      jumpToTabSafe(mapNavPage(tabsController.index));
    }
  }

  /// After profile role change, sync type and land on Profile safely.
  Future<void> applyProfileUpdateAndOpenProfile() async {
    await getDoctorDataFromLocal(emitState: false);
    final type = currentDoctorModel.userType;
    if (type != null && type.isNotEmpty) {
      homeDataModel = homeDataModel.copyWith(userType: type);
    }
    // Jump while still remapping — profile is legacy page 4 → index 2 for normal.
    jumpToTabSafe(profileTabIndex);
    if (isClosed) return;
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) => HomeState.loaded(
        homeDataModel,
        currentDoctorModel,
        value.dotsPosition,
        tabsController.index.clamp(0, _maxTabIndex),
        value.isUploadingSyndicateCard,
        value.isUploadedSyndicateCard,
        '',
        checkUpdateMessageCounter,
        value.isUserBlocked,
        value.changesCounter + 1,
      ),
      loading: (_) => HomeState.loading(
        tabsController.index.clamp(0, _maxTabIndex),
      ),
    ));
  }

  /// Bumped when home "Add outcomes → View all" should open Patients tab
  /// filtered to the current doctor's patients without an outcome.
  final ValueNotifier<int> withoutOutcomeFilterSignal = ValueNotifier(0);
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

  getDoctorDataFromLocal({bool emitState = true}) async {
    final localDoctor = await sl<AppPreferences>().getDoctorData();
    if (localDoctor == null) return;
    currentDoctorModel = localDoctor;
    unawaited(
      LocalProfileImageHelper.ensureCached(currentDoctorModel.image),
    );
    if (getCurrentUserVersion == false) {
      currentUserVersion = (await sl<AppPreferences>()
              .getString(AppLocalStrings.userAppVersion)) ??
          '';

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

    if (!emitState || isClosed) return;

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
        value.changesCounter + 1,
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
    if (isClosed) return;
    final safeIndex = tabIndex.clamp(0, _maxTabIndex);
    if (tabIndex == 0) {
      resetHomeTabScrollToTop();
    }
    emit(state.maybeMap(
      orElse: () => state,
      loading: (value) => HomeState.loading(safeIndex),
      loaded: (value) => HomeState.loaded(
        value.homeData,
        value.currentDoctorModel,
        value.dotsPosition,
        safeIndex,
        value.isUploadingSyndicateCard,
        value.isUploadedSyndicateCard,
        '',
        checkUpdateMessageCounter,
        false,
        value.changesCounter,
      ),
    ));
  }

  /// Patients tab (index 1) + my patients missing an outcome.
  void openMyPatientsWithoutOutcome() {
    if (hideClinicalTabs) return;
    jumpToPatientsTab();
    withoutOutcomeFilterSignal.value++;
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

  Future<void> getHome({bool showLoading = true}) async {
    if (isClosed) return;

    _cacheClearCounter++;
    if (_cacheClearCounter >= 5) {
      clearCacheForNetworkImages();
      _cacheClearCounter = 0;
      debugPrint('Cache cleared after 5 calls');
    }

    dotsPosition = 0;

    // Resolve user_type before emitting loading so normal users never see
    // Home / Patients tabs during the skeleton state.
    await getDoctorDataFromLocal(emitState: false);

    final alreadyLoaded = state.maybeWhen(
      loaded: (
        _,
        __,
        ___,
        ____,
        _____,
        ______,
        _______,
        ________,
        _________,
        __________,
      ) =>
          true,
      orElse: () => false,
    );

    // Skeleton on every fetch (first load + pull-to-refresh).
    if (!alreadyLoaded || showLoading) {
      prepareHomeTabScrollForReload();
      // Don't force Community on reload — only clamp out-of-range indices
      // (e.g. profile was 4 before switching to the 3-tab normal nav).
      clampTabIndexToCurrentNav();
      emit(HomeState.loading(tabsController.index.clamp(0, _maxTabIndex)));
    }

    try {
      await getUpdateMessageStatusFromLocal();

      final result = await _getHomeUsecase.execute(NoParams());

      await result.fold<Future<void>>(
        (l) async {
          if (isClosed) return;
          // Keep previous dashboard visible on refresh failure.
          if (alreadyLoaded) {
            _emitLoaded(
              homeData: homeDataModel,
              message: l.message,
            );
          } else {
            emit(HomeState.error(l.message));
          }
        },
        (homeData) async {
          if (isClosed) return;

          accountVerification = homeData.verified ?? accountVerification;
          final unreadRaw = homeData.unreadCount;
          isUnreadNotification =
              unreadRaw != null && (int.tryParse(unreadRaw) ?? 0) > 0;
          doctorPatientCount = homeData.doctorPatientCount?.toString();
          doctorScore = homeData.scoreValue?.toString();
          isSyndicateCardRequired =
              homeData.isSyndicateCardRequired?.toString() ??
                  isSyndicateCardRequired;
          currentDoctorRole =
              homeData.role?.toString() ?? currentDoctorRole;
          homeDataModel = homeData;

          if (homeData.userType != null && homeData.userType!.isNotEmpty) {
            final localDoctor = await sl<AppPreferences>().getDoctorData();
            if (localDoctor != null &&
                localDoctor.userType != homeData.userType) {
              final updatedDoctor =
                  localDoctor.copyWith(userType: homeData.userType);
              await sl<AppPreferences>().setDoctorData(updatedDoctor);
              currentDoctorModel = updatedDoctor;
            }
          }

          await checkVerifyBanner();

          final permissionsJson =
              await sl<AppPreferences>().getString(AppLocalStrings.permissions);
          final hasNoPermissions =
              permissionsJson == null || permissionsJson.isEmpty;
          if (hasNoPermissions || homeData.permissionsChanged == true) {
            await _updatePermissions();
          }

          if (!isClosed) {
            _emitLoaded(homeData: homeData);
          }
        },
      );
    } catch (e, st) {
      debugPrint('getHome failed: $e\n$st');
      if (isClosed) return;
      if (alreadyLoaded) {
        _emitLoaded(homeData: homeDataModel);
      } else {
        emit(HomeState.error(e.toString()));
      }
    }

    // Only redirect once when home cannot be accessed — not on every refresh.
    if (!alreadyLoaded) {
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
  }

  void _emitLoaded({
    required HomeModelResponse homeData,
    String message = '',
  }) {
    changesCounter += 1;
    resetHomeTabScrollToTop();
    emit(
      HomeState.loaded(
        homeData,
        currentDoctorModel,
        dotsPosition,
        tabsController.index,
        false,
        false,
        message,
        checkUpdateMessageCounter,
        false,
        changesCounter,
      ),
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
    final isBlockedAccount = state.maybeWhen(
      loaded: (
        homeData,
        _,
        __,
        ___,
        ____,
        _____,
        ______,
        _______,
        ________,
        _________,
      ) =>
          homeData.isUserBlocked == true,
      orElse: () => false,
    );

    // Blocked accounts often get 403 on /logout — skip the call and
    // clear the local session so sign-in does not keep firing auth errors.
    if (!isBlockedAccount) {
      final result = await _signOutUsecase.execute(NoParams());
      result.fold(
        (l) => debugPrint('Logout failed: ${l.message}'),
        (_) {},
      );
    }

    await _clearSignedInSession();

    // Drop stale home payload (e.g. isUserBlocked: true) from this singleton
    // cubit so the next login does not reopen the blocked dialog.
    currentDoctorModel = const DoctorModel();
    homeDataModel = const HomeModelResponse(
      data: HomeDataModelResponse(
        allPatients: [],
        currentPatients: [],
        topDoctors: [],
        pendingSyndicateCard: [],
        posts: [],
      ),
    );
    accountVerification = null;
    isSyndicateCardRequired = '';
    currentDoctorRole = '';
    isUnreadNotification = false;
    emit(const HomeState.initial());

    navigatorKey.currentState?.pushReplacementNamed(AppRoutes.signIn);
  }

  Future<void> _clearSignedInSession() async {
    await sl<AppPreferences>().removeDoctorData();
    await sl<AppPreferences>().removeData(AppLocalStrings.permissions);
    PermissionHelper.clearCache();
    try {
      await LocalProfileImageHelper.clear();
    } catch (_) {}
  }

  signOutForUnUnauthenticated() async {
    await _clearSignedInSession();
    currentDoctorModel = const DoctorModel();
    homeDataModel = const HomeModelResponse(
      data: HomeDataModelResponse(
        allPatients: [],
        currentPatients: [],
        topDoctors: [],
        pendingSyndicateCard: [],
        posts: [],
      ),
    );
    emit(const HomeState.initial());
  }

  removeNotificationCount() {
    isUnreadNotification = false;
    homeDataModel = homeDataModel.copyWith(unreadCount: '0');
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
