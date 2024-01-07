import 'package:dio/dio.dart';

import '../../../exports.dart';

class ResetPasswordRepository {
  ApiServices apiServices;
  ResetPasswordRepository({required this.apiServices});
  NetworkInfoImpl networkInfo = Get.find<NetworkInfoImpl>();

//! sendEmailForResetPassword
  Future<bool> sendEmailForResetPassword(
      {required String email, required context}) async {
    if (!Get.isSnackbarOpen) {
      await Future.delayed(const Duration(milliseconds: 300));
      if (await networkInfo.isConnected) {
        try {
          var response = await apiServices.sendEmailForForgetPassword(email);
          if (response.success == true) {
            Get.find<ResetPasswordController>().currentStep.value = 1;
            FocusScope.of(context).requestFocus(
                Get.find<ResetPasswordController>().firstOTPFocusNode);
            Get.find<ResetPasswordController>().startTimer();

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
                errorFrom: 'reset_password_repo/sendEmailForResetPassword');
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

//! verifyOTP
  Future<bool> verifyOTP({
    required String email,
    required String otp,
  }) async {
    if (!Get.isSnackbarOpen) {
      await Future.delayed(const Duration(milliseconds: 300));
      if (await networkInfo.isConnected) {
        try {
          var response = await apiServices.verifyOTP(email, otp);
          if (response.success == true) {
            Get.find<ResetPasswordController>().currentStep.value = 2;

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
          // isCommentsLoading.value = false;
          if (e is DioException) {
            final result = e.response!.data as Map<String, dynamic>;
            customSnackBar(
              isError: true,
              title: AppStrings.error,
              body: result['error']['message'],
            );
            DioExceptions.fromDioError(
                dioError: e, errorFrom: 'reset_password_repo/verfiyOTP');
            // Get.find<ResetPasswordController>().currentStep -= 1;

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

//! changePassword
  Future<bool> changePassword(
      {required String email, required String newPassword}) async {
    if (!Get.isSnackbarOpen) {
      await Future.delayed(const Duration(milliseconds: 300));
      if (await networkInfo.isConnected) {
        try {
          var response = await apiServices.changePassword(email, newPassword);
          if (response.success == true) {
            // Get.find<ResetPasswordController>().currentStep.value = 2;
            Get.offNamed(AppRoutes.signIn);

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
                dioError: e, errorFrom: 'reset_password_repo/changePassword');
            // Get.find<ResetPasswordController>().currentStep -= 1;

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
