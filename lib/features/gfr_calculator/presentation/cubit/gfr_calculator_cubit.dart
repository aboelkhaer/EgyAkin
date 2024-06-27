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
    if (isMale) {
      double A = 0.9;
      double B = (creatinine <= 0.9) ? -0.302 : -1.200;
      double gfr =
          142 * pow(creatinine / A, B).toDouble() * pow(0.9938, age).toDouble();
      return gfr;
    } else {
      double A = 0.7;
      double B = (creatinine <= 0.7) ? -0.241 : -1.200;
      double gfr = 142 *
          pow(creatinine / A, B).toDouble() *
          pow(0.9938, age).toDouble() *
          1.012;
      return gfr;
    }
  }

  double calculateSobhCcr(
      int age, double weight, double height, double serumCreatinine) {
    return ((140 - age) / serumCreatinine) *
        pow(weight, 0.54) *
        pow(height, 0.40) *
        0.014;
  }

  double parseDouble(String value) {
    try {
      // Log the value before parsing
      debugPrint('Parsing value: "$value"');

      // Remove any whitespace or unwanted characters
      value = value.trim();

      // If the value uses a comma as a decimal separator, replace it with a dot
      if (value.contains(',')) {
        value = value.replaceAll(',', '.');
      }

      // Attempt to parse the double value
      return double.parse(value);
    } catch (e) {
      debugPrint('Error parsing input: $e');
      throw FormatException('Invalid double: $value');
    }
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

      try {
        debugPrint('Age: ${data.age}');
        debugPrint('Creatinine: ${data.creatinine}');
        debugPrint('Height: ${data.height}');
        debugPrint('Weight: ${data.weight}');

        final age = int.parse(data.age!);
        final creatinine = parseDouble(data.creatinine!);
        final isMale = data.gender == 'Male';

        // Ensure height and weight are provided if using the Sobh formula
        double height, weight;
        if (equationType == 'CKD-EPI') {
          height = 0; // Default value, won't be used in CKD-EPI
          weight = 0; // Default value, won't be used in CKD-EPI
        } else {
          if (data.height!.isEmpty) {
            throw const FormatException('Height is required for Sobh formula');
          }
          if (data.weight!.isEmpty) {
            throw const FormatException('Weight is required for Sobh formula');
          }
          height = parseDouble(data.height!);
          weight = parseDouble(data.weight!);
        }

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
      } catch (e) {
        debugPrint('Error parsing input: $e');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Input Error'),
            backgroundColor: Colors.grey.shade100,
            content: const Text('Please enter valid input values.'),
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
  }

  void resetForm() {
    ageForm = '';
    creatinineForm = '';
    genderForm = 'Male';
    equationType = 'CKD-EPI';
    formKey.currentState?.reset();
  }
}
