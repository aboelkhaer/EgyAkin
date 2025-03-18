import 'package:egy_akin/features/saved_posts/data/models/get_saved_posts_model_response.dart';

import '../../../../exports.dart';

abstract class SavedPostsDataSource {
  Future<GetSavedPostsModelResponse> getSavedPosts(
    String doctorId,
    int page,
  );
}

class SavedPostsDataSourceImpl implements SavedPostsDataSource {
  final ApiServices _apiServices;

  SavedPostsDataSourceImpl(this._apiServices);

  @override
  Future<GetSavedPostsModelResponse> getSavedPosts(
      String doctorId, int page) async {
    return await _apiServices.getSavedPosts(doctorId, page);
  }
}
