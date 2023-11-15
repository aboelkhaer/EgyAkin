import '../../../exports.dart';

class OutcomeScreen extends StatefulWidget {
  const OutcomeScreen({super.key});

  @override
  State<OutcomeScreen> createState() => _OutcomeScreenState();
}

class _OutcomeScreenState extends State<OutcomeScreen> {
  final OutcomeController controller = Get.put(OutcomeController());

  bool outcomeStatus = Get.arguments[0];
  String patientId = Get.arguments[1].toString();
  String patientname = Get.arguments[2];

  @override
  void initState() {
    if (outcomeStatus) {
      controller.getOutcome(patientId);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(patientname),
        centerTitle: true,
      ),
      body: Obx(
        () => controller.isAddOutcomeLoading.value ||
                controller.isGetOutcomeLoading.value
            ? const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              )
            : Stack(
                fit: StackFit.expand,
                children: [
                  Form(
                    key: controller.outcomeFormKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          outcomeStatus
                              ? Container(
                                  margin: const EdgeInsets.only(top: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Submited by',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        'Dr.${controller.getOutcomeModel.baseDoctorModel!.firstName} ${controller.getOutcomeModel.baseDoctorModel!.lastName}',
                                        style: TextStyle(
                                          color: Colors.green.shade700,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox.shrink(),
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  margin: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withOpacity(0.06),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: DropdownButtonFormField<dynamic>(
                                    hint: Text(controller.getOutcomeModel
                                            .outcomeOfThePatient ??
                                        'Choose'),
                                    validator: (val) {
                                      if (val == null || val == '') {
                                        return 'This field is required';
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
                                      controller.outcomeOfThePatientField = val;
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
                                    title: 'Answer here',
                                    textInputType: TextInputType.text,
                                    initialValue: controller.getOutcomeModel
                                            .creatinineOnDischarge ??
                                        '',
                                    textInputAction: TextInputAction.done,
                                    onChanged: (val) {
                                      controller.creatinineOnDischargeField =
                                          val;
                                    },
                                    validator: (val) {
                                      if (val == null || val.isEmpty) {
                                        return 'This field is required';
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
                                      '3- Final status',
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  margin: const EdgeInsets.only(
                                      top: 16, bottom: 16),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withOpacity(0.06),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  width: double.infinity,
                                  child: DropdownButtonFormField<dynamic>(
                                    isExpanded: true,
                                    hint: Text(controller
                                            .getOutcomeModel.finalStatus ??
                                        'Choose'),
                                    validator: (val) {
                                      if (val == null || val == '') {
                                        return 'This field is required';
                                      }
                                      return null;
                                    },

                                    items: const [
                                      DropdownMenuItem<dynamic>(
                                        value:
                                            'No imporvement (not on dialysis)',
                                        child: Text(
                                            'No imporvement (not on dialysis)'),
                                      ),
                                      DropdownMenuItem<dynamic>(
                                        value: 'No imporvement (on dialysis)',
                                        child: Text(
                                            'No imporvement (on dialysis)'),
                                      ),
                                      DropdownMenuItem<dynamic>(
                                        value: 'Partial improvement',
                                        child: Text('Partial improvement'),
                                      ),
                                      DropdownMenuItem<dynamic>(
                                        value:
                                            'Complete improvement (normal serum creatinine)',
                                        child: Text(
                                          'Complete improvement (normal serum creatinine)',
                                          // overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],

                                    onChanged: (val) {
                                      controller.finalStatusField = val;
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
                                      '4- Other',
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
                                    title: 'Answer here',
                                    textInputType: TextInputType.multiline,
                                    initialValue:
                                        controller.getOutcomeModel.other ?? '',
                                    textInputAction: TextInputAction.done,
                                    onChanged: (val) {
                                      controller.otherField = val;
                                    },
                                    maxLines: null,
                                    validator: (val) {
                                      if (val == null || val.isEmpty) {
                                        return 'This field is required';
                                      }
                                      return null;
                                    }),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  outcomeStatus
                      ? const SizedBox.shrink()
                      : Positioned(
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: CustomElevatedButton(
                                  size: size,
                                  onPressed: () {
                                    if (controller.outcomeFormKey.currentState!
                                            .validate() &&
                                        controller.outcomeOfThePatientField !=
                                            null &&
                                        controller.finalStatusField != null) {
                                      controller.submitOutcome(patientId);
                                    }
                                  },
                                  title: 'Submit',
                                ),
                              ),
                            ),
                          ),
                        ),
                ],
              ),
      ),
    );
  }
}
