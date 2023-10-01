import 'package:egyakin/exports.dart';
import 'package:egyakin/features/home/model/all_patients_home_model.dart';

class AllPatientsController extends GetxController {
  List<AllPatientHomeModel>? allPatientsList =
      Get.find<HomeController>().allPatinetList;
  HomeController homeController = Get.find<HomeController>();
}
