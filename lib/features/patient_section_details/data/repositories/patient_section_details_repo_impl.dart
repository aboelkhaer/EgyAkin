import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/patient_section_details/data/models/create_new_medicine_model_response.dart';
import 'package:egy_akin/features/patient_section_details/data/models/create_patient_recommendation_model_response.dart';
import 'package:egy_akin/features/patient_section_details/data/models/delete_patient_recommendation_model_response.dart';
import 'package:egy_akin/features/patient_section_details/data/models/get_recommendations_model_response.dart';
import 'package:egy_akin/features/patient_section_details/data/models/search_for_dose_model_response.dart';
import 'package:egy_akin/features/patient_section_details/data/models/update_patient_recommendation_model_response.dart';
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

  @override
  Future<Either<Failure, GetRecommendationsModelResponse>> getRecommendations(
      String patientId) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response =
            await patientSectionDetailsDataSource.getRecommendations(patientId);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }

  @override
  Future<Either<Failure, CreatePatientRecommendationModelResponse>> createPatientRecommendation(String patientId, Map<String, dynamic> body) async{
   if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response =
            await patientSectionDetailsDataSource.createPatientRecommendation(patientId, body);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }

  @override
  Future<Either<Failure, SearchForDoseInMedicationSectionModelResponse>> searchForDoseInMedicationSection(String dose, int page)async {
   if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response = await patientSectionDetailsDataSource.searchForDoseInMedicationSection(dose, page);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }

  @override
  Future<Either<Failure, DeletePatientRecommendationModelResponse>> deletePatientRecommendation(String patientId, List<int> ids) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response = await patientSectionDetailsDataSource.deletePatientRecommendation(patientId, ids);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }

  @override
  Future<Either<Failure, UpdatePatientRecommendationModelResponse>> updatePatientRecommendation(String patientId, Map<String, dynamic> body) async{
   if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response = await patientSectionDetailsDataSource.updatePatientRecommendation(patientId, body);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }
  
  @override
  Future<Either<Failure, CreateNewMedicineModelResponse>> createNewMedicine(String title, String? description, String dose) async{
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response = await patientSectionDetailsDataSource.createNewMedicine(title, description, dose);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }

}
