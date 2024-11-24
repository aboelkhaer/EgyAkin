import '../../../../exports.dart';

abstract class ContactUsDataSource {
  Future<ContactUsModelResponseModelResponse> addContactUs(String message);
}

class ContactUsDataSourceImpl implements ContactUsDataSource {
  final ApiServices _apiServices;

  ContactUsDataSourceImpl(this._apiServices);

  @override
  Future<ContactUsModelResponseModelResponse> addContactUs(
      String message) async {
    return await _apiServices.addContactUs(message);
  }
}
