import '../../../../exports.dart';

class IfOutcomeNotSubmitted extends StatelessWidget {
  const IfOutcomeNotSubmitted({
    super.key,
    required this.cubit,
    required this.outcomeStatus,
    required this.accountVerification,
    required this.patientId,
  });

  final OutcomeCubit cubit;
  final bool outcomeStatus;
  final String patientId;
  final bool accountVerification;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OutcomeCubit, OutcomeState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          loaded: (response, isSubmitedOutcome) {
            if (isSubmitedOutcome) {
              Navigator.of(context).pushReplacementNamed(AppRoutes.home);
            }
          },
        );
      },
      builder: (context, state) {
        return state.maybeWhen(
          loading: () {
            return const ShimmerLoadingPatientsCards(ishorizontal: false);
          },
          orElse: () {
            return Stack(
              fit: StackFit.expand,
              children: [
                Form(
                  key: cubit.outcomeFormKey,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              left: 16, right: 16, top: 20, bottom: 10),
                          padding: const EdgeInsets.all(16),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.primary,
                            ),
                          ),
                          child: Column(
                            children: [
                              const Row(
                                children: [
                                  Text(
                                    '1- Outcome of the patient',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '*',
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                margin:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withOpacity(0.06),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: DropdownButtonFormField<dynamic>(
                                  hint: const Text(AppStrings.choose),
                                  validator: (val) {
                                    if (val == null ||
                                        val == AppStrings.empty) {
                                      return AppStrings.thisFieldIsRequired;
                                    }
                                    return null;
                                  },
                                  items: const [
                                    DropdownMenuItem<dynamic>(
                                      value: 'Survivor',
                                      child: Text('Survivor'),
                                    ),
                                    DropdownMenuItem<dynamic>(
                                      value: 'Death',
                                      child: Text('Death'),
                                    ),
                                  ],
                                  onChanged: (val) {
                                    cubit.outcomeOfThePatientField = val;
                                  },
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              top: 10, bottom: 10, left: 16, right: 16),
                          padding: const EdgeInsets.all(16),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.primary,
                            ),
                          ),
                          child: Column(
                            children: [
                              const Row(
                                children: [
                                  Text(
                                    '2- Creatinine on discharge',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '*',
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 10),
                              CustomTextFormField(
                                  title: AppStrings.answerHere,
                                  textInputType: TextInputType.text,
                                  // initialValue: controller
                                  //         .getOutcomeModel.creatinineOnDischarge ??
                                  // AppStrings.empty,
                                  textInputAction: TextInputAction.next,
                                  onChanged: (val) {
                                    cubit.creatinineOnDischargeField = val;
                                  },
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return AppStrings.thisFieldIsRequired;
                                    }
                                    return null;
                                  }),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              top: 10, bottom: 10, left: 16, right: 16),
                          padding: const EdgeInsets.all(16),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.primary,
                            ),
                          ),
                          child: Column(
                            children: [
                              const Row(
                                children: [
                                  Text(
                                    '3- Duration of admission/days',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '*',
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 10),
                              CustomTextFormField(
                                  title: AppStrings.answerHere,
                                  textInputType: TextInputType.text,
                                  // initialValue: controller.getOutcomeModel.duration ??
                                  //     AppStrings.empty,
                                  textInputAction: TextInputAction.done,
                                  onChanged: (val) {
                                    cubit.durationField = val;
                                  },
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return AppStrings.thisFieldIsRequired;
                                    }
                                    return null;
                                  }),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          padding: const EdgeInsets.all(16),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.primary,
                            ),
                          ),
                          child: Column(
                            children: [
                              const Row(
                                children: [
                                  Text(
                                    '4- Final status',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '*',
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                margin:
                                    const EdgeInsets.only(top: 16, bottom: 16),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withOpacity(0.06),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                width: double.infinity,
                                child: DropdownButtonFormField<dynamic>(
                                  isExpanded: true,
                                  hint: const Text(
                                    AppStrings.choose,
                                  ),
                                  validator: (val) {
                                    if (val == null ||
                                        val == AppStrings.empty) {
                                      return AppStrings.thisFieldIsRequired;
                                    }
                                    return null;
                                  },

                                  items: const [
                                    DropdownMenuItem<dynamic>(
                                      value: 'No imporvement (not on dialysis)',
                                      child: Text(
                                          'No imporvement (not on dialysis)'),
                                    ),
                                    DropdownMenuItem<dynamic>(
                                      value: 'No imporvement (on dialysis)',
                                      child:
                                          Text('No imporvement (on dialysis)'),
                                    ),
                                    DropdownMenuItem<dynamic>(
                                      value: 'Partial improvement',
                                      child: Text('Partial improvement'),
                                    ),
                                    DropdownMenuItem<dynamic>(
                                      value:
                                          'Complete improvement (90% improvement of serum creatinine)',
                                      child: Text(
                                        'Complete improvement (90% improvement of serum creatinine)',
                                        // overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],

                                  onChanged: (val) {
                                    cubit.finalStatusField = val;
                                  },
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                  ),
                                  // decoration: const InputDecoration(label: Text('Choose')),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              top: 10, bottom: 10, left: 16, right: 16),
                          padding: const EdgeInsets.all(16),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.primary,
                            ),
                          ),
                          child: Column(
                            children: [
                              const Row(
                                children: [
                                  Text(
                                    '5- Other',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '*',
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 10),
                              CustomTextFormField(
                                  title: AppStrings.answerHere,
                                  textInputType: TextInputType.multiline,
                                  // initialValue: controller.getOutcomeModel.other ??
                                  //     AppStrings.empty,
                                  textInputAction: TextInputAction.done,
                                  onChanged: (val) {
                                    cubit.otherField = val;
                                  },
                                  maxLines: null,
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return AppStrings.thisFieldIsRequired;
                                    }
                                    return null;
                                  }),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 200,
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    height: 90,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade100,
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset: const Offset(3, 4),
                        ),
                      ],
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: CustomElevatedButton(
                          onPressed: () {
                            if (accountVerification) {
                              if (cubit.outcomeFormKey.currentState!
                                      .validate() &&
                                  cubit.outcomeOfThePatientField != null &&
                                  cubit.finalStatusField != null) {
                                cubit.submitOutcome(patientId);
                              }
                            } else {
                              showCustomDialog(
                                context: context,
                                title: AppStrings.emailVerification,
                                description: AppStrings
                                    .toAddOutcomeYouMustVerifyYourEmailAddress,
                                noColoredBottonOnTap: () {
                                  Navigator.of(context).pop();
                                },
                                coloredBottonText: AppStrings.verify,
                                noColoredBottonText: AppStrings.cancel,
                                coloredBottonOnTap: () {
                                  Navigator.of(context)
                                      .pushReplacementNamed(AppRoutes.home);
                                },
                              );
                            }
                          },
                          title: AppStrings.submit,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
