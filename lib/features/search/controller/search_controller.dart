import '../../../exports.dart';

class SearchHomeController extends GetxController {
  SearchRepository searchRepository = Get.find<SearchRepository>();
  RxList<BasePatientModel> patientSearchResult = <BasePatientModel>[].obs;
  RxBool isSearchLoading = false.obs;

  searchHome({
    required String searchText,
  }) async {
    isSearchLoading(true);
    if (searchText.trim() != '') {
      var ttttt = await searchRepository.searchHome(
          searchContent: searchText, isSearchLoading: isSearchLoading);

      patientSearchResult.value = ttttt as List<BasePatientModel>;
      patientSearchResult.refresh();
    }
    isSearchLoading(false);

    update();
  }
}
