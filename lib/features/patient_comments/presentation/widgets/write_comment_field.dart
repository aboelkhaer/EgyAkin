import 'package:egy_akin/app/services/theme_bloc.dart';
import 'package:egy_akin/app/shared/permissions/permission_guard.dart';
import 'package:egy_akin/app/shared/permissions/app_permissions.dart';
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
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;
        Size size = MediaQuery.of(context).size;

        return BlocBuilder<PatientCommentsCubit, PatientCommentsState>(
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () {
                return const SizedBox.shrink();
              },
              loaded:
                  (comments, newComment, isLoading, isCommentSuccess, message) {
                return PermissionGuard(
                  permission: AppPermissions.createPatientComment,
                  fallback: const SizedBox.shrink(),
                  child: Container(
                    height: size.height * 0.13,
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isDarkMode ? AppColors.darkCardBG : Colors.white,
                      border: Border(
                          top: BorderSide(
                        color:
                            isDarkMode ? AppColors.darkBorder : Colors.black12,
                      )),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: CustomTextFormField(
                              title: context.tr(AppStrings.writeComment),
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
                                    title: context
                                        .tr(AppStrings.emailVerification),
                                    description: context.tr(AppStrings
                                        .toAddCommentYouMustVerifyYourEmailAddress),
                                    noColoredButtonOnTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    coloredButtonText:
                                        context.tr(AppStrings.verify),
                                    noColoredButtonText:
                                        context.tr(AppStrings.cancel),
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
                                if (accountVerification &&
                                    isSyndicateCardRequired != 'Required' &&
                                    isSyndicateCardRequired != 'Pending') {
                                  cubit.addPatientComments(
                                      patientId: patientId);
                                } else {
                                  if (isSyndicateCardRequired != 'Required' &&
                                      isSyndicateCardRequired != 'Pending') {
                                    showCustomDialog(
                                      context: context,
                                      title: context
                                          .tr(AppStrings.emailVerification),
                                      description: context.tr(AppStrings
                                          .toAddCommentYouMustVerifyYourEmailAddress),
                                      noColoredButtonOnTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      coloredButtonText:
                                          context.tr(AppStrings.verify),
                                      noColoredButtonText:
                                          context.tr(AppStrings.cancel),
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
                                    title: context.tr(
                                        AppStrings.syndicateCardVerification),
                                    description: context.tr(AppStrings
                                        .toAddCommentYouMustVerifyYourSyndicateCard),
                                    noColoredButtonOnTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    coloredButtonText:
                                        context.tr(AppStrings.ok),
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
                          BlocBuilder<PatientCommentsCubit,
                              PatientCommentsState>(
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                if (!accountVerification) {
                                                  showCustomDialog(
                                                    context: context,
                                                    title: context.tr(AppStrings
                                                        .emailVerification),
                                                    description: context.tr(
                                                        AppStrings
                                                            .toAddCommentYouMustVerifyYourEmailAddress),
                                                    noColoredButtonOnTap: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    coloredButtonText: context
                                                        .tr(AppStrings.verify),
                                                    noColoredButtonText: context
                                                        .tr(AppStrings.cancel),
                                                    coloredButtonOnTap: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                      navigatorKey.currentState
                                                          ?.pushNamed(
                                                        AppRoutes
                                                            .emailVerification,
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
                                                      title: context.tr(AppStrings
                                                          .emailVerification),
                                                      description: context.tr(
                                                          AppStrings
                                                              .toAddCommentYouMustVerifyYourEmailAddress),
                                                      noColoredButtonOnTap: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      coloredButtonText:
                                                          context.tr(AppStrings
                                                              .verify),
                                                      noColoredButtonText:
                                                          context.tr(AppStrings
                                                              .cancel),
                                                      coloredButtonOnTap: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                        navigatorKey
                                                            .currentState
                                                            ?.pushNamed(
                                                          AppRoutes
                                                              .emailVerification,
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
                                                    title: context.tr(AppStrings
                                                        .syndicateCardVerification),
                                                    description: context.tr(
                                                        AppStrings
                                                            .toAddCommentYouMustVerifyYourSyndicateCard),
                                                    noColoredButtonOnTap: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    coloredButtonText: context
                                                        .tr(AppStrings.ok),
                                                    noColoredButtonText: '',
                                                    isNoColorShow: true,
                                                    coloredButtonOnTap: () {
                                                      Navigator.of(context)
                                                          .pop();
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
                                            // SizedBox(
                                            //   height: size.height * 0.012,
                                            // )
                                          ],
                                        );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
