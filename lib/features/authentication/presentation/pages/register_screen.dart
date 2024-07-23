import '../../../../exports.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthenticationCubit cubit = AuthenticationCubit.get(context);
    return Scaffold(
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
                    Container(
                      height: 130.h,
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
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
                                  );
                                },
                              ),
                              Text(
                                'I have read and agree to the ',
                                style: TextStyle(fontSize: 11.5.sp),
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
                                  'Privacy Policy',
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 11.5.sp),
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
  }
}
