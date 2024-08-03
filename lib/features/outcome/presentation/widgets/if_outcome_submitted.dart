import 'package:egy_akin/app/shared/functions/doctor_name.dart';

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
            loaded: (response, isSubmitedOutcome, message, _,
                isSubmitedOutcomeLoading) {
              return Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Flexible(
                          child: Text(
                            AppStrings.submitBy,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            navigatorKey.currentState?.pushNamed(
                              AppRoutes.doctorInfoView,
                              arguments: AppRoutesArgs.doctorInfoViewRouteArgs(
                                doctorId: doctorId,
                                currentDoctorModel: currentDoctorModel,
                                accountVerification: accountVerification,
                                currentDoctorPoints: currentDoctorPoints,
                                isSyndicateCardRequired:
                                    isSyndicateCardRequired,
                                currentDoctorRole: currentDoctorRole,
                                homeDataModel: homeDataModel,
                              ),
                            );
                          },
                          child: Text(
                            doctorName(
                                firstName: cubit.submitterName,
                                lastName: cubit.submitterName,
                                role: currentDoctorRole),
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
                        loaded: (response, isSubmitedOutcome, message, _,
                            isSubmitedOutcomeLoading) {
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
                                        Text(
                                          '${response[index].question}:',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
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
                                        response[index].answer ?? '...',
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
