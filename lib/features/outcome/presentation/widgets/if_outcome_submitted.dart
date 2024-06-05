import '../../../../exports.dart';

class IfOutcomeSubmitted extends StatelessWidget {
  const IfOutcomeSubmitted(
      {super.key,
      required this.cubit,
      required this.doctorId,
      required this.currentDoctorId});
  final OutcomeCubit cubit;
  final String doctorId;
  final String currentDoctorId;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: BlocConsumer<OutcomeCubit, OutcomeState>(
        listener: (context, state) {
          state.maybeWhen(
            orElse: () {},
            error: (message) {
              customSnackBar(context: context, message: message);
            },
          );
        },
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return const ShimmerLoadingPatientsCards(ishorizontal: false);
            },
            loaded: (response, isSubmitedOutcome, message) {
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
                        // Text(
                        //   'Dr.${controller.getOutcomeModel.baseDoctorModel!.firstName.toString().capitalizeFirst} ${controller.getOutcomeModel.baseDoctorModel!.lastName.toString().capitalizeFirst}',
                        //   style: TextStyle(
                        //     color: Colors.green.shade700,
                        //     fontWeight: FontWeight.bold,
                        //     fontSize: 18,
                        //   ),
                        // ),
                        GestureDetector(
                          onTap: () {
                            navigatorKey.currentState?.pushNamed(
                              AppRoutes.doctorInfoView,
                              arguments: AppRoutesArgs.doctorInfoViewRouteArgs(
                                doctorId: doctorId,
                                currentDoctorId: currentDoctorId,
                              ),
                            );
                          },
                          child: Text(
                            'Dr.${response.submitter!.name.toString()}',
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
                        loaded: (response, isSubmitedOutcome, message) {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: response.data!.length,
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
                                          '${response.data![index].question}:',
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
                                        response.data![index].answer.toString(),
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
                  const SizedBox(
                    height: 200,
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
