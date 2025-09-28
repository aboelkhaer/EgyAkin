import '../../../../exports.dart';
import '../../../../app/services/theme_bloc.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthenticationCubit cubit = AuthenticationCubit.get(context);

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;

        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(0),
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              systemOverlayStyle: isDarkMode
                  ? SystemUiOverlayStyle.light
                  : SystemUiOverlayStyle.dark,
            ),
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Center(
                    child: Column(
                      children: [
                        const AuthImage(image: AppImages.register),
                        RegisterForm(cubit: cubit),
                        SizedBox(height: 20.h),
                        Container(
                          height: 130.h,
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BlocBuilder<AuthenticationCubit,
                                      AuthenticationState>(
                                    builder: (context, state) {
                                      return Checkbox(
                                        value: cubit.isConfirmationChecked,
                                        onChanged: (value) {
                                          cubit.isConfirmationChecked = value!;
                                          cubit.refreshScreen();
                                        },
                                        visualDensity:
                                            VisualDensity.comfortable,
                                      );
                                    },
                                  ),
                                  Text(
                                    '${context.tr(AppStrings.iHaveReadAndAgreeToThe)} ',
                                    style: TextStyle(fontSize: 10.sp),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      launchURL(
                                        url: 'https://egyakin.com/policy',
                                        onError: (error) {
                                          showErrorDialog(context, error);
                                        },
                                      );
                                    },
                                    child: Text(
                                      context.tr(AppStrings.privacyPolicy),
                                      style: TextStyle(
                                          color: Colors.blue, fontSize: 10.sp),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.h),
                              RegisterBotton(cubit: cubit),
                              SizedBox(height: 10.h),
                              const AlreadyHaveAnAccountLine(),
                            ],
                          ),
                        ),
                        SizedBox(height: 30.h),
                      ],
                    ),
                  ),
                ),
              ),
              //
            ],
          ),
        );
      },
    );
  }
}
