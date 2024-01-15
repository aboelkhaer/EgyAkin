import '../../../exports.dart';

class ContactUsScreen extends GetView<ContactUsController> {
  ContactUsScreen({super.key});

  @override
  final ContactUsController controller = Get.put(ContactUsController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.contactUs),
      ),
      body: Obx(
        () => controller.isContactUsLoading.value
            ? const CircularProgressIndicator(
                color: AppColors.primary,
              )
            : SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: size.height * 0.06,
                      ),
                      Image.asset(
                        AppImages.blackLogoWithoutDes,
                        height: size.height * 0.2,
                        color: AppColors.title,
                      ),
                      SizedBox(
                        height: size.height * 0.06,
                      ),
                      Form(
                        key: controller.feedbackFormKey,
                        child: SizedBox(
                          height: size.height * 0.2,
                          child: CustomTextFormField(
                            title: AppStrings.feedback,
                            textInputType: TextInputType.multiline,
                            textInputAction: TextInputAction.newline,
                            maxLines: 10,
                            onChanged: (val) {
                              controller.feedback = val;
                              if (val == AppStrings.empty) {
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
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      SizedBox(
                        width: size.width * 0.3,
                        child: Obx(
                          () => CustomElevatedButton(
                            size: size,
                            onPressed: () {
                              if (controller.feedback.trim() !=
                                  AppStrings.empty) {
                                controller.addContactUs();
                              }
                            },
                            title: AppStrings.send,
                            isDisable: controller.isSendNotEnable.value,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
