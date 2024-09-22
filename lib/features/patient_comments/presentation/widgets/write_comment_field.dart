import '../../../../exports.dart';

class WriteCommentField extends StatelessWidget {
  const WriteCommentField({
    super.key,
    required this.cubit,
    required this.accountVerification,
    required this.currentDoctorModel,
    required this.patientId,
    required this.isSyndicateCardRequired,
  });

  final PatientCommentsCubit cubit;
  final bool accountVerification;
  final DoctorModel currentDoctorModel;
  final String patientId;
  final String isSyndicateCardRequired;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<PatientCommentsCubit, PatientCommentsState>(
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () {
            return const SizedBox.shrink();
          },
          loaded: (comments, newComment, isLoading, isCommentSuccess, message) {
            return Container(
              height: size.height * 0.13,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                    top: BorderSide(
                  color: Colors.black12,
                )),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0) +
                    const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                        title: AppStrings.writeComment,
                        textInputType: TextInputType.text,
                        enableSuggestions: true,
                        onChanged: (val) {
                          cubit.newComment = val;
                          if (val.trim().isNotEmpty) {
                            cubit.newCommentValueChanged(val);
                          }
                          if (val.trim().isEmpty) {
                            cubit.newCommentValueChanged(val);
                          }
                        },
                        onFieldSubmitted: (val) {
                          if (!accountVerification) {
                            showCustomDialog(
                              context: context,
                              title: AppStrings.emailVerification,
                              description: AppStrings
                                  .toAddCommentYouMustVerifyYourEmailAddress,
                              noColoredButtonOnTap: () {
                                Navigator.of(context).pop();
                              },
                              coloredButtonText: AppStrings.verify,
                              noColoredButtonText: AppStrings.cancel,
                              coloredButtonOnTap: () {
                                Navigator.of(context).pop();
                                navigatorKey.currentState?.pushNamed(
                                  AppRoutes.emailVerification,
                                  arguments:
                                      AppRoutesArgs.emailVerificationRouteArgs(
                                          currentDoctorModel:
                                              currentDoctorModel),
                                );
                              },
                            );
                          }
                          if (accountVerification &&
                              isSyndicateCardRequired != 'Required' &&
                              isSyndicateCardRequired != 'Pending') {
                            cubit.addPatientComments(patientId: patientId);
                          } else {
                            if (isSyndicateCardRequired != 'Required' &&
                                isSyndicateCardRequired != 'Pending') {
                              showCustomDialog(
                                context: context,
                                title: AppStrings.emailVerification,
                                description: AppStrings
                                    .toAddCommentYouMustVerifyYourEmailAddress,
                                noColoredButtonOnTap: () {
                                  Navigator.of(context).pop();
                                },
                                coloredButtonText: AppStrings.verify,
                                noColoredButtonText: AppStrings.cancel,
                                coloredButtonOnTap: () {
                                  Navigator.of(context).pop();
                                  navigatorKey.currentState?.pushNamed(
                                    AppRoutes.emailVerification,
                                    arguments: AppRoutesArgs
                                        .emailVerificationRouteArgs(
                                            currentDoctorModel:
                                                currentDoctorModel),
                                  );
                                },
                              );
                            }
                          }
                          if (accountVerification &&
                              (isSyndicateCardRequired == 'Required' ||
                                  isSyndicateCardRequired == 'Pending')) {
                            showCustomDialog(
                              context: context,
                              title: 'Syndicate card verification',
                              description:
                                  'To add comment you must verify your syndicate card.',
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
                          }
                        },
                        textInputAction: TextInputAction.done,
                        validator: (val) {
                          return null;
                        },
                      ),
                    ),
                    BlocBuilder<PatientCommentsCubit, PatientCommentsState>(
                      builder: (context, state) {
                        return state.maybeWhen(
                          orElse: () {
                            return const SizedBox.shrink();
                          },
                          loaded: (comments, newComment, isLoading,
                              isCommentSuccess, message) {
                            return newComment.trim() == AppStrings.empty
                                ? const SizedBox.shrink()
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          if (!accountVerification) {
                                            showCustomDialog(
                                              context: context,
                                              title:
                                                  AppStrings.emailVerification,
                                              description: AppStrings
                                                  .toAddCommentYouMustVerifyYourEmailAddress,
                                              noColoredButtonOnTap: () {
                                                Navigator.of(context).pop();
                                              },
                                              coloredButtonText:
                                                  AppStrings.verify,
                                              noColoredButtonText:
                                                  AppStrings.cancel,
                                              coloredButtonOnTap: () {
                                                Navigator.of(context).pop();
                                                navigatorKey.currentState
                                                    ?.pushNamed(
                                                  AppRoutes.emailVerification,
                                                  arguments: AppRoutesArgs
                                                      .emailVerificationRouteArgs(
                                                          currentDoctorModel:
                                                              currentDoctorModel),
                                                );
                                              },
                                            );
                                          }
                                          if (accountVerification &&
                                              isSyndicateCardRequired !=
                                                  'Required' &&
                                              isSyndicateCardRequired !=
                                                  'Pending') {
                                            cubit.addPatientComments(
                                                patientId: patientId);
                                          } else {
                                            if (isSyndicateCardRequired !=
                                                    'Required' &&
                                                isSyndicateCardRequired !=
                                                    'Pending') {
                                              showCustomDialog(
                                                context: context,
                                                title: AppStrings
                                                    .emailVerification,
                                                description: AppStrings
                                                    .toAddCommentYouMustVerifyYourEmailAddress,
                                                noColoredButtonOnTap: () {
                                                  Navigator.of(context).pop();
                                                },
                                                coloredButtonText:
                                                    AppStrings.verify,
                                                noColoredButtonText:
                                                    AppStrings.cancel,
                                                coloredButtonOnTap: () {
                                                  Navigator.of(context).pop();
                                                  navigatorKey.currentState
                                                      ?.pushNamed(
                                                    AppRoutes.emailVerification,
                                                    arguments: AppRoutesArgs
                                                        .emailVerificationRouteArgs(
                                                            currentDoctorModel:
                                                                currentDoctorModel),
                                                  );
                                                },
                                              );
                                            }
                                          }
                                          if (accountVerification &&
                                              (isSyndicateCardRequired ==
                                                      'Required' ||
                                                  isSyndicateCardRequired ==
                                                      'Pending')) {
                                            showCustomDialog(
                                              context: context,
                                              title:
                                                  'Syndicate card verification',
                                              description:
                                                  'To add comment you must verify your syndicate card.',
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
                                          }
                                        },
                                        icon: Icon(
                                          Icons.send_outlined,
                                          size: 30,
                                          color: AppColors.primary
                                              .withOpacity(0.7),
                                        ),
                                      ),
                                      SizedBox(
                                        height: size.height * 0.012,
                                      )
                                    ],
                                  );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
