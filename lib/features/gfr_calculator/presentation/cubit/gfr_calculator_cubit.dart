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
  int changesCounter = 0;
  List<GFRCalculatorHistoryModelResponse> gfrHistory = [];
  changeRadioButton(String value) {
    genderForm = value;

    emit(GfrCalculatorState.initial(changesCounter += 1));
  }

  void calculateGFR(BuildContext context) {
    if (formKey.currentState?.validate() ?? false) {
      final data = GFRCalculatorModelResponse(
        age: ageForm,
        creatinine: creatinineForm,
        gender: genderForm,
      );

      // Calculate GFR (example formula)
      final age = double.parse(data.age!);
      final creatinine = double.parse(data.creatinine!);
      final isMale = data.gender == 'Male';
      final gfr = (isMale ? 141 : 144) *
          (age > 30 ? pow(0.993, (age - 30)) : 1) /
          creatinine;
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
    formKey.currentState?.reset();
  }
}
