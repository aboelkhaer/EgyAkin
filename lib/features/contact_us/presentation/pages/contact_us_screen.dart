import 'package:egy_akin/features/contact_us/presentation/cubit/contact_us_state.dart';
import 'package:egy_akin/app/services/theme_bloc.dart';

import '../../../../exports.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ContactUsCubit cubit = ContactUsCubit.get(context);
    Size size = MediaQuery.of(context).size;

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;

        return Scaffold(
          appBar: AppBar(
            title: Text(context.tr(AppStrings.contactUs)),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  Image.asset(
                    AppImages.appIcon,
                    height: size.height * 0.1,
                    color: isDarkMode ? AppColors.title : null,
                  ),
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  Form(
                    key: cubit.feedbackFormKey,
                    child: SizedBox(
                      height: size.height * 0.2,
                      child: Form(
                        key: cubit.formKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: CustomTextFormField(
                          title: context.tr(AppStrings.content),
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
                              customSnackBar(
                                  context: context, message: message);
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
                                title: context.tr(AppStrings.send),
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
                  // SizedBox(height: 30.h),
                  // const Text(
                  //   'About EgyAkin',
                  //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  // ),
                  // const SizedBox(height: 10),
                  // const Text(
                  //   'EgyAkin is dedicated to empowering Egypt\'s fight against kidney failure with cutting-edge data collection, insights, and community support.',
                  // ),
                  // const SizedBox(height: 20),
                  // const Text(
                  //   'Developer Contact Information',
                  //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  // ),
                  // const SizedBox(height: 10),
                  // const Text(
                  //   'If you have any questions or need support, please contact us at:',
                  // ),
                  // const SizedBox(height: 10),
                  // const Text(
                  //   'Email: support@egyakin.com',
                  //   style: TextStyle(color: Colors.blue),
                  // ),
                  // const Text(
                  //   'Website: www.egyakin.com',
                  //   style: TextStyle(color: Colors.blue),
                  // ),
                  // SizedBox(height: 30.h),
                  // const Text(
                  //   'Attention!',
                  //   style: TextStyle(fontWeight: FontWeight.bold),
                  // ),
                  // SizedBox(height: 10.h),
                  // const Text(
                  //   'Disclaimer: This app provides informational content only and is not a substitute for professional medical advice, diagnosis, or treatment. Always seek the advice of your physician or other qualified health provider with any questions you may have regarding a medical condition.',
                  // ),
                  // SizedBox(height: 50.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
