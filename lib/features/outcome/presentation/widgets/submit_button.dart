import 'package:egy_akin/app/shared/widgets/professional_submit_button.dart';

import '../../../../exports.dart';

class SubmitButtonForOutcome extends StatefulWidget {
  final OutcomeCubit cubit;
  final String patientId;
  final bool accountVerification;
  final String isSyndicateCardRequired;
  final DoctorModel currentDoctorModel;
  final bool isDark;
  final bool isLoading;

  const SubmitButtonForOutcome({
    super.key,
    required this.cubit,
    required this.patientId,
    required this.accountVerification,
    required this.isSyndicateCardRequired,
    required this.currentDoctorModel,
    required this.isDark,
    this.isLoading = false,
  });

  @override
  State<SubmitButtonForOutcome> createState() => _SubmitButtonForOutcomeState();
}

class _SubmitButtonForOutcomeState extends State<SubmitButtonForOutcome> {
  bool _hasShownDialog = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_hasShownDialog &&
        !widget.accountVerification &&
        (widget.isSyndicateCardRequired == 'Required' ||
            widget.isSyndicateCardRequired == 'Pending')) {
      _hasShownDialog = true;

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

  VoidCallback get _onPressed {
    if (widget.accountVerification &&
        widget.isSyndicateCardRequired != 'Required' &&
        widget.isSyndicateCardRequired != 'Pending') {
      return () => widget.cubit.submitOutcome(widget.patientId);
    }

    if (widget.accountVerification &&
        (widget.isSyndicateCardRequired == 'Required' ||
            widget.isSyndicateCardRequired == 'Pending')) {
      return () {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showCustomDialog(
            context: context,
            title: context.tr(AppStrings.syndicateCardVerification),
            description: context.tr(
              AppStrings.toAddOutcomeYouMustVerifyYourSyndicateCard,
            ),
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
      };
    }

    return () {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showCustomDialog(
          context: context,
          title: context.tr(AppStrings.emailVerification),
          description: context.tr(
            AppStrings.toAddOutcomeYouMustVerifyYourEmailAddress,
          ),
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
    };
  }

  @override
  Widget build(BuildContext context) {
    return ProfessionalSubmitBar(
      isDark: widget.isDark,
      isLoading: widget.isLoading,
      onPressed: _onPressed,
      label: context.tr(AppStrings.submit),
      subtitle: context.tr(AppStrings.saveOutcomeAnswers),
    );
  }
}
