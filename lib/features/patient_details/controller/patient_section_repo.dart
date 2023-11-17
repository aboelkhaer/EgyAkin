import 'package:dio/dio.dart';

import '../../../exports.dart';

class PatientSectionRepository {
  ApiServices apiServices;
  PatientSectionRepository({required this.apiServices});
  NetworkInfoImpl networkInfo = Get.find<NetworkInfoImpl>();
  HomeController homeController = Get.find<HomeController>();

  // getPatientSection(String patientId) async {
  //   await apiServices.getPatientSections(patientId);
  // }

  Future<List<BaseSectionModel>>? getPatientSection(
      {required String patientId,
      required RxBool isPatientSectionLoading}) async {
    if (!Get.isSnackbarOpen) {
      isPatientSectionLoading.value = true;
      await Future.delayed(const Duration(milliseconds: 300));
      if (await networkInfo.isConnected) {
        try {
          var response = await apiServices.getPatientSections(patientId);
          if (response.value == true) {
            isPatientSectionLoading.value = false;
            if (response.baseSectionsList != null) {
              return response.baseSectionsList!;
            }
            return [];
          } else {
            isPatientSectionLoading.value = false;
            return [];
          }
        } catch (e) {
          isPatientSectionLoading.value = false;
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
        isPatientSectionLoading.value = false;
        customSnackBar(
          isError: true,
          title: AppStrings.error,
          body: AppStrings.noInternetConnection,
        );
      }
      return [];
    } else {
      return [];
    }
  }

  deletePatient(
      {required String patientId,
      required RxBool isPatientSectionLoading}) async {
    if (!Get.isSnackbarOpen) {
      await Future.delayed(const Duration(milliseconds: 300));
      if (await networkInfo.isConnected) {
        try {
          var response = await apiServices.deletePatient(patientId);
          if (response.value == true) {
            Get.offNamed(AppRoutes.home);

            customSnackBar(
              isError: false,
              title: 'Successfully',
              body: response.message,
            );
          } else {
            isPatientSectionLoading.value = false;
            customSnackBar(
              isError: true,
              title: 'Error!',
              body: 'Something went wrong.',
            );
          }
        } catch (e) {
          isPatientSectionLoading.value = false;
          if (e is DioException) {
            final result = e.response!.data as Map<String, dynamic>;
            customSnackBar(
              isError: true,
              title: AppStrings.error,
              body: result['message'],
            );

            DioExceptions.fromDioError(
                dioError: e, errorFrom: 'patientSection_Repo/deletePatient');
          }
        }
      } else {
        isPatientSectionLoading.value = false;
        customSnackBar(
          isError: true,
          title: AppStrings.error,
          body: AppStrings.noInternetConnection,
        );
      }
    }
  }

  finalSubmit(
      {required String patientId,
      required RxBool isPatientSectionLoading}) async {
    if (!Get.isSnackbarOpen) {
      await Future.delayed(const Duration(milliseconds: 300));
      if (await networkInfo.isConnected) {
        try {
          var response = await apiServices.finalSubmit(patientId);
          if (response.value == true) {
            isPatientSectionLoading.value = false;
            Get.offNamed(AppRoutes.home);
            customSnackBar(
              isError: false,
              title: 'Successfully',
              body: response.message,
            );
          } else {
            isPatientSectionLoading.value = false;
            customSnackBar(
              isError: true,
              title: 'Error!',
              body: 'Something went wrong.',
            );
          }
        } catch (e) {
          isPatientSectionLoading.value = false;
          if (e is DioException) {
            final result = e.response!.data as Map<String, dynamic>;
            customSnackBar(
              isError: true,
              title: AppStrings.error,
              body: result['message'],
            );

            DioExceptions.fromDioError(
                dioError: e, errorFrom: 'patientSection_Repo/deletePatient');
          }
        }
      } else {
        isPatientSectionLoading.value = false;
        customSnackBar(
          isError: true,
          title: AppStrings.error,
          body: AppStrings.noInternetConnection,
        );
      }
    }
  }
}
