import '../../../../exports.dart';

class SendConsultationScreen extends StatelessWidget {
  const SendConsultationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SendConsultationCubit cubit = SendConsultationCubit.get(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Send Consultation',
        ),
      ),
      body: Stepper(
        type: StepperType.horizontal,
        currentStep: cubit.currentStep,
        controlsBuilder: (context, details) {
          return Container(
            margin: const EdgeInsets.only(top: 20),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                SizedBox(
                  height: 50,
                  child: SizedBox(),
                ),
              ],
            ),
          );
        },
        steps: cubit.getSteps(),
      ),
    );
  }
}
