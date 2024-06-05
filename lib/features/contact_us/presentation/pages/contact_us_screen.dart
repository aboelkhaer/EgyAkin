import 'dart:developer';

import 'package:egy_akin/features/contact_us/presentation/cubit/contact_us_cubit.dart';
import 'package:egy_akin/features/contact_us/presentation/cubit/contact_us_state.dart';

import '../../../../exports.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ContactUsCubit cubit = ContactUsCubit.get(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.contactUs),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.06,
              ),
              Image.asset(
                AppImages.logoForSplash,
                height: size.height * 0.2,
                // color: AppColors.title,
              ),
              SizedBox(
                height: size.height * 0.06,
              ),
              Form(
                key: cubit.feedbackFormKey,
                child: SizedBox(
                  height: size.height * 0.2,
                  child: Form(
                    key: cubit.formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: CustomTextFormField(
                      title: AppStrings.content,
                      textInputType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      maxLines: 10,
                      onChanged: (val) {
                        cubit.feedback = val;
                        // if (val == AppStrings.empty) {
                        //   controller.isSendNotEnable(true);
                        // } else {
                        //   controller.isSendNotEnable(false);
                        // }
                      },
                      validator: (value) =>
                          AppValidators.fieldsIsEmptyValidation(value!),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              SizedBox(
                  width: size.width * 0.3,
                  child: BlocConsumer<ContactUsCubit, ContactUsState>(
                    listener: (context, state) {
                      state.maybeWhen(
                        orElse: () {},
                        loaded: (message) {
                          navigatorKey.currentState?.pop();
                          customSnackBar(context: context, message: message);
                        },
                      );
                    },
                    builder: (context, state) {
                      return state.maybeWhen(
                        orElse: () {
                          return CustomElevatedButton(
                            onPressed: () {
                              cubit.addContactUs();
                            },
                            title: AppStrings.send,
                          );
                        },
                        loading: () {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      );
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
