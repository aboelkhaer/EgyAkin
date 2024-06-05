import '../../../../exports.dart';

class SubmitBottonForOutcome extends StatelessWidget {
  final OutcomeCubit cubit;
  final String patientId;
  const SubmitBottonForOutcome(
      {super.key, required this.cubit, required this.patientId});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: CustomElevatedButton(
          onPressed: () {
            cubit.submitOutcome(patientId);
          },
          title: AppStrings.submit,
        ),
      ),
    );
  }
}
