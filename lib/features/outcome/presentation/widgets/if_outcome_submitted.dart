import 'package:egy_akin/app/shared/functions/show_answer_with_select_type.dart';
import 'package:egy_akin/app/shared/functions/permissions_helper.dart';
import 'package:egy_akin/app/shared/permissions/app_permissions.dart';
import 'package:egy_akin/features/patient_section_details/presentation/widgets/convert_list_to_string.dart';

import '../../../../exports.dart';

class IfOutcomeSubmitted extends StatelessWidget {
  const IfOutcomeSubmitted({
    super.key,
    required this.cubit,
    required this.doctorId,
    required this.currentDoctorModel,
    required this.accountVerification,
    required this.isSyndicateCardRequired,
    required this.currentDoctorRole,
    required this.currentDoctorPoints,
    required this.homeDataModel,
  });
  final OutcomeCubit cubit;
  final String doctorId;
  final DoctorModel currentDoctorModel;
  final bool accountVerification;
  final String isSyndicateCardRequired;
  final String currentDoctorRole;
  final int currentDoctorPoints;
  final HomeModelResponse homeDataModel;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OutcomeCubit, OutcomeState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          error: (message) {
            customSnackBar(context: context, message: message);
          },
        );
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: state.maybeWhen(
            orElse: () {
              return const ShimmerLoadingPatientsCards(ishorizontal: false);
            },
            loaded: (
              response,
              isSubmitedOutcome,
              message,
              _,
              isSubmitedOutcomeLoading,
              submitterModel,
            ) {
              return Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Flexible(
                          child: Text(
                            context.tr(AppStrings.submitBy),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: () async {
                            // Check permission before navigating to doctor info view
                            final hasPermission =
                                await PermissionHelper.hasPermission(
                              AppPermissions.viewDoctorPatients,
                            );

                            if (!hasPermission &&
                                currentDoctorModel.id.toString() !=
                                    submitterModel.id.toString()) {
                              // User doesn't have permission - show permission denied dialog
                              showCustomDialog(
                                context: context,
                                title: context.tr(AppStrings.attention),
                                description: context.tr(AppStrings
                                    .youDontHavePermissionToViewDoctorProfiles),
                                coloredButtonText:
                                    context.tr(AppStrings.ok),
                                coloredButtonOnTap: () =>
                                    navigatorKey.currentState?.pop(),
                                isNoColorShow: false,
                              );
                            } else {
                              // User has permission (or is the same doctor) - navigate
                              navigatorKey.currentState?.pushNamed(
                                AppRoutes.doctorInfoView,
                                arguments:
                                    AppRoutesArgs.doctorInfoViewRouteArgs(
                                  doctorId: submitterModel.id.toString(),
                                  currentDoctorModel: currentDoctorModel,
                                  accountVerification: accountVerification,
                                  currentDoctorPoints: currentDoctorPoints,
                                  isSyndicateCardRequired:
                                      isSyndicateCardRequired,
                                  currentDoctorRole: currentDoctorRole,
                                  homeDataModel: homeDataModel,
                                  initialIndex: 0,
                                  isNavigateToTheButtonOfInformationTab: false,
                                ),
                              );
                            }
                          },
                          child: Text(
                            doctorName(
                              firstName: submitterModel.name,
                              lastName: submitterModel.name,
                              role: 'true',
                            ),
                            // '',
                            style: TextStyle(
                              color: Colors.green.shade700,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  BlocBuilder<OutcomeCubit, OutcomeState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        orElse: () {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                        loaded: (
                          response,
                          isSubmitedOutcome,
                          message,
                          _,
                          isSubmitedOutcomeLoading,
                          submitterModel,
                        ) {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: response.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.only(
                                    left: 16, right: 16, top: 10, bottom: 10),
                                padding: const EdgeInsets.all(16),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.primary,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            '${response[index].question}:',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 16),
                                      margin: const EdgeInsets.only(
                                          top: 10, bottom: 10),
                                      decoration: BoxDecoration(
                                        color:
                                            AppColors.primary.withOpacity(0.06),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        response[index].type ==
                                                AppStrings.questionTypeMultiple
                                            ? convertDynamicToString(
                                                response[index])
                                            : response[index].type ==
                                                    AppStrings
                                                        .questionTypeSelect
                                                ? showAnswerWithSelectType(
                                                    response[index].answer)
                                                : response[index].answer ??
                                                    '...',
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
