import 'package:egy_akin/features/authentication/data/models/authentication_with_google_model_response.dart';

import '../../../../exports.dart';

abstract class ChatRoomDataSource {}

class ChatRoomDataSourceImpl implements ChatRoomDataSource {
  final ApiServices _apiServices;

  ChatRoomDataSourceImpl(this._apiServices);
}
