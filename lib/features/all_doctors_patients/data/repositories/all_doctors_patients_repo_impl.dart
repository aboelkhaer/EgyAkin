import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/all_doctors_patients/data/models/apply_patient_filters_model_response.dart';
import 'package:egy_akin/features/all_doctors_patients/data/models/get_filters_options_model_response.dart';
import '../../../../exports.dart';

class AllDoctorsPatientsRepositoryImpl extends AllDoctorsPatientsRepository {
  final AllDoctorsPatientsDataSource allDoctorsPatientsDataSource;
  final NetworkInfo networkInfo;

  AllDoctorsPatientsRepositoryImpl(
      this.allDoctorsPatientsDataSource, this.networkInfo);

  @override
  Future<Either<Failure, GetAllDoctorsPatientsModelResponse>>
      getAllDoctorsPatients(int page) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response =
            await allDoctorsPatientsDataSource.getAllDoctorPatients(page);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }

  @override
  Future<Either<Failure, ApplyPatientFiltersModelResponse>>
      applyPatientsFilters(Map<String, dynamic> map, int page) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response =
            await allDoctorsPatientsDataSource.applyPatientsFilters(map, page);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }
}
