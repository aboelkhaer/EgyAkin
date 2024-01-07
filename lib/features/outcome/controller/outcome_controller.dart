import '../../../exports.dart';

class OutcomeController extends GetxController {
  GlobalKey<FormState> outcomeFormKey = GlobalKey<FormState>();
  OutcomeRepository outcomeRepository = Get.find<OutcomeRepository>();

  String? outcomeOfThePatientField;
  String? creatinineOnDischargeField;
  String? durationField;
  String? finalStatusField;
  String? otherField;
  RxBool isAddOutcomeLoading = false.obs;
  RxBool isGetOutcomeLoading = false.obs;

  GetOutcomeDataModelResponse getOutcomeModel = GetOutcomeDataModelResponse();
  submitOutcome(String patientId) async {
    isAddOutcomeLoading(true);

    await outcomeRepository.submitOutcome(
      patientId: patientId,
      isAddOutcomeLoading: isAddOutcomeLoading,
      outcomeOfThePatient: outcomeOfThePatientField!,
      creatinineOnDischarge: creatinineOnDischargeField!,
      duration: durationField!,
      finalStatus: finalStatusField!,
      other: otherField!,
    );

    isAddOutcomeLoading(false);
    update();
  }

  getOutcome(String patientId) async {
    isGetOutcomeLoading(true);

    getOutcomeModel = await outcomeRepository.getOutcome(
      patientId: patientId,
      isGetOutcomeLoading: isGetOutcomeLoading,
    );

    isGetOutcomeLoading(false);
    update();
  }
}
