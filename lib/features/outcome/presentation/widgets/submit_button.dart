import '../../../../exports.dart';

class SubmitButtonForOutcome extends StatefulWidget {
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
  _SubmitButtonForOutcomeState createState() => _SubmitButtonForOutcomeState();
}

class _SubmitButtonForOutcomeState extends State<SubmitButtonForOutcome> {
  bool _hasShownDialog = false; // Add a flag to track if the dialog was shown

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Logic to display dialog only if necessary and only once
    if (!_hasShownDialog &&
        !widget.accountVerification &&
        (widget.isSyndicateCardRequired == 'Required' ||
            widget.isSyndicateCardRequired == 'Pending')) {
      _hasShownDialog = true; // Ensure the dialog shows only once

      WidgetsBinding.instance.addPostFrameCallback((_) {
        showCustomDialog(
          context: context,
          title: AppStrings.emailVerification,
          description: AppStrings.toAddOutcomeYouMustVerifyYourEmailAddress,
          noColoredButtonOnTap: () {
            Navigator.of(context).pop();
          },
          coloredButtonText: context.tr(AppStrings.verify),
          noColoredButtonText: context.tr(AppStrings.cancel),
          coloredButtonOnTap: () {
            Navigator.of(context).pop();
            navigatorKey.currentState?.pushNamed(
              AppRoutes.emailVerification,
              arguments: AppRoutesArgs.emailVerificationRouteArgs(
                currentDoctorModel: widget.currentDoctorModel,
              ),
            );
          },
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Case 1: If account verification is true and syndicate card is not required or pending
    if (widget.accountVerification &&
        (widget.isSyndicateCardRequired != 'Required' &&
            widget.isSyndicateCardRequired != 'Pending')) {
      return SizedBox(
        width: double.infinity,
        height: 50,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CustomElevatedButton(
            onPressed: () {
              widget.cubit.submitOutcome(widget.patientId);
            },
            title: context.tr(AppStrings.submit),
          ),
        ),
      );
    }

    // Case 2: If account verification is true but syndicate card is required or pending
    if (widget.accountVerification &&
        (widget.isSyndicateCardRequired == 'Required' ||
            widget.isSyndicateCardRequired == 'Pending')) {
      return SizedBox(
        width: double.infinity,
        height: 50,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CustomElevatedButton(
            onPressed: () {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showCustomDialog(
                  context: context,
                  title: context.tr(AppStrings.syndicateCardVerification),
                  description: context.tr(
                      AppStrings.toAddOutcomeYouMustVerifyYourSyndicateCard),
                  noColoredButtonOnTap: () {
                    Navigator.of(context).pop();
                  },
                  coloredButtonText: context.tr(AppStrings.ok),
                  noColoredButtonText: '',
                  isNoColorShow: true,
                  coloredButtonOnTap: () {
                    Navigator.of(context).pop();
                  },
                );
              });
            },
            title: context.tr(AppStrings.submit),
            isDisable: false,
          ),
        ),
      );
    }

    // Default empty state
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: CustomElevatedButton(
          onPressed: () {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showCustomDialog(
                context: context,
                title: context.tr(AppStrings.emailVerification),
                description: context
                    .tr(AppStrings.toAddOutcomeYouMustVerifyYourEmailAddress),
                noColoredButtonOnTap: () {
                  Navigator.of(context).pop();
                },
                coloredButtonText: context.tr(AppStrings.verify),
                noColoredButtonText: context.tr(AppStrings.cancel),
                coloredButtonOnTap: () {
                  Navigator.of(context).pop();
                  navigatorKey.currentState?.pushNamed(
                      AppRoutes.emailVerification,
                      arguments: AppRoutesArgs.emailVerificationRouteArgs(
                          currentDoctorModel: widget.currentDoctorModel));
                },
              );
            });
          },
          title: context.tr(AppStrings.submit),
        ),
      ),
    );
  }
}
