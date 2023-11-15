import '../../../exports.dart';

class AllPatientsController extends GetxController {
  List<BasePatientModel>? allPatientsList =
      Get.find<HomeController>().allPatinetList;
  HomeController homeController = Get.find<HomeController>();
  ScrollController scrollController = ScrollController();
}
