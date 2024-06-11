import '../../../../exports.dart';

class SubmitButtonForOutcome extends StatelessWidget {
  final OutcomeCubit cubit;
  final String patientId;
  final bool accountVerification;
  final String isSyndicateCardRequired;
  final DoctorModel currentDoctorModel;
  const SubmitButtonForOutcome({
    super.key,
    required this.cubit,
    required this.patientId,
    required this.accountVerification,
    required this.isSyndicateCardRequired,
    required this.currentDoctorModel,
  });

  @override
  Widget build(BuildContext context) {
    if (accountVerification &&
        (isSyndicateCardRequired != 'Required' &&
            isSyndicateCardRequired != 'Pending')) {
      return SizedBox(
        width: double.infinity,
        height: 50,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CustomElevatedButton(
            onPressed: () {
              cubit.submitOutcome(patientId);
            },
            title: AppStrings.submit,
          ),
        ),
      );
    }
    if (accountVerification &&
        (isSyndicateCardRequired == 'Required' ||
            isSyndicateCardRequired == 'Pending')) {
      return SizedBox(
        width: double.infinity,
        height: 50,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CustomElevatedButton(
            onPressed: () {
              showCustomDialog(
                context: context,
                title: 'Syndicate card verification',
                description:
                    'To add outcome you must verify your syndicate card.',
                noColoredButtonOnTap: () {
                  Navigator.of(context).pop();
                },
                coloredButtonText: AppStrings.ok,
                noColoredButtonText: '',
                isNoColorShow: true,
                coloredButtonOnTap: () {
                  Navigator.of(context).pop();
                },
              );
              return;
            },
            title: AppStrings.submit,
            isDisable: false,
          ),
        ),
      );
    }
    if (!accountVerification &&
        (isSyndicateCardRequired == 'Required' ||
            isSyndicateCardRequired == 'Pending')) {
      showCustomDialog(
        context: context,
        title: AppStrings.emailVerification,
        description: AppStrings.toAddPatientsYouMustVerifyYourEmailAddress,
        noColoredButtonOnTap: () {
          Navigator.of(context).pop();
        },
        coloredButtonText: AppStrings.verify,
        noColoredButtonText: AppStrings.cancel,
        coloredButtonOnTap: () {
          Navigator.of(context).pop();
          navigatorKey.currentState?.pushNamed(AppRoutes.emailVerification,
              arguments: AppRoutesArgs.emailVerificationRouteArgs(
                  currentDoctorModel: currentDoctorModel));
        },
      );
    }
    return const SizedBox.shrink();
  }
}
