import 'package:dio/dio.dart';

import '../../../exports.dart';

class OutcomeRepository {
  ApiServices apiServices;
  OutcomeRepository({required this.apiServices});
  NetworkInfoImpl networkInfo = Get.find<NetworkInfoImpl>();

  submitOutcome({
    required String patientId,
    required RxBool isAddOutcomeLoading,
    required String outcomeOfThePatient,
    required String duration,
    required String creatinineOnDischarge,
    required String finalStatus,
    required String other,
  }) async {
    if (!Get.isSnackbarOpen) {
      await Future.delayed(const Duration(milliseconds: 300));
      if (await networkInfo.isConnected) {
        try {
          var response = await apiServices.submitOutcome(
            patientId,
            outcomeOfThePatient,
            creatinineOnDischarge,
            duration,
            finalStatus,
            other,
          );
          if (response.value == true) {
            await Get.find<HomeController>().homeInit();
            isAddOutcomeLoading.value = false;
            Get.offNamed(AppRoutes.home);

            customSnackBar(
              isError: false,
              title: AppStrings.successfully,
              body: response.message,
            );
          } else {
            isAddOutcomeLoading.value = false;
            customSnackBar(
              isError: true,
              title: AppStrings.error,
              body: AppStrings.somethingWentWrong,
            );
          }
        } catch (e) {
          isAddOutcomeLoading.value = false;
          if (e is DioException) {
            final result = e.response!.data as Map<String, dynamic>;
            customSnackBar(
              isError: true,
              title: AppStrings.error,
              body: result[AppStrings.message],
            );

            DioExceptions.fromDioError(
                dioError: e,
                errorFrom: 'section_details_Repo/updateSectionDetails');
          }
        }
      } else {
        isAddOutcomeLoading.value = false;
        customSnackBar(
          isError: true,
          title: AppStrings.error,
          body: AppStrings.somethingWentWrong,
        );
      }
    }
  }

  Future getOutcome(
      {required String patientId, required RxBool isGetOutcomeLoading}) async {
    if (!Get.isSnackbarOpen) {
      isGetOutcomeLoading.value = true;
      await Future.delayed(const Duration(milliseconds: 300));
      if (await networkInfo.isConnected) {
        try {
          var response = await apiServices.getOutcome(patientId);
          if (response.value == true) {
            isGetOutcomeLoading.value = false;
            if (response.getOutcomeDataModelResponse != null) {
              return response.getOutcomeDataModelResponse!;
            }
            customSnackBar(
              isError: true,
              title: AppStrings.error,
              body: AppStrings.somethingWentWrong,
            );
          } else {
            isGetOutcomeLoading.value = false;
            customSnackBar(
              isError: true,
              title: AppStrings.error,
              body: AppStrings.somethingWentWrong,
            );
          }
        } catch (e) {
          isGetOutcomeLoading.value = false;
          if (e is DioException) {
            final result = e.response!.data as Map<String, dynamic>;
            customSnackBar(
              isError: true,
              title: AppStrings.error,
              body: result[AppStrings.message],
            );

            DioExceptions.fromDioError(
                dioError: e,
                errorFrom: 'patientSection_Repo/getPatientSection');
          }
        }
      } else {
        isGetOutcomeLoading.value = false;
        customSnackBar(
          isError: true,
          title: AppStrings.error,
          body: AppStrings.somethingWentWrong,
        );
      }
      customSnackBar(
        isError: true,
        title: AppStrings.error,
        body: AppStrings.somethingWentWrong,
      );
    } else {
      customSnackBar(
        isError: true,
        title: AppStrings.error,
        body: AppStrings.somethingWentWrong,
      );
    }
  }
}
