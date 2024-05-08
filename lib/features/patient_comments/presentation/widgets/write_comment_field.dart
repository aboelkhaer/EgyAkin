import '../../../../exports.dart';

class WriteCommentField extends StatelessWidget {
  const WriteCommentField({
    super.key,
    required this.cubit,
    required this.accountVerification,
    required this.currentDoctorModel,
    required this.patientId,
  });

  final PatientCommentsCubit cubit;
  final bool accountVerification;
  final DoctorModel currentDoctorModel;
  final String patientId;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<PatientCommentsCubit, PatientCommentsState>(
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () {
            return const SizedBox.shrink();
          },
          loaded: (comments, newComment) {
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
                          if (accountVerification) {
                            cubit.addPatientComments(patientId: patientId);
                          } else {
                            showCustomDialog(
                              context: context,
                              title: AppStrings.emailVerification,
                              description: AppStrings
                                  .toAddCommentYouMustVerifyYourEmailAddress,
                              noColoredBottonOnTap: () {
                                Navigator.of(context).pop();
                              },
                              coloredBottonText: AppStrings.verify,
                              noColoredBottonText: AppStrings.cancel,
                              coloredBottonOnTap: () {
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
                          loaded: (comments, newComment) {
                            return newComment.trim() == AppStrings.empty
                                ? const SizedBox.shrink()
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          if (accountVerification) {
                                            cubit.addPatientComments(
                                                patientId: patientId);
                                          } else {
                                            showCustomDialog(
                                              context: context,
                                              title:
                                                  AppStrings.emailVerification,
                                              description: AppStrings
                                                  .toAddCommentYouMustVerifyYourEmailAddress,
                                              noColoredBottonOnTap: () {
                                                Navigator.of(context).pop();
                                              },
                                              coloredBottonText:
                                                  AppStrings.verify,
                                              noColoredBottonText:
                                                  AppStrings.cancel,
                                              coloredBottonOnTap: () {
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
