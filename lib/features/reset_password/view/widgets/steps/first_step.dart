import '../../../../../exports.dart';

class FirstStep extends GetView<ResetPasswordController> {
  const FirstStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 200,
          child: Image.asset(
            AppImages.reset1,
            fit: BoxFit.cover,
          ),
        ),
        // const Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Flexible(
        //       child: Text(
        //         'Enter the email address you use to sign in to.',
        //         style: TextStyle(
        //             color: AppColors.title,
        //             fontWeight: FontWeight.bold,
        //             fontSize: 18),
        //         textAlign: TextAlign.center,
        //       ),
        //     ),
        //   ],
        // ),
        const SizedBox(height: 20),
        const Row(
          children: [
            Text(
              'Email',
              style: TextStyle(
                  color: AppColors.title, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Form(
          key: controller.firstStepFormKey,
          child: CustomTextFormField(
            title: 'Email',
            textInputType: TextInputType.emailAddress,
            autoFocus: true,
            onChanged: (value) {
              controller.email.value = value;
            },
            textInputAction: TextInputAction.done,
            validator: (value) =>
                controller.registerController.emailValidate(value!),
          ),
        ),
      ],
    );
  }
}
