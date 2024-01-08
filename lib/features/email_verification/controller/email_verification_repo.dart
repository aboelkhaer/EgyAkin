import 'package:dio/dio.dart';

import '../../../exports.dart';

class EmailVerificationRepository {
  ApiServices apiServices;
  NetworkInfoImpl networkInfo = Get.find<NetworkInfoImpl>();

  EmailVerificationRepository({
    required this.apiServices,
  });

  sendEmailVerification({required context, required String email}) async {
    if (!Get.isSnackbarOpen) {
      await Future.delayed(const Duration(milliseconds: 300));
      if (await networkInfo.isConnected) {
        try {
          var response = await apiServices.sendEmailVerification();
          if (response.success == true) {
            // FocusScope.of(context).requestFocus(
            //     Get.find<EmailVerificationController>().firstOTPFocusNode);
            // Get.find<ResetPasswordController>().startTimer();
          } else {
            customSnackBar(
              isError: true,
              title: AppStrings.error,
              body: 'Something went wrong!',
            );
            Get.back();
          }
        } catch (e) {
          // isCommentsLoading.value = false;
          if (e is DioException) {
            final result = e.response!.data as Map<String, dynamic>;
            customSnackBar(
              isError: true,
              title: AppStrings.error,
              body: result['message'],
            );
            DioExceptions.fromDioError(
                dioError: e,
                errorFrom: 'email_verification_repo/sendEmailVerification');
            Get.back();
          }
          Get.back();
        }
      } else {
        customSnackBar(
          isError: true,
          title: AppStrings.error,
          body: AppStrings.noInternetConnection,
        );
        Get.back();
      }
    }
  }

  // emailVerificationOTP({
  //   required String otp,
  // }) async {
  //   if (!Get.isSnackbarOpen) {
  //     await Future.delayed(const Duration(milliseconds: 300));
  //     if (await networkInfo.isConnected) {
  //       try {
  //         var response = await apiServices.emailVerificationOTP(otp);
  //         if (response.success == true) {
  //           await Get.find<HomeController>().homeInit();
  //           Get.back();
  //         } else {
  //           customSnackBar(
  //             isError: true,
  //             title: AppStrings.error,
  //             body: 'Something went wrong!',
  //           );
  //           Get.back();
  //         }
  //       } catch (e) {
  //         if (e is DioException) {
  //           final result = e.response!.data as Map<String, dynamic>;
  //           customSnackBar(
  //             isError: true,
  //             title: AppStrings.error,
  //             body: result['error']['message'],
  //           );
  //           DioExceptions.fromDioError(
  //               dioError: e,
  //               errorFrom: 'email_verification_repo/emailVerificationOTP');

  //           // Get.back();
  //         }
  //         Get.back();
  //       }
  //     } else {
  //       // isCommentsLoading.value = false;
  //       customSnackBar(
  //         isError: true,
  //         title: AppStrings.error,
  //         body: AppStrings.noInternetConnection,
  //       );
  //       Get.back();
  //     }
  //   }
  // }

//! emailVerificationOTP
  Future<bool> emailVerificationOTP({
    required String otp,
  }) async {
    if (!Get.isSnackbarOpen) {
      await Future.delayed(const Duration(milliseconds: 300));
      if (await networkInfo.isConnected) {
        try {
          var response = await apiServices.emailVerificationOTP(otp);
          if (response.success == true) {
            await Get.find<HomeController>().homeInit();
            Get.back();
            return true;
          } else {
            customSnackBar(
              isError: true,
              title: AppStrings.error,
              body: 'Something went wrong!',
            );
            return false;
          }
        } catch (e) {
          if (e is DioException) {
            final result = e.response!.data as Map<String, dynamic>;
            customSnackBar(
              isError: true,
              title: AppStrings.error,
              body: result['error']['message'],
            );
            DioExceptions.fromDioError(
                dioError: e,
                errorFrom: 'email_verification_repo/emailVerificationOTP');

            return false;
          }
          return false;
        }
      } else {
        // isCommentsLoading.value = false;
        customSnackBar(
          isError: true,
          title: AppStrings.error,
          body: AppStrings.noInternetConnection,
        );
        return false;
      }
    }
    return false;
  }
}
