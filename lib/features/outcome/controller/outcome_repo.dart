import 'package:dio/dio.dart';

import '../../../exports.dart';

class OutcomeRepository {
  ApiServices apiServices;
  OutcomeRepository({required this.apiServices});
  NetworkInfoImpl networkInfo = Get.find<NetworkInfoImpl>();
  // HomeController homeController = Get.find<HomeController>();

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
              title: 'Successfully',
              body: response.message,
            );

            // showCustomDialog(
            //     context: context,
            //     title: 'Successfully',
            //     description:
            //         '${response.message}\nYour updates:\n${map.toString()}',
            //     noColoredBottonOnTap: () {},
            //     coloredBottonText: 'Cancel',
            //     noColoredBottonText: '',
            //     isNoColorShow: false,
            //     coloredBottonOnTap: () => Get.back());
          } else {
            isAddOutcomeLoading.value = false;
            customSnackBar(
              isError: true,
              title: 'Error!',
              body: 'Something went wrong.',
            );
          }
        } catch (e) {
          isAddOutcomeLoading.value = false;
          if (e is DioException) {
            final result = e.response!.data as Map<String, dynamic>;
            customSnackBar(
              isError: true,
              title: AppStrings.error,
              body: result['message'],
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
          body: AppStrings.noInternetConnection,
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
              body: 'Something went wrong!',
            );
          } else {
            isGetOutcomeLoading.value = false;
            customSnackBar(
              isError: true,
              title: AppStrings.error,
              body: 'Something went wrong!',
            );
          }
        } catch (e) {
          isGetOutcomeLoading.value = false;
          if (e is DioException) {
            final result = e.response!.data as Map<String, dynamic>;
            customSnackBar(
              isError: true,
              title: AppStrings.error,
              body: result['message'],
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
          body: AppStrings.noInternetConnection,
        );
      }
      customSnackBar(
        isError: true,
        title: AppStrings.error,
        body: 'Something went wrong!',
      );
    } else {
      customSnackBar(
        isError: true,
        title: AppStrings.error,
        body: 'Something went wrong!',
      );
    }
  }
}
