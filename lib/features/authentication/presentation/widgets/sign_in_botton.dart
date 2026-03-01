import '../../../../exports.dart';

class SignInBotton extends StatelessWidget {
  const SignInBotton({
    super.key,
    required this.cubit,
  });

  final AuthenticationCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        return state.maybeWhen(
          loading: () {
            return const CustomCircularProgressIndicator();
          },
          orElse: () {
            return SizedBox(
              width: double.infinity,
              child: CustomElevatedButton(
                onPressed: () => cubit.signIn(),
                title: context.tr(AppStrings.signIn),
              ),
            );
          },
        );
      },
      listener: (context, state) {
        state.maybeWhen(
          loaded: (doctorData, isSignInSuccess, isRegisterSuccess) {
            if (isSignInSuccess) {
              // sl<NotificationServices>().getDeviceToken().then((value) {
              //   debugPrint('fcmToken: $value');
              //   sl<AppPreferences>()
              //       .setData(AppLocalStrings.fcmTokenKey, value);
              // });
            }
            

            Navigator.of(context)
                .pushReplacementNamed(AppRoutes.home, arguments: 0);

          },
          error: (message) =>
              customSnackBar(message: message, context: context),
          orElse: () => null,
        );
      },
    );
  }
}
