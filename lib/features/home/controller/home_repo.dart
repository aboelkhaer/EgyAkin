import 'package:dio/dio.dart';

import '../../../app/constants/local_storage_key.dart';
import '../../../exports.dart';
import '../model/all_patients_home_model.dart';

class HomeRepository {
  ApiServices apiServices;
  NetworkInfoImpl networkInfo = Get.find<NetworkInfoImpl>();
  GetStorageLib getStorageLib = Get.find<GetStorageLib>();
  List<PatientHomeModel>? currentPatientList = [];

  HomeRepository({
    required this.apiServices,
  });

  Future<List<PatientHomeModel>>? getCurrentPatients(
      RxBool isCurrentPatientsLoading) async {
    isCurrentPatientsLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 300));
    var getTokenFromLocal =
        await getStorageLib.getString(AppLocalStrings.keyToken);
    if (await networkInfo.isConnected) {
      try {
        var response = await apiServices.getCurrentPatients(getTokenFromLocal!);
        if (response.value == true) {
          if (response.patientHomeModel != null) {
            return response.patientHomeModel!;
          }
          return [];
        } else {
          isCurrentPatientsLoading.value = false;
        }
      } catch (e) {
        isCurrentPatientsLoading.value = false;
        if (e is DioException) {
          final result = e.response!.data as Map<String, dynamic>;
          customSnackBar(
            isError: true,
            title: AppStrings.error,
            body: result['message'],
          );

          DioExceptions.fromDioError(
              dioError: e, errorFrom: 'home_Repo/getCurrentPatients');
        }
      }
      return [];
    } else {
      isCurrentPatientsLoading.value = false;
      customSnackBar(
        isError: true,
        title: AppStrings.error,
        body: AppStrings.noInternetConnection,
      );
      return [];
    }
  }

  Future<List<AllPatientHomeModel>>? getAllPatients(
      RxBool isAllPatientsLoading) async {
    isAllPatientsLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 300));
    var getTokenFromLocal =
        await getStorageLib.getString(AppLocalStrings.keyToken);
    if (await networkInfo.isConnected) {
      try {
        var response = await apiServices.getAllPatients(getTokenFromLocal!);
        if (response.value == true) {
          if (response.allPatientHomeModel != null) {
            return response.allPatientHomeModel!;
          }
          return [];
        } else {
          isAllPatientsLoading.value = false;
        }
      } catch (e) {
        isAllPatientsLoading.value = false;
        if (e is DioException) {
          final result = e.response!.data as Map<String, dynamic>;
          customSnackBar(
            isError: true,
            title: AppStrings.error,
            body: result['message'],
          );

          DioExceptions.fromDioError(
              dioError: e, errorFrom: 'home_Repo/getAllPatients');
        }
      }
      return [];
    } else {
      isAllPatientsLoading.value = false;
      customSnackBar(
        isError: true,
        title: AppStrings.error,
        body: AppStrings.noInternetConnection,
      );
      return [];
    }
  }
}
