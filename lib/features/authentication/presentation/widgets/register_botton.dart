import '../../../../exports.dart';

class RegisterBotton extends StatelessWidget {
  final AuthenticationCubit cubit;
  const RegisterBotton({
    super.key,
    required this.cubit,
  });

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
                onPressed: () async => await cubit.register(),
                title: AppStrings.register,
              ),
            );
          },
        );
      },
      listener: (context, state) {
        state.maybeWhen(
          loaded: (doctorData, isSignInSuccess, isRegisterSuccess) {
            // if (isRegisterSuccess) {
            //   sl<NotificationServices>().getDeviceToken().then((value) {
            //     debugPrint('fcmToken: $value');
            //     sl<AppPreferences>()
            //         .setData(AppLocalStrings.fcmTokenKey, value);
            //   });
            // }

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
