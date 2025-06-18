import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/patient_section_details/data/models/create_new_medicine_model_response.dart';
import 'package:egy_akin/features/patient_section_details/data/models/create_patient_recommendation_model_response.dart';
import 'package:egy_akin/features/patient_section_details/data/models/delete_patient_recommendation_model_response.dart';
import 'package:egy_akin/features/patient_section_details/data/models/get_recommendations_model_response.dart';
import 'package:egy_akin/features/patient_section_details/data/models/search_for_dose_model_response.dart';
import 'package:egy_akin/features/patient_section_details/data/models/update_patient_recommendation_model_response.dart';
import '../../../../exports.dart';

abstract class PatientSectionDetailsRepository {
  Future<Either<Failure, GetPatientSectionDetailsModelResponse>>
      getPatientSectionDetails(String sectionId, String patientId);
  Future<Either<Failure, UpdatePatientSectionDetailsModelResponse>>
      updatePatientSectionDetails(
          String sectionId, String patientId, Map<String, dynamic> map);

  Future<Either<Failure, GetRecommendationsModelResponse>> getRecommendations(
    String patientId,
  );
    Future<Either<Failure, CreatePatientRecommendationModelResponse>> createPatientRecommendation(
      String patientId,
    Map<String, dynamic> body,
    );
  Future<Either<Failure, UpdatePatientRecommendationModelResponse>> updatePatientRecommendation(
    String patientId,
    Map<String, dynamic> body,
  );
  Future<Either<Failure, SearchForDoseInMedicationSectionModelResponse>> searchForDoseInMedicationSection(
    String dose,
    int page,
  );

  Future<Either<Failure, DeletePatientRecommendationModelResponse>> deletePatientRecommendation(
    String patientId,
    List<int> ids,
  );
  
  Future<Either<Failure, CreateNewMedicineModelResponse>> createNewMedicine(
    String title,
    String? description,
    String dose,
  );
}
