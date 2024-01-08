import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../exports.dart';

class AuthRepository {
  ApiServices apiServices;
  AuthRepository({required this.apiServices});

  NetworkInfoImpl networkInfo = Get.find<NetworkInfoImpl>();
  GetStorageLib getStorageLib = Get.find<GetStorageLib>();

//! Login
  login(
      {required String email,
      required String password,
      required RxBool isSignInLoading}) async {
    if (!Get.isSnackbarOpen) {
      isSignInLoading.value = true;
      await Future.delayed(const Duration(milliseconds: 300));

      if (await networkInfo.isConnected) {
        try {
          var response = await apiServices.login(
            email,
            password,
          );
          if (response.value == true) {
            await getStorageLib.setData(
                AppLocalStrings.keyToken, response.token);
            // getStorageLib.setData(keyIsUserLoggedIn, true);
            // getStorageLib.clearAllData();

            // var dataa = await getStorageLib.getString(keyToken);
            // var dataaa = await getStorageLib.getBool(keyIsUserLoggedIn);
            // log(dataa.toString());
            // log(dataaa.toString());

            await getStorageLib.setData(AppLocalStrings.currnetDoctorFirstName,
                response.doctorModel!.firstName);
            await getStorageLib.setData(AppLocalStrings.currentDoctorLastName,
                response.doctorModel!.lastName);
            await getStorageLib.setData(AppLocalStrings.currentDoctorEmail,
                response.doctorModel!.email);
            await getStorageLib.setData(AppLocalStrings.currentDoctorPhone,
                response.doctorModel!.phone);
            await getStorageLib.setData(AppLocalStrings.currentDoctorSpecialty,
                response.doctorModel!.specialty);

            await getStorageLib.setData(
                AppLocalStrings.currentDoctorAge, response.doctorModel!.age);
            await getStorageLib.setData(
                AppLocalStrings.currentDoctorRegistrationNumber,
                response.doctorModel!.registrationNumber);

            await getStorageLib.setData(
                AppLocalStrings.currentDoctorWorkingPlace,
                response.doctorModel!.workingPlace);
            await getStorageLib.setData(
                AppLocalStrings.currentDoctorJob, response.doctorModel!.job);
            await getStorageLib.setData(
                AppLocalStrings.currentDoctorId, response.doctorModel!.id);
            await getStorageLib.setData(
                AppLocalStrings.currentDoctorHighestDegree,
                response.doctorModel!.highestDegree);
            await getStorageLib.setData(AppLocalStrings.currentDoctorCreatedAt,
                response.doctorModel!.createdAt);
            await getStorageLib.setData(AppLocalStrings.currentDoctorUpdatedAt,
                response.doctorModel!.updatedAt);

            isSignInLoading.value = false;
            Get.offNamed(AppRoutes.home);
            // Get.find<HomeController>().homeInit();
          } else {
            isSignInLoading.value = false;
          }
        } catch (e) {
          isSignInLoading.value = false;
          if (e is DioException) {
            final result = e.response!.data as Map<String, dynamic>;
            customSnackBar(
              isError: true,
              title: AppStrings.error,
              body: result['message'],
            );

            DioExceptions.fromDioError(
                dioError: e, errorFrom: 'auth_Repo/login');
          }
        }
      } else {
        isSignInLoading.value = false;
        customSnackBar(
          isError: true,
          title: AppStrings.error,
          body: AppStrings.noInternetConnection,
        );
      }
    } else {
      return null;
    }
  }

//! Register
  register({
    required String firstName,
    required String lastName,
    required String email,
    required String age,
    required String specialty,
    required String password,
    required String workingPlace,
    required String passwordConfirmation,
    required String phone,
    required String registrationNumber,
    required String job,
    required String highestDegree,
    required RxBool isRegisterLoading,
  }) async {
    isRegisterLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 300));
    if (await networkInfo.isConnected) {
      try {
        var response = await apiServices.register(
          firstName,
          lastName,
          email,
          password,
          passwordConfirmation,
          age,
          specialty,
          workingPlace,
          registrationNumber,
          phone,
          job,
          highestDegree,
        );
        if (response.value == true) {
          // todo

          await getStorageLib.setData(AppLocalStrings.keyToken, response.token);
          await getStorageLib.setData(AppLocalStrings.currnetDoctorFirstName,
              response.doctorModel!.firstName);
          await getStorageLib.setData(AppLocalStrings.currentDoctorLastName,
              response.doctorModel!.lastName);
          await getStorageLib.setData(
              AppLocalStrings.currentDoctorEmail, response.doctorModel!.email);
          await getStorageLib.setData(
              AppLocalStrings.currentDoctorPhone, response.doctorModel!.phone);
          await getStorageLib.setData(AppLocalStrings.currentDoctorSpecialty,
              response.doctorModel!.specialty);

          await getStorageLib.setData(
              AppLocalStrings.currentDoctorAge, response.doctorModel!.age);
          await getStorageLib.setData(
              AppLocalStrings.currentDoctorRegistrationNumber,
              response.doctorModel!.registrationNumber);

          await getStorageLib.setData(AppLocalStrings.currentDoctorWorkingPlace,
              response.doctorModel!.workingPlace);
          await getStorageLib.setData(
              AppLocalStrings.currentDoctorJob, response.doctorModel!.job);
          await getStorageLib.setData(
              AppLocalStrings.currentDoctorId, response.doctorModel!.id);
          await getStorageLib.setData(
              AppLocalStrings.currentDoctorHighestDegree,
              response.doctorModel!.highestDegree);
          await getStorageLib.setData(AppLocalStrings.currentDoctorCreatedAt,
              response.doctorModel!.createdAt);
          await getStorageLib.setData(AppLocalStrings.currentDoctorUpdatedAt,
              response.doctorModel!.updatedAt);

          Get.offNamed(AppRoutes.home);
          // Get.offAndToNamed(AppRoutes.home);

          log(response.token.toString());
        } else {
          isRegisterLoading.value = false;
        }
      } catch (e) {
        isRegisterLoading.value = false;

        if (e is DioException) {
          final result = e.response!.data as Map<String, dynamic>;
          customSnackBar(
            isError: true,
            title: AppStrings.error,
            body: result['message'],
          );

          DioExceptions.fromDioError(
              dioError: e, errorFrom: 'auth_Repo/register');
        }
      }
    } else {
      isRegisterLoading.value = false;
      customSnackBar(
        isError: true,
        title: AppStrings.error,
        body: AppStrings.noInternetConnection,
      );
    }
  }

//! Sign out
  logout({required RxBool isSignOutLoading}) async {
    isSignOutLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 300));
    var getTokenFromLocal =
        await getStorageLib.getString(AppLocalStrings.keyToken);

    if (await networkInfo.isConnected) {
      try {
        var response = await apiServices.logout(getTokenFromLocal!);

        if (response.value == true) {
          await getStorageLib.clearAllData();

          isSignOutLoading.value = false;
          Get.offNamed(AppRoutes.signIn);
        } else {
          isSignOutLoading.value = false;
        }
      } catch (e) {
        isSignOutLoading.value = false;
        if (e is DioException) {
          final result = e.response!.data as Map<String, dynamic>;
          customSnackBar(
            isError: true,
            title: AppStrings.error,
            body: result['message'],
          );

          DioExceptions.fromDioError(
              dioError: e, errorFrom: 'auth_Repo/logout');
        }
      }
    } else {
      isSignOutLoading.value = false;
      customSnackBar(
        isError: true,
        title: AppStrings.error,
        body: AppStrings.noInternetConnection,
      );
    }
  }
}
