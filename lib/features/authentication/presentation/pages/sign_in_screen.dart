import '../../../../exports.dart';
import '../widgets/social_login_buttons.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthenticationCubit cubit = AuthenticationCubit.get(context);
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Center(
            child: Column(
              children: [
                const AuthImage(image: AppImages.signIn),
                SignInForm(cubit: cubit),
                SizedBox(height: 30.h),
                SignInBotton(cubit: cubit),
                SizedBox(height: 20.h),
                const SocialLoginButtons(),
                SizedBox(height: 20.h),
                const DontHaveAnAccountLine(),
                SizedBox(height: 50.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
