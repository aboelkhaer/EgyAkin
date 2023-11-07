import '../../../exports.dart';

class CurrentPatientsController extends GetxController {
  List<BasePatientModel>? currentPatientsList =
      Get.find<HomeController>().currentPatinetList;
  HomeController homeController = Get.find<HomeController>();
  ScrollController currentPatientsScrollController = ScrollController();
  int listOfLingth = 6;

  @override
  void onInit() {
    addItems();
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  addItems() async {
    currentPatientsScrollController.addListener(() {
      if (currentPatientsScrollController.position.maxScrollExtent ==
          currentPatientsScrollController.position.pixels) {
        for (int i = 0; i < 2; i++) {
          listOfLingth++;
          currentPatientsList!.add(currentPatientsList![listOfLingth + 1]);
          update();
        }
      }
    });
  }
}
