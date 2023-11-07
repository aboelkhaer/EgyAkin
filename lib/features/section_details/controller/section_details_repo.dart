import 'package:dio/dio.dart';

import '../../../exports.dart';

class SectionDetailsRepository {
  ApiServices apiServices;
  SectionDetailsRepository({required this.apiServices});
  NetworkInfoImpl networkInfo = Get.find<NetworkInfoImpl>();

  Future<List<BaseQuestionModel>>? getPatientSectionDetails(
      {required String sectionId,
      required String patientId,
      required RxBool isSectionDetailsLoading}) async {
    if (!Get.isSnackbarOpen) {
      isSectionDetailsLoading.value = true;
      await Future.delayed(const Duration(milliseconds: 300));
      if (await networkInfo.isConnected) {
        try {
          var response =
              await apiServices.getSectionDetails(sectionId, patientId);
          if (response.value == true) {
            isSectionDetailsLoading.value = false;
            if (response.baseQuestionModel != null) {
              return response.baseQuestionModel!;
            }
            return [];
          } else {
            isSectionDetailsLoading.value = false;
            return [];
          }
        } catch (e) {
          isSectionDetailsLoading.value = false;
          if (e is DioException) {
            final result = e.response!.data as Map<String, dynamic>;
            customSnackBar(
              isError: true,
              title: AppStrings.error,
              body: result['message'],
            );

            DioExceptions.fromDioError(
                dioError: e,
                errorFrom: 'section_details_Repo/getPatientSectionDetails');
          }
        }
      } else {
        isSectionDetailsLoading.value = false;
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

  updateSectionDetails(
      {required String patientId,
      required RxBool isSectionDetailsUpdateLoading,
      required String sectionId,
      required Map<String, dynamic> map,
      required context}) async {
    if (!Get.isSnackbarOpen) {
      await Future.delayed(const Duration(milliseconds: 300));
      if (await networkInfo.isConnected) {
        try {
          var response =
              await apiServices.updateSectionDetails(sectionId, patientId, map);
          if (response.value == true) {
            Get.find<PatientSectionController>().getPatientSections(patientId);
            isSectionDetailsUpdateLoading.value = false;
            Get.back();

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
            isSectionDetailsUpdateLoading.value = false;
            customSnackBar(
              isError: true,
              title: 'Error!',
              body: 'Something went wrong.',
            );
          }
        } catch (e) {
          isSectionDetailsUpdateLoading.value = false;
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
        isSectionDetailsUpdateLoading.value = false;
        customSnackBar(
          isError: true,
          title: AppStrings.error,
          body: AppStrings.noInternetConnection,
        );
      }
    }
  }
}
