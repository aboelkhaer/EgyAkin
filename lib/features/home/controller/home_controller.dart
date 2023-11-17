import '../../../app/app_models/notification/base_notification_model.dart';
import '../../../exports.dart';

class HomeController extends GetxController {
  GetStorageLib getStorageLib = Get.find<GetStorageLib>();
  HomeRepository homeRepository = Get.find<HomeRepository>();
  TextEditingController? searchController;
  PageController dotsController = PageController();
  PageController homeScrollController = PageController();
  CarouselController carouselController = CarouselController();
  RxInt dotsPosition = 0.obs;
  int unreadNotificationCount = 0;

  String? currentDoctorFirstName;
  String? currentDoctorLastName;
  String? currentDoctorEmail;
  RxString? currentDoctorScoreValue = ''.obs;
  String? currentDoctorPhone;
  int? currentDoctorId;
  String? currentDoctorAge;
  String? currentDoctorJob;
  String? currentDoctorWorkPlace;
  String? currentDoctorSpecialty;
  String? currentDoctorHighestDegree;
  String? currentDoctorCreatedAt;
  String? currentDoctorUpdatedAt;
  RxList<BasePatientModel>? currentPatinetList = RxList();
  RxList<BasePatientModel>? allPatinetList = RxList();
  RxList<BasePostModel>? postsList = RxList();
  RxList<BaseNotificationModel>? notificationsList = RxList();
  NetworkInfoImpl networkInfo = Get.find<NetworkInfoImpl>();

  void resetTextFieldController() {
    searchController?.dispose();
    searchController = TextEditingController();
  }

  @override
  void onInit() {
    resetTextFieldController();
    homeInit();
    super.onInit();
  }

  RxBool isNetworkConnected = true.obs;
  RxBool isNetworkConnectedLoading = false.obs;

  homeInit() async {
    isNetworkConnectedLoading(true);
    if (await networkInfo.isConnected) {
      isNetworkConnected(true);
      getCurrentDoctorData();
      getCurrentPatientsToList();
      getAllPatientsToList();
      getPosts();
      getNotifications();
    } else {
      isNetworkConnected(false);
    }
    isNetworkConnectedLoading(false);
  }

  @override
  void onClose() {
    searchController?.dispose();
    super.onClose();
  }

  bool isGettingFromLocal = false;

  getCurrentDoctorData() async {
    isGettingFromLocal = true;

    currentDoctorFirstName =
        await getStorageLib.getString(AppLocalStrings.currnetDoctorFirstName);
    currentDoctorLastName =
        await getStorageLib.getString(AppLocalStrings.currentDoctorLastName);
    currentDoctorEmail =
        await getStorageLib.getString(AppLocalStrings.currentDoctorEmail);
    currentDoctorPhone =
        await getStorageLib.getString(AppLocalStrings.currentDoctorPhone);
    currentDoctorAge =
        await getStorageLib.getString(AppLocalStrings.currentDoctorAge);
    currentDoctorJob =
        await getStorageLib.getString(AppLocalStrings.currentDoctorJob);
    currentDoctorWorkPlace = await getStorageLib
        .getString(AppLocalStrings.currentDoctorWorkingPlace);
    currentDoctorSpecialty =
        await getStorageLib.getString(AppLocalStrings.currentDoctorSpecialty);
    currentDoctorHighestDegree = await getStorageLib
        .getString(AppLocalStrings.currentDoctorHighestDegree);
    currentDoctorId =
        await getStorageLib.getInt(AppLocalStrings.currentDoctorId);
    currentDoctorCreatedAt =
        await getStorageLib.getString(AppLocalStrings.currentDoctorCreatedAt);
    currentDoctorUpdatedAt =
        await getStorageLib.getString(AppLocalStrings.currentDoctorUpdatedAt);

    isGettingFromLocal = false;
    update();
  }

  RxBool isCurrentPatientsLoading = false.obs;
  RxBool isAllPatientsLoading = false.obs;

  getCurrentPatientsToList() async {
    isCurrentPatientsLoading.value = true;
    List<BasePatientModel>? tessst =
        await homeRepository.getCurrentPatients(isCurrentPatientsLoading);
    currentPatinetList!.value = tessst!;
    isCurrentPatientsLoading.value = false;
    update();
  }

  getAllPatientsToList() async {
    isAllPatientsLoading.value = true;
    List<BasePatientModel>? getAllPatientsResponse =
        await homeRepository.getAllPatients(isAllPatientsLoading);
    allPatinetList!.value = getAllPatientsResponse!;
    isAllPatientsLoading.value = false;
    update();
  }

  RxBool isPostsLoading = false.obs;

  getPosts() async {
    isPostsLoading(true);
    List<BasePostModel>? containList = await homeRepository.getPosts(
      isPostsLoading: isPostsLoading,
    );

    postsList!.value = containList!;
    isPostsLoading(false);
    update();
  }

  RxBool isNotificationsLoading = false.obs;

  getNotifications() async {
    isNotificationsLoading(true);
    List<BaseNotificationModel>? containList =
        await homeRepository.getNotifications(
      isNotificationsLoading: isNotificationsLoading,
    );

    notificationsList!.value = containList!;

    isNotificationsLoading(false);
    update();
  }
}
