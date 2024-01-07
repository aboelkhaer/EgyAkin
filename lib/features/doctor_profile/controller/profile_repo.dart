import 'package:dio/dio.dart';

import '../../../exports.dart';

class ProfileRepository {
  ApiServices apiServices;
  NetworkInfoImpl networkInfo = Get.find<NetworkInfoImpl>();
  GetStorageLib getStorageLib = Get.find<GetStorageLib>();
  ProfileRepository({
    required this.apiServices,
  });

  updateProfile({
    required int doctorID,
    required String firstName,
    required String lastName,
    required String email,
    required String age,
    required String specialty,
    // required String password,
    required String workingPlace,
    // required String passwordConfirmation,
    required String phone,
    required String job,
    required String highestDegree,
    required RxBool isUpdateLoading,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (await networkInfo.isConnected) {
      try {
        var response = await apiServices.updateProfile(
          doctorID,
          firstName,
          lastName,
          email,
          // password,
          // passwordConfirmation,
          age,
          specialty,
          workingPlace,
          phone,
          job,
          highestDegree,
        );
        if (response.value == true) {
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

          await Get.find<HomeController>().homeInit();

          customSnackBar(
            isError: false,
            title: AppStrings.message,
            body: 'Profile updated successfully',
          );
        } else {}
      } catch (e) {
        if (e is DioException) {
          final result = e.response!.data as Map<String, dynamic>;
          customSnackBar(
            isError: true,
            title: AppStrings.error,
            body: result['message'],
          );

          DioExceptions.fromDioError(
              dioError: e, errorFrom: 'update_Repo/updateProfile');
        }
      }
    } else {
      customSnackBar(
        isError: true,
        title: AppStrings.error,
        body: AppStrings.noInternetConnection,
      );
    }
  }
}
