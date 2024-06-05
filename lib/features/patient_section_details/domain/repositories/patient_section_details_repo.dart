import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/patient_section_details/data/models/get_patient_section_model_response.dart';
import 'package:egy_akin/features/patient_section_details/data/models/update_patient_section_details_model_response.dart';
import '../../../../exports.dart';

abstract class PatientSectionDetailsRepository {
  Future<Either<Failure, GetPatientSectionDetailsModelResponse>>
      getPatientSectionDetails(String sectionId, String patientId);
  Future<Either<Failure, UpdatePatientSectionDetailsModelResponse>>
      updatePatientSectionDetails(
          String sectionId, String patientId, Map<String, dynamic> map);
}
