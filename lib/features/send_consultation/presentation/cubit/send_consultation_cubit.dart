import 'package:egy_akin/features/send_consultation/presentation/cubit/send_consultation_state.dart';

import '../../../../exports.dart';

class SendConsultationCubit extends Cubit<SendConsultationState> {
  SendConsultationCubit() : super(const SendConsultationState.initial());
  static SendConsultationCubit get(context) => BlocProvider.of(context);
  int currentStep = 0;
  List<Step> getSteps() {
    return [
      Step(
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 0,
        title: const Text(AppStrings.email),
        content: Container(),
      ),
      Step(
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 1,
        title: const Text(AppStrings.verify),
        content: Container(),
      ),
      Step(
        state: StepState.complete,
        isActive: currentStep >= 2,
        title: const Text(AppStrings.password),
        content: Container(),
      ),
    ];
  }
}
