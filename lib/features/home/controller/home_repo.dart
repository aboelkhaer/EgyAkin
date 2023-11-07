import 'package:dio/dio.dart';

import '../../../exports.dart';

class HomeRepository {
  ApiServices apiServices;
  NetworkInfoImpl networkInfo = Get.find<NetworkInfoImpl>();
  GetStorageLib getStorageLib = Get.find<GetStorageLib>();

  HomeRepository({
    required this.apiServices,
  });

  Future<List<BasePatientModel>>? getCurrentPatients(
      RxBool isCurrentPatientsLoading) async {
    isCurrentPatientsLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 300));
    var getTokenFromLocal =
        await getStorageLib.getString(AppLocalStrings.keyToken);
    if (await networkInfo.isConnected) {
      try {
        var response = await apiServices.getCurrentPatients(getTokenFromLocal!);
        if (response.value == true) {
          Get.find<HomeController>().currentDoctorScoreValue!.value =
              response.scoreValue.toString();

          if (response.basePatientList != null) {
            return response.basePatientList!;
          }
          return [];
        } else {
          isCurrentPatientsLoading.value = false;
        }
      } catch (e) {
        isCurrentPatientsLoading.value = false;
        if (e is DioException) {
          // final result = e.response!.data as Map<String, dynamic>;
          // customSnackBar(
          //   isError: true,
          //   title: AppStrings.error,
          //   body: result['message'],
          // );

          DioExceptions.fromDioError(
              dioError: e, errorFrom: 'home_Repo/getCurrentPatients');
        }
      }
      return [];
    } else {
      isCurrentPatientsLoading.value = false;
      customSnackBar(
        isError: true,
        title: AppStrings.error,
        body: AppStrings.noInternetConnection,
      );
      return [];
    }
  }

  Future<List<BasePatientModel>>? getAllPatients(
      RxBool isAllPatientsLoading) async {
    isAllPatientsLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 300));
    var getTokenFromLocal =
        await getStorageLib.getString(AppLocalStrings.keyToken);
    if (await networkInfo.isConnected) {
      try {
        var response = await apiServices.getAllPatients(getTokenFromLocal!);
        if (response.value == true) {
          if (response.basePatientList != null) {
            return response.basePatientList!;
          }
          return [];
        } else {
          isAllPatientsLoading.value = false;
        }
      } catch (e) {
        isAllPatientsLoading.value = false;
        if (e is DioException) {
          // final result = e.response!.data as Map<String, dynamic>;
          // customSnackBar(
          //   isError: true,
          //   title: AppStrings.error,
          //   body: result['message'],
          // );

          DioExceptions.fromDioError(
              dioError: e, errorFrom: 'home_Repo/getAllPatients');
        }
      }
      return [];
    } else {
      isAllPatientsLoading.value = false;
      customSnackBar(
        isError: true,
        title: AppStrings.error,
        body: AppStrings.noInternetConnection,
      );
      return [];
    }
  }

  Future<List<BasePostModel>>? getPosts(
      {required RxBool isPostsLoading}) async {
    if (!Get.isSnackbarOpen) {
      isPostsLoading.value = true;
      await Future.delayed(const Duration(milliseconds: 300));
      if (await networkInfo.isConnected) {
        try {
          var response = await apiServices.getHomePosts();
          if (response.value == true) {
            //  isCommentsLoading.value = false;

            if (response.basePostModel != null) {
              return response.basePostModel!;
            }
            return [];
          } else {
            // isCommentsLoading.value = false;
            return [];
          }
        } catch (e) {
          isPostsLoading.value = false;
          if (e is DioException) {
            // final result = e.response!.data as Map<String, dynamic>;
            // customSnackBar(
            //   isError: true,
            //   title: AppStrings.error,
            //   body: result['message'],
            // );

            DioExceptions.fromDioError(
                dioError: e, errorFrom: 'comment_repo/getComments');
          }
        }
      } else {
        isPostsLoading.value = false;
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
}
