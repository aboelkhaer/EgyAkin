import '../../../../exports.dart';

/// Temporary design-only data for Patient Sections.
/// Flip [_kPatientSectionsDesignFakeData] off in the screen when wiring the API back.
class PatientSectionsFakeData {
  static GetPatientSectionsModelResponse response({
    required String doctorId,
    String patientName = 'Mohamed Wael Shabaan',
  }) {
    final now = DateTime.now();

    EquationDataModel eq(String localization, String value) =>
        EquationDataModel(localization: localization, value: value);

    EquationModel equation({
      required String current,
      required String basal,
      required String discharge,
    }) =>
        EquationModel(
          currentGFR: eq('Current GFR', current),
          basalCreatinine: eq('Basal Cr GFR', basal),
          creatinineOnDischarge: eq('Discharge GFR', discharge),
        );

    final sections = <SectionModel>[
      SectionModel(
        sectionId: 1,
        sectionName: 'Patient History',
        sectionStatus: true,
        updatedAt: now.subtract(const Duration(days: 7)).toIso8601String(),
      ),
      SectionModel(
        sectionId: 2,
        sectionName: 'Complaint',
        sectionStatus: true,
        updatedAt: now.subtract(const Duration(days: 7)).toIso8601String(),
      ),
      SectionModel(
        sectionId: 3,
        sectionName: 'Cause of AKI',
        sectionStatus: true,
        updatedAt: now.subtract(const Duration(days: 23)).toIso8601String(),
      ),
      SectionModel(
        sectionId: 4,
        sectionName: 'Risk factors for AKI',
        sectionStatus: true,
        updatedAt: now.subtract(const Duration(days: 23)).toIso8601String(),
      ),
      SectionModel(
        sectionId: 5,
        sectionName: 'Comorbidities',
        sectionStatus: true,
        updatedAt: now.subtract(const Duration(days: 23)).toIso8601String(),
      ),
      SectionModel(
        sectionId: 6,
        sectionName: 'Laboratory and radiology results',
        sectionStatus: true,
        updatedAt: now.subtract(const Duration(days: 23)).toIso8601String(),
      ),
      SectionModel(
        sectionId: 7,
        sectionName: 'Medical decision',
        sectionStatus: true,
        updatedAt: now.subtract(const Duration(days: 23)).toIso8601String(),
      ),
      SectionModel(
        sectionId: 8,
        sectionName: 'Medical Reports',
        sectionStatus: false,
        updatedAt: '',
      ),
      SectionModel(
        sectionId: 9,
        sectionName: 'Patient Outcome',
        sectionStatus: false,
        updatedAt: '',
      ),
      SectionModel(
        sectionId: 10,
        sectionName: 'Follow up and results',
        sectionStatus: false,
        updatedAt: '',
      ),
      SectionModel(
        sectionId: 11,
        sectionName: 'Referrals',
        sectionStatus: false,
        updatedAt: '',
      ),
    ];

    return GetPatientSectionsModelResponse(
      value: true,
      submitStatus: false,
      patientName: patientName,
      doctorId: doctorId,
      isMarked: false,
      bmi: 19.5,
      bmiCategory: 'normal',
      gfr: GFRModel(
        ckd: equation(current: '7.75', basal: '0', discharge: '0'),
        sobh: equation(current: '7.75', basal: '0', discharge: '0'),
        mdrd: equation(current: '6.90', basal: '0', discharge: '0'),
      ),
      data: sections,
    );
  }
}
