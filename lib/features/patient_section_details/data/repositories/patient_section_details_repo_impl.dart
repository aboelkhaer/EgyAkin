import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/patient_section_details/data/models/get_patient_section_model_response.dart';
import 'package:egy_akin/features/patient_section_details/data/models/update_patient_section_details_model_response.dart';
import '../../../../exports.dart';

class PatientSectionDetailsRepositoryImpl
    extends PatientSectionDetailsRepository {
  final PatientSectionDetailsDataSource patientSectionDetailsDataSource;
  final NetworkInfo networkInfo;

  PatientSectionDetailsRepositoryImpl(
      this.patientSectionDetailsDataSource, this.networkInfo);

  @override
  Future<Either<Failure, GetPatientSectionDetailsModelResponse>>
      getPatientSectionDetails(String sectionId, String patientId) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response = await patientSectionDetailsDataSource
            .getPatientSectionDetails(sectionId, patientId);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }

  @override
  Future<Either<Failure, UpdatePatientSectionDetailsModelResponse>>
      updatePatientSectionDetails(
          String sectionId, String patientId, Map<String, dynamic> map) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response = await patientSectionDetailsDataSource
            .updatePatientSectionDetails(sectionId, patientId, map);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }
}
