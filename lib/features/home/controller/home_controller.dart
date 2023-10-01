import '../../../app/constants/local_storage_key.dart';
import '../../../exports.dart';
import '../model/all_patients_home_model.dart';
import 'home_repo.dart';

class HomeController extends GetxController {
  GetStorageLib getStorageLib = Get.find<GetStorageLib>();
  HomeRepository homeRepository = Get.find<HomeRepository>();
  late TextEditingController searchController;

  String? currentDoctorFirstName;
  String? currentDoctorLastName;
  String? currentDoctorJob;
  List<PatientHomeModel>? currentPatinetList = [];
  List<AllPatientHomeModel>? allPatinetList = [];

  @override
  void onInit() {
    searchController = TextEditingController();
    getCurrentDoctorData();
    getCurrentPatientsToList();
    getAllPatientsToList();
    super.onInit();
  }

  @override
  void onClose() {
    // searchController.dispose();
    super.onClose();
  }

  bool isGettingFromLocal = false;

  getCurrentDoctorData() async {
    isGettingFromLocal = true;

    currentDoctorFirstName =
        await getStorageLib.getString(AppLocalStrings.currnetDoctorFirstName);
    currentDoctorLastName =
        await getStorageLib.getString(AppLocalStrings.currentDoctorLastName);
    currentDoctorJob =
        await getStorageLib.getString(AppLocalStrings.currentDoctorJob);
    isGettingFromLocal = true;
    update();
  }

  RxBool isCurrentPatientsLoading = false.obs;
  RxBool isAllPatientsLoading = false.obs;

  getCurrentPatientsToList() async {
    isCurrentPatientsLoading.value = true;
    List<PatientHomeModel>? tessst =
        await homeRepository.getCurrentPatients(isCurrentPatientsLoading);
    currentPatinetList = tessst;
    isCurrentPatientsLoading.value = false;
    update();
  }

  getAllPatientsToList() async {
    isAllPatientsLoading.value = true;
    List<AllPatientHomeModel>? getAllPatientsResponse =
        await homeRepository.getAllPatients(isAllPatientsLoading);
    allPatinetList = getAllPatientsResponse;
    isAllPatientsLoading.value = false;
    update();
  }
}
