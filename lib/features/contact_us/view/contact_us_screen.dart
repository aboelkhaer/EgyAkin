import '../../../exports.dart';
import '../controller/contact_us_controller.dart';

class ContactUsScreen extends GetView<ContactUsController> {
  ContactUsScreen({super.key});

  @override
  final ContactUsController controller = Get.put(ContactUsController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text('Contact us'),
      ),
      body: Center(
        child: Obx(
          () => controller.isContactUsLoading.value
              ? const CircularProgressIndicator(
                  color: AppColors.primary,
                )
              : SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Form(
                          key: controller.feedbackFormKey,
                          child: SizedBox(
                            height: size.height * 0.2,
                            child: CustomTextFormField(
                              title: 'Feedback',
                              textInputType: TextInputType.multiline,
                              textInputAction: TextInputAction.newline,
                              maxLines: 10,
                              onChanged: (val) {
                                controller.feedback = val;
                                if (val == '') {
                                  controller.isSendNotEnable(true);
                                } else {
                                  controller.isSendNotEnable(false);
                                }
                              },
                              validator: (val) {
                                return null;
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: size.width * 0.3,
                          child: Obx(
                            () => CustomElevatedButton(
                              size: size,
                              onPressed: () {
                                if (controller.feedback.trim() != '') {
                                  controller.addContactUs();
                                }
                              },
                              title: 'Send',
                              isDisable: controller.isSendNotEnable.value,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
