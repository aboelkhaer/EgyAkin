import '../../../../exports.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ResetPasswordCubit cubit = ResetPasswordCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        title:  Text(context.tr(AppStrings.resetPassword),),
      ),
      body: Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: AppColors.primary.withOpacity(0.8),
          ),
        ),
        child: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
          listener: (context, state) {
            state.maybeWhen(
              passwordChagedSuccessfully: () {
                Navigator.of(context).pop();
                customSnackBar(
                    message: context.tr(AppStrings.passwordUpdatedSuccessfully),
                    context: context);
              },
              orElse: () {},
            );
          },
          builder: (context, state) {
            return Stepper(
              type: StepperType.horizontal,
              currentStep: cubit.currentStep,
              controlsBuilder: (context, details) {
                return state.maybeWhen(
                  loading: () {
                    return Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: const CustomCircularProgressIndicator(),
                    );
                  },
                  orElse: () => ResetPasswordBotton(cubit: cubit),
                );
              },
              steps: cubit.getSteps(),
            );
          },
        ),
      ),
    );
  }
}
