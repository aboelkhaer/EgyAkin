import 'package:dio/dio.dart';

import '../../../exports.dart';

class ContactUsRepository {
  ApiServices apiServices;
  ContactUsRepository({required this.apiServices});
  NetworkInfoImpl networkInfo = Get.find<NetworkInfoImpl>();

  addContactUs({
    required RxBool isContactUsLoading,
    required String message,
  }) async {
    if (!Get.isSnackbarOpen) {
      await Future.delayed(const Duration(milliseconds: 300));
      if (await networkInfo.isConnected) {
        try {
          var response = await apiServices.addContactUs(message);
          if (response.value == true) {
            isContactUsLoading.value = false;

            customSnackBar(
              isError: false,
              title: 'Successfully',
              body: response.message,
            );
          } else {
            isContactUsLoading.value = false;
            customSnackBar(
              isError: true,
              title: 'Error!',
              body: 'Something went wrong.',
            );
          }
        } catch (e) {
          isContactUsLoading.value = false;
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
        isContactUsLoading.value = false;
        customSnackBar(
          isError: true,
          title: AppStrings.error,
          body: AppStrings.somethingWentWrong,
        );
      }
    }
  }
}
