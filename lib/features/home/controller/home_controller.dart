import '../../../exports.dart';

class HomeController extends GetxController {
  GetStorageLib getStorageLib = Get.find<GetStorageLib>();
  HomeRepository homeRepository = Get.find<HomeRepository>();
  TextEditingController? searchController;

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

  homeInit() {
    getCurrentDoctorData();
    getCurrentPatientsToList();
    getAllPatientsToList();
    getPosts();
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

    isGettingFromLocal = true;
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
}
