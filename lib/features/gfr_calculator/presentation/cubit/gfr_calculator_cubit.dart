import 'package:egy_akin/features/gfr_calculator/data/datasources/gfr_calculator_history_storage.dart';
import 'package:egy_akin/features/gfr_calculator/data/models/gfr_calculator_model_response.dart';
import 'package:egy_akin/features/gfr_calculator/presentation/utils/gfr_equation_formulas.dart';
import 'package:egy_akin/features/gfr_calculator/presentation/utils/gfr_history_result_codec.dart';
import 'package:egy_akin/features/gfr_calculator/presentation/widgets/gfr_result_dialog.dart';
import 'dart:math';
import '../../../../exports.dart';

class GfrCalculatorCubit extends Cubit<GfrCalculatorState> {
  GfrCalculatorCubit(this._preferences)
      : _historyStorage = GfrCalculatorHistoryStorage(),
        super(const GfrCalculatorState.initial(0)) {
    loadHistory();
  }

  static GfrCalculatorCubit get(context) => BlocProvider.of(context);

  final AppPreferences _preferences;
  final GfrCalculatorHistoryStorage _historyStorage;

  static const String equationNkfEgfr = 'NKF eGFR';
  static const String nkfBiomarkerCreatinine = 'creatinine';
  static const String nkfBiomarkerCystatin = 'cystatin';
  static const String nkfBiomarkerBoth = 'both';

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String ageForm = '';
  String creatinineForm = '';
  String cystatinForm = '';
  String genderForm = 'Male';
  String equationType = equationNkfEgfr;
  String weightForm = '';
  String heightForm = '';
  int changesCounter = 0;
  String isBlackForm = 'No';
  String nkfBiomarkerMode = nkfBiomarkerCreatinine;
  List<GFRCalculatorHistoryModelResponse> gfrHistory = [];

  Future<void> loadHistory() async {
    gfrHistory = await _historyStorage.load(_preferences);
    emit(GfrCalculatorState.initial(changesCounter += 1));
  }

  Future<void> _persistHistory() async {
    await _historyStorage.save(_preferences, gfrHistory);
    emit(GfrCalculatorState.initial(changesCounter += 1));
  }

  Future<void> _appendHistoryEntry(
    GFRCalculatorHistoryModelResponse entry,
  ) async {
    var updated = [...gfrHistory, entry];
    if (updated.length > GfrCalculatorHistoryStorage.maxEntries) {
      updated = updated.sublist(updated.length - GfrCalculatorHistoryStorage.maxEntries);
    }
    gfrHistory = updated;
    await _persistHistory();
  }

  Future<void> removeHistoryEntry(int index) async {
    if (index < 0 || index >= gfrHistory.length) return;
    gfrHistory = [...gfrHistory]..removeAt(index);
    await _persistHistory();
  }

  void confirmClearAllHistory(
    BuildContext context, {
    Future<void> Function()? onConfirmed,
  }) {
    if (gfrHistory.isEmpty) return;

    showCustomDialog(
      context: context,
      title: context.tr(AppStrings.gfrClearAllHistory),
      description: context.tr(AppStrings.gfrClearAllHistoryConfirm),
      noColoredButtonText: context.tr(AppStrings.cancel),
      coloredButtonText: context.tr(AppStrings.delete),
      noColoredButtonOnTap: () => Navigator.of(context).pop(),
      coloredButtonOnTap: () async {
        Navigator.of(context).pop();
        if (onConfirmed != null) {
          await onConfirmed();
        } else {
          await clearAllHistory();
        }
      },
    );
  }

  Future<void> clearAllHistory() async {
    gfrHistory = [];
    await _historyStorage.clear(_preferences);
    emit(GfrCalculatorState.initial(changesCounter += 1));
  }

  changeGenderValue(String value) {
    genderForm = value;
    emit(GfrCalculatorState.initial(changesCounter += 1));
  }

  changeBlackRaceValue(String value) {
    isBlackForm = value;
    emit(GfrCalculatorState.initial(changesCounter += 1));
  }

  changeEquationTypeValue(String value) {
    equationType = value;
    if (value == equationNkfEgfr) {
      nkfBiomarkerMode = nkfBiomarkerCreatinine;
    }
    emit(GfrCalculatorState.initial(changesCounter += 1));
  }

  void changeNkfBiomarkerMode(String value) {
    nkfBiomarkerMode = value;
    if (value == nkfBiomarkerCreatinine) {
      cystatinForm = '';
    } else if (value == nkfBiomarkerCystatin) {
      creatinineForm = '';
    }
    emit(GfrCalculatorState.initial(changesCounter += 1));
  }

  bool get showNkfCreatinineField =>
      nkfBiomarkerMode == nkfBiomarkerCreatinine ||
      nkfBiomarkerMode == nkfBiomarkerBoth;

