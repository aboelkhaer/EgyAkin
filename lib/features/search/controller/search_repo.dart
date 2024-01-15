import 'package:dio/dio.dart';
import '../../../exports.dart';

class SearchRepository {
  ApiServices apiServices;
  SearchRepository({required this.apiServices});
  NetworkInfoImpl networkInfo = Get.find<NetworkInfoImpl>();

  Future<List<BasePatientModel>>? searchHome(
      {required String searchContent, required RxBool isSearchLoading}) async {
    if (!Get.isSnackbarOpen) {
      isSearchLoading.value = true;
      await Future.delayed(const Duration(milliseconds: 300));
      if (await networkInfo.isConnected) {
        try {
          var response = await apiServices.searchHome(searchContent);
          if (response.value == true) {
            isSearchLoading.value = false;
            if (response.basePatientList != null) {
              return response.basePatientList!;
            }
            return [];
          } else {
            isSearchLoading.value = false;
            return [];
          }
        } catch (e) {
          isSearchLoading.value = false;
          if (e is DioException) {
            final result = e.response!.data as Map<String, dynamic>;
            customSnackBar(
              isError: true,
              title: AppStrings.error,
              body: result[AppStrings.message],
            );

            DioExceptions.fromDioError(
                dioError: e, errorFrom: 'search_Repo/searchHome');
          }
        }
      } else {
        isSearchLoading.value = false;
        customSnackBar(
          isError: true,
          title: AppStrings.error,
          body: AppStrings.somethingWentWrong,
        );
      }
      return [];
    } else {
      return [];
    }
  }
}
