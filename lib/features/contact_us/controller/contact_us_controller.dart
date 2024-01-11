import '../../../exports.dart';

class ContactUsController extends GetxController {
  GlobalKey<FormState> feedbackFormKey = GlobalKey<FormState>();
  ContactUsRepository contactUsRepository = Get.find<ContactUsRepository>();

  String feedback = '';
  RxBool isSendNotEnable = true.obs;

  RxBool isContactUsLoading = false.obs;

  addContactUs() async {
    isContactUsLoading(true);

    await contactUsRepository.addContactUs(
        isContactUsLoading: isContactUsLoading, message: feedback);

    isContactUsLoading(false);
    update();
  }
}
