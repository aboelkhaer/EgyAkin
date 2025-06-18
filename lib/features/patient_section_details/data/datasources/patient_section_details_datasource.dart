import 'package:egy_akin/features/patient_section_details/data/models/create_new_medicine_model_response.dart';
import 'package:egy_akin/features/patient_section_details/data/models/create_patient_recommendation_model_response.dart';
import 'package:egy_akin/features/patient_section_details/data/models/delete_patient_recommendation_model_response.dart';
import 'package:egy_akin/features/patient_section_details/data/models/get_recommendations_model_response.dart';
import 'package:egy_akin/features/patient_section_details/data/models/search_for_dose_model_response.dart';
import 'package:egy_akin/features/patient_section_details/data/models/update_patient_recommendation_model_response.dart';

import '../../../../exports.dart';

abstract class PatientSectionDetailsDataSource {
  Future<GetPatientSectionDetailsModelResponse> getPatientSectionDetails(
      String sectionId, String patientId);
  Future<UpdatePatientSectionDetailsModelResponse> updatePatientSectionDetails(
      String sectionId, String patientId, Map<String, dynamic> map);
  Future<GetRecommendationsModelResponse> getRecommendations(
    String patientId,
  );
  Future<CreatePatientRecommendationModelResponse> createPatientRecommendation(
    String patientId,
    Map<String, dynamic> body,
  );
  Future<UpdatePatientRecommendationModelResponse> updatePatientRecommendation(
    String patientId,
    Map<String, dynamic> body,
  );
  Future<SearchForDoseInMedicationSectionModelResponse> searchForDoseInMedicationSection(
    String dose,
    int page,
  );
  Future<DeletePatientRecommendationModelResponse> deletePatientRecommendation(
    String patientId,
    List<int> ids,
  );
   Future< CreateNewMedicineModelResponse> createNewMedicine(
    String title,
    String? description,
    String dose,
  );
}

class PatientSectionDetailsDataSourceImpl
    implements PatientSectionDetailsDataSource {
  final ApiServices _apiServices;

  PatientSectionDetailsDataSourceImpl(this._apiServices);

  @override
  Future<GetPatientSectionDetailsModelResponse> getPatientSectionDetails(
      String sectionId, String patientId) async {
    return await _apiServices.getSectionDetails(sectionId, patientId);
  }

  @override
  Future<UpdatePatientSectionDetailsModelResponse> updatePatientSectionDetails(
      String sectionId, String patientId, Map<String, dynamic> map) async {
    return await _apiServices.updateSectionDetails(sectionId, patientId, map);
  }

  @override
  Future<GetRecommendationsModelResponse> getRecommendations(
      String patientId) async {
    return await _apiServices.getRecommendations(patientId);
  }

  @override
  Future<CreatePatientRecommendationModelResponse> createPatientRecommendation(
      String patientId, Map<String, dynamic> body) async {
    return await _apiServices.createPatientRecommendation(patientId, body);
  }

  @override
  Future<SearchForDoseInMedicationSectionModelResponse> searchForDoseInMedicationSection(
      String dose, int page) async {
    return await _apiServices.searchForDoseInMedicationSection(dose, page);
  }

  @override
  Future<DeletePatientRecommendationModelResponse> deletePatientRecommendation(
      String patientId, List<int> ids) async {
    return await _apiServices.deletePatientRecommendation(patientId, {
    "ids": ids,
  },);
  }

  @override
  Future<UpdatePatientRecommendationModelResponse> updatePatientRecommendation(String patientId, Map<String, dynamic> body) async {
    return await _apiServices.updatePatientRecommendation(patientId, body);
  }

  @override
  Future<CreateNewMedicineModelResponse> createNewMedicine(String title, String? description, String dose) async {
    return await _apiServices.createNewMedicine(title, description, dose);
  }
}
