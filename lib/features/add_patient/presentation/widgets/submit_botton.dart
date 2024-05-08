import '../../../../exports.dart';

class SubmitBotton extends StatelessWidget {
  final AddPatientCubit cubit;
  const SubmitBotton({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: CustomElevatedButton(
          onPressed: () {
            cubit.addPatientForFirstTime();
          },
          title: AppStrings.submit,
        ),
      ),
    );
  }
}