  bool get showNkfCystatinField =>
      nkfBiomarkerMode == nkfBiomarkerCystatin ||
      nkfBiomarkerMode == nkfBiomarkerBoth;

  void changeCystatinValue(String value) {
    cystatinForm = value;
    emit(GfrCalculatorState.initial(changesCounter += 1));
  }

  /// MDRD 4-variable eGFR (Levey 2006, IDMS-standardized creatinine).
  /// https://www.mdcalc.com/calc/76/mdrd-gfr-equation
  double calculateGFRForMDRD2006({
    required double scr,
    required int age,
    required bool isFemale,
    required bool isBlack,
  }) {
    return (175.0 *
            pow(scr, -1.154) *
            pow(age, -0.203) *
            (isFemale ? 0.742 : 1.0) *
            (isBlack ? 1.212 : 1.0))
        .toDouble();
  }

  double calculateSobhCcr(
      int age, double weight, double height, double serumCreatinine) {
    return ((140 - age) / serumCreatinine) *
        pow(weight, 0.54) *
        pow(height, 0.40) *
        0.014;
  }

  double? _parseOptionalDouble(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return null;
    return parseDouble(trimmed);
  }

  double parseDouble(String value) {
    try {
      value = value.trim();
      if (value.contains(',')) {
        value = value.replaceAll(',', '.');
      }
      return double.parse(value);
    } catch (e) {
      debugPrint('Error parsing input: $e');
      throw FormatException('Invalid double: $value');
    }
  }

  String _equationLabel(BuildContext context) {
    switch (equationType) {
      case 'MDRD':
        return 'MDRD (2006)';
      case equationNkfEgfr:
        return context.tr(AppStrings.nkfEgfrCalculator);
      case 'CKD-EPI':
        return 'CKD-EPI (2021)';
      default:
        return equationType;
    }
  }

  Future<void> calculateGFR(BuildContext context) async {
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
        final age = int.parse(data.age!);
        final isFemale = data.gender == 'Female';
        final creatinine = _parseOptionalDouble(creatinineForm);
        final cystatin = _parseOptionalDouble(cystatinForm);

        if (equationType == equationNkfEgfr) {
          if (creatinine == null && cystatin == null) {
            throw const FormatException('Missing biomarkers');
          }

          final results = computeNkfEgfrResults(
            age: age,
            isFemale: isFemale,
            scr: creatinine,
            scys: cystatin,
          );

          if (results.isEmpty) {
            throw const FormatException('No results');
          }

          await _appendHistoryEntry(
            GFRCalculatorHistoryModelResponse(
              age: age.toString(),
              creatinine: creatinine?.toString() ?? '—',
              cystatin: cystatin?.toString(),
              gender: genderForm,
              result: encodeNkfHistoryResult(results),
              date: DateTime.now().toString(),
              equationType: equationType,
            ),
          );

          if (!context.mounted) return;
          showGfrResultDialog(
            context: context,
            equationLabel: _equationLabel(context),
            nkfResults: results,
          );
          return;
        }

        if (creatinine == null) {
          throw const FormatException('Creatinine required');
        }

        double height, weight;
        if (equationType == 'MDRD') {
          height = 0;
          weight = 0;
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
        if (equationType == 'MDRD') {
          gfr = calculateGFRForMDRD2006(
            scr: creatinine,
            age: age,
            isFemale: isFemale,
            isBlack: isBlackForm == 'Yes',
          );
        } else {
          gfr = calculateSobhCcr(age, weight, height, creatinine);
        }

        await _appendHistoryEntry(
          GFRCalculatorHistoryModelResponse(
            age: age.toString(),
            creatinine: creatinine.toString(),
            gender: genderForm,
            result: gfr.toStringAsFixed(1),
            date: DateTime.now().toString(),
            equationType: equationType,
          ),
        );

        if (!context.mounted) return;
        showGfrResultDialog(
          context: context,
          equationLabel: _equationLabel(context),
          singleEgfr: gfr,
        );
      } catch (e) {
        debugPrint('Error parsing input: $e');
        if (!context.mounted) return;
        showCustomDialog(
          context: context,
          title: context.tr(AppStrings.inputError),
          description: context.tr(AppStrings.pleaseEnterValidInputValues),
          coloredButtonText: context.tr(AppStrings.ok),
          coloredButtonOnTap: () => Navigator.of(context).pop(),
          isNoColorShow: false,
        );
      }
    }
  }

  void resetForm() {
    ageForm = '';
    creatinineForm = '';
    cystatinForm = '';
    genderForm = 'Male';
    equationType = equationNkfEgfr;
    nkfBiomarkerMode = nkfBiomarkerCreatinine;
    formKey.currentState?.reset();
  }
}
