import 'package:egy_akin/exports.dart';

class FirstStep extends StatelessWidget {
  const FirstStep({super.key});

  @override
  Widget build(BuildContext context) {
    ResetPasswordCubit cubit = ResetPasswordCubit.get(context);
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
        const SizedBox(height: 20),
         Row(
          children: [
            Text(
              context.tr(AppStrings.email), 
              style: TextStyle(
                  color: AppColors.title, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Form(
          key: cubit.firstStepFormKey,
          child: CustomTextFormField(
            title: context.tr(AppStrings.email),
            textInputType: TextInputType.emailAddress,
            autoFocus: true,
            onChanged: (value) {
              cubit.email = value;
            },
            textInputAction: TextInputAction.done,
            validator: (value) => AppValidators.emailValidator(value!),
          ),
        ),
      ],
    );
  }
}
