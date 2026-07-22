import 'dart:math';

import 'package:egy_akin/app/constants/app_strings.dart';

/// NKF professional eGFR equations.
/// https://www.kidney.org/professionals/gfr_calculator
class GfrEquationFormulas {
  GfrEquationFormulas._();

  /// CKD-EPI creatinine (2021), race-free.
  /// https://www.kidney.org/ckd-epi-creatinine-equation-2021-0
  static double ckdEpiCreatinine2021({
    required bool isFemale,
    required int age,
    required double scr,
  }) {
    final k = isFemale ? 0.7 : 0.9;
    final alpha = isFemale ? -0.241 : -0.302;
    final scrOverK = scr / k;

    var egfr = 142.0 *
        pow(min(scrOverK, 1.0), alpha) *
        pow(max(scrOverK, 1.0), -1.200) *
        pow(0.9938, age);

    if (isFemale) {
      egfr *= 1.012;
    }

    return egfr.toDouble();
  }

  /// CKD-EPI creatinine-cystatin C (2021).
  /// https://www.kidney.org/professionals/ckd-epi-creatinine-cystatin-equation-2021
  static double ckdEpiCreatinineCystatin2021({
    required bool isFemale,
    required int age,
    required double scr,
    required double scys,
  }) {
    final kappa = isFemale ? 0.7 : 0.9;
    final alpha = isFemale ? -0.219 : -0.144;
    final scrOverK = scr / kappa;
    final scysOver08 = scys / 0.8;

    var egfr = 135.0 *
        pow(min(scrOverK, 1.0), alpha) *
        pow(max(scrOverK, 1.0), -0.544) *
        pow(min(scysOver08, 1.0), -0.323) *
        pow(max(scysOver08, 1.0), -0.778) *
        pow(0.9961, age);

    if (isFemale) {
      egfr *= 0.963;
    }

    return egfr.toDouble();
  }

  /// CKD-EPI cystatin C (2012).
  /// https://www.kidney.org/professionals/ckd-epi-cystatin-c-equation-2012
  static double ckdEpiCystatinC2012({
    required bool isFemale,
    required int age,
    required double scys,
  }) {
    final scysOver08 = scys / 0.8;

    var egfr = 133.0 *
        pow(min(scysOver08, 1.0), -0.499) *
        pow(max(scysOver08, 1.0), -1.328) *
        pow(0.996, age);

    if (isFemale) {
      egfr *= 0.932;
    }

    return egfr.toDouble();
  }
}

/// One line in the NKF multi-equation result panel.
class NkfEgfrResultLine {
  /// Translation key (AppStrings).
  final String labelKey;
  final double egfr;

  const NkfEgfrResultLine({
    required this.labelKey,
    required this.egfr,
  });
}

/// Builds all applicable NKF calculator results from available biomarkers.
List<NkfEgfrResultLine> computeNkfEgfrResults({
  required int age,
  required bool isFemale,
  double? scr,
  double? scys,
}) {
  final results = <NkfEgfrResultLine>[];

  if (scr != null && scr > 0) {
    results.add(
      NkfEgfrResultLine(
        labelKey: AppStrings.ckdEpiCreatinine2021,
        egfr: GfrEquationFormulas.ckdEpiCreatinine2021(
          isFemale: isFemale,
          age: age,
          scr: scr,
        ),
      ),
    );
  }

  if (scr != null && scys != null && scr > 0 && scys > 0) {
    results.add(
      NkfEgfrResultLine(
        labelKey: AppStrings.ckdEpiCreatinineCystatin2021,
        egfr: GfrEquationFormulas.ckdEpiCreatinineCystatin2021(
          isFemale: isFemale,
          age: age,
          scr: scr,
          scys: scys,
        ),
      ),
    );
  }

  if (scys != null && scys > 0) {
    results.add(
      NkfEgfrResultLine(
        labelKey: AppStrings.ckdEpiCystatinC2012,
        egfr: GfrEquationFormulas.ckdEpiCystatinC2012(
          isFemale: isFemale,
          age: age,
          scys: scys,
        ),
      ),
    );
  }

  return results;
}
