import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/patient_sections/data/models/delete_patient_model_response.dart';
import 'package:egy_akin/features/patient_sections/data/models/final_submit_model_response.dart';

import '../../../../exports.dart';

class PatientSectionsRepositoryImpl extends PatientSectionsRepository {
  final PatientSectionsDataSource patientSectionsDataSource;
  final NetworkInfo networkInfo;

  PatientSectionsRepositoryImpl(
      this.patientSectionsDataSource, this.networkInfo);

  @override
  Future<Either<Failure, GetPatientSectionsModelResponse>> getPatientSections(
      {required String patientId}) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response =
            await patientSectionsDataSource.getPatientSections(patientId);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }

  @override
  Future<Either<Failure, DeletePatientModelResponse>> deletePatient(
      {required String patientId}) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response =
            await patientSectionsDataSource.deletePatient(patientId);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }

  @override
  Future<Either<Failure, FinalSubmitModelResponse>> finalSubmit(
      {required String patientId}) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response = await patientSectionsDataSource.finalSubmit(patientId);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }
}
