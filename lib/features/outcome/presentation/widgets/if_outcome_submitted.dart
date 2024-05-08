import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../exports.dart';

class IfOutcomeSubmitted extends StatelessWidget {
  const IfOutcomeSubmitted({super.key, required this.cubit});
  final OutcomeCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: BlocConsumer<OutcomeCubit, OutcomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return const ShimmerLoadingPatientsCards(ishorizontal: false);
            },
            loaded: (response, isSubmitedOutcome) {
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
                        Flexible(
                          child: Text(
                            'Dr.${capitalizeFirstText(response.data!.doctor!.firstName.toString())} ${capitalizeFirstText(response.data!.doctor!.lastName.toString())}',
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
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 16),
                          margin: const EdgeInsets.only(top: 10, bottom: 10),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.06),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                              response.data!.outcomeOfThePatient.toString()),
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
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 16),
                          margin: const EdgeInsets.only(top: 10, bottom: 10),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.06),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                              response.data!.creatinineOnDischarge.toString()),
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
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 16),
                          margin: const EdgeInsets.only(top: 10, bottom: 10),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.06),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(response.data!.duration.toString()),
                        ),
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
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 16),
                          margin: const EdgeInsets.only(top: 10, bottom: 10),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.06),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(response.data!.finalSubmit.toString()),
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
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 16),
                          margin: const EdgeInsets.only(top: 10, bottom: 10),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.06),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text('${response.data!.other}'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 200,
                  )
                ],
              );
            },
          );
        },
      ),
    );
  }
}
