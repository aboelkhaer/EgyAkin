import 'package:egy_akin/features/gfr_calculator/data/models/gfr_calculator_model_response.dart';
import 'dart:math';
import '../../../../exports.dart';

class GfrCalculatorCubit extends Cubit<GfrCalculatorState> {
  GfrCalculatorCubit() : super(const GfrCalculatorState.initial(0));
  static GfrCalculatorCubit get(context) => BlocProvider.of(context);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String ageForm = '';
  String creatinineForm = '';
  String genderForm = 'Male';
  String equationType = 'CKD-EPI';
  String weightForm = '';
  String heightForm = '';
  int changesCounter = 0;
  List<GFRCalculatorHistoryModelResponse> gfrHistory = [];

  changeGenderValue(String value) {
    genderForm = value;

    emit(GfrCalculatorState.initial(changesCounter += 1));
  }

  changeEquationTypeValue(String value) {
    equationType = value;

    emit(GfrCalculatorState.initial(changesCounter += 1));
  }

  double calculateGFRForCKD(bool isMale, int age, double creatinine) {
    // Constants based on gender
    final kappa = isMale ? 0.9 : 0.7;
    final alpha = isMale ? -0.411 : -0.329;
    final constant = isMale ? 141 : 144;
    final genderFactor = isMale ? 1.0 : 1.018;

    // CKD-EPI equation components
    final minScr = min(creatinine / kappa, 1);
    final maxScr = max(creatinine / kappa, 1);

    // Calculate GFR
    final gfr = constant *
        pow(minScr, alpha) *
        pow(maxScr, -1.209) *
        pow(0.993, age) *
        genderFactor;

    return gfr;
  }

  double calculateSobhCcr(
      int age, double weight, double height, double serumCreatinine) {
    return ((140 - age) / serumCreatinine) *
        pow(weight, 0.54) *
        pow(height, 0.40) *
        0.014;
  }

  void calculateGFR(BuildContext context) {
    if (formKey.currentState?.validate() ?? false) {
      final data = GFRCalculatorModelResponse(
        age: ageForm,
        creatinine: creatinineForm,
        gender: genderForm,
        equationType: equationType,
        height: heightForm,
        weight: weightForm,
      );

      // Calculate GFR (example formula)
      final age = int.parse(data.age!);
      final creatinine = double.parse(data.creatinine!);
      final height = double.parse(data.height!);
      final weight = double.parse(data.weight!);
      final isMale = data.gender == 'Male';
      final double gfr;
      if (equationType == 'CKD-EPI') {
        gfr = calculateGFRForCKD(isMale, age, creatinine);
      } else {
        gfr = calculateSobhCcr(age, weight, height, creatinine);
      }
      gfrHistory.add(
        GFRCalculatorHistoryModelResponse(
          age: age.toString(),
          creatinine: creatinine.toString(),
          gender: genderForm,
          result: gfr.toStringAsFixed(2),
          date: DateTime.now().toString(),
        ),
      );
      debugPrint(gfrHistory.toString());
      resetForm();
      emit(GfrCalculatorState.initial(changesCounter += 1));

      // Show result
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('GFR Result'),
          backgroundColor: Colors.grey.shade100,
          content: Text('Your estimated GFR is ${gfr.toStringAsFixed(2)}'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void resetForm() {
    ageForm = '';
    creatinineForm = '';
    genderForm = 'Male';
    equationType = 'CKD-EPI';
    formKey.currentState?.reset();
  }
}
