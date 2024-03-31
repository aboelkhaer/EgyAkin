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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RegisterBotton(
                            cubit: cubit,
                          ),
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
