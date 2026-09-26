import 'package:egy_akin/features/inbox/data/models/get_inbox_model_response.dart';

import '../../../../exports.dart';

abstract class InboxDataSource {
  Future<GetInboxModelResponse> getInbox({
    required String filter,
    required int page,
    int perPage = 20,
    int? archived,
  });
}

class InboxDataSourceImpl implements InboxDataSource {
  final ApiServices _apiServices;

  InboxDataSourceImpl(this._apiServices);

  @override
  Future<GetInboxModelResponse> getInbox({
    required String filter,
    required int page,
    int perPage = 20,
    int? archived,
  }) {
    return _apiServices.getInbox(
      filter,
      page,
      perPage,
      archived: archived,
    );
  }
}
