import 'package:dio/dio.dart';

import '../../../exports.dart';

class NotificationRepository {
  ApiServices apiServices;
  NotificationRepository({required this.apiServices});
  NetworkInfoImpl networkInfo = Get.find<NetworkInfoImpl>();

  updateNotification({required RxBool isUpdateNotificationsLoading}) async {
    isUpdateNotificationsLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 300));

    if (await networkInfo.isConnected) {
      try {
        var response = await apiServices.updateNotifications();

        if (response.value == true) {
          // Get.find<HomeController>().homeInit();
          // isUpdateNotificationsLoading.value = false;
          // Get.offNamed(AppRoutes.signIn);
        } else {
          isUpdateNotificationsLoading.value = false;
        }
      } catch (e) {
        isUpdateNotificationsLoading.value = false;
        if (e is DioException) {
          // final result = e.response!.data as Map<String, dynamic>;
          // customSnackBar(
          //   isError: true,
          //   title: AppStrings.error,
          //   body: result['message'],
          // );

          DioExceptions.fromDioError(
              dioError: e, errorFrom: 'home_Repo/updateNotification');
        }
      }
    } else {
      isUpdateNotificationsLoading.value = false;
      // customSnackBar(
      //   isError: true,
      //   title: AppStrings.error,
      //   body: AppStrings.noInternetConnection,
      // );
    }
  }
}
