import 'package:dartz/dartz.dart';
import '../../../../exports.dart';

abstract class PatientSectionDetailsRepository {
  Future<Either<Failure, GetPatientSectionDetailsModelResponse>>
      getPatientSectionDetails(String sectionId, String patientId);
  Future<Either<Failure, UpdatePatientSectionDetailsModelResponse>>
      updatePatientSectionDetails(
          String sectionId, String patientId, Map<String, dynamic> map);
}
