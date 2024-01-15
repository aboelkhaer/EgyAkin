import 'package:dio/dio.dart';

import '../../../exports.dart';

class AddPatientRepository {
  ApiServices apiServices;
  AddPatientRepository({required this.apiServices});
  NetworkInfoImpl networkInfo = Get.find<NetworkInfoImpl>();

//! getPatientSectionDetails
  Future<List<BaseQuestionModel>>? getPatientSectionDetails(
      {required String sectionId, required RxBool isAddPatientLoading}) async {
    if (!Get.isSnackbarOpen) {
      isAddPatientLoading.value = true;
      await Future.delayed(const Duration(milliseconds: 300));
      if (await networkInfo.isConnected) {
        try {
          var response =
              await apiServices.getPatientHistoryForAddPatient(sectionId);
          if (response.value == true) {
            isAddPatientLoading.value = false;
            if (response.baseQuestionModel != null) {
              return response.baseQuestionModel!;
            }
            return [];
          } else {
            isAddPatientLoading.value = false;
            return [];
          }
        } catch (e) {
          isAddPatientLoading.value = false;
          if (e is DioException) {
            final result = e.response!.data as Map<String, dynamic>;
            customSnackBar(
              isError: true,
              title: AppStrings.error,
              body: result[AppStrings.message],
            );

            DioExceptions.fromDioError(
                dioError: e,
                errorFrom: 'add_patient_repo/getPatientSectionDetails');
          }
        }
      } else {
        isAddPatientLoading.value = false;
        customSnackBar(
          isError: true,
          title: AppStrings.error,
          body: AppStrings.somethingWentWrong,
        );
      }
      return [];
    } else {
      return [];
    }
  }

//! addPatientForFirstTime
  addPatientForFirstTime({
    required RxBool isAddPatientForFirstTimeLoading,
    required String doctorId,
    required Map<String, dynamic> map,
  }) async {
    if (!Get.isSnackbarOpen) {
      await Future.delayed(const Duration(milliseconds: 300));
      if (await networkInfo.isConnected) {
        try {
          var response = await apiServices.addPatientForFirstTime(map);
          if (response.value == true) {
            await Get.find<HomeController>().homeInit();
            isAddPatientForFirstTimeLoading.value = false;

            Get.offNamed(
              AppRoutes.patientSections,
              arguments: [
                response.id,
                response.doctorId,
                response.name,
                response.submitStatus,
              ],
            );
            Get.find<PatientSectionController>()
                .getPatientSections(response.id.toString());
          } else {
            isAddPatientForFirstTimeLoading.value = false;
            customSnackBar(
              isError: true,
              title: AppStrings.error,
              body: AppStrings.somethingWentWrong,
            );
          }
        } catch (e) {
          isAddPatientForFirstTimeLoading.value = false;
          if (e is DioException) {
            final result = e.response!.data as Map<String, dynamic>;
            customSnackBar(
              isError: true,
              title: AppStrings.error,
              body: result[AppStrings.message],
            );

            DioExceptions.fromDioError(
                dioError: e,
                errorFrom: 'add_patient_repo/addPatientForFirstTime');
          }
        }
      } else {
        isAddPatientForFirstTimeLoading.value = false;
        customSnackBar(
          isError: true,
          title: AppStrings.error,
          body: AppStrings.somethingWentWrong,
        );
      }
    }
  }
}
