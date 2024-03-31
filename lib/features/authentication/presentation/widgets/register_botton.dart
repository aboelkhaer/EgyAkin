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
          loaded: (doctorData) {
            Navigator.of(context).pushReplacementNamed(AppRoutes.home);
          },
          error: (message) =>
              customSnackBar(message: message, context: context),
          orElse: () => null,
        );
      },
    );
  }
}
