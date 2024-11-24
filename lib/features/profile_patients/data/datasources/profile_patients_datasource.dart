import '../../../../exports.dart';

abstract class ProfilePatientsDataSource {
  Future<GetProfilePatientsModelResponse> getProfilePatients({
    required int pageNumber,
    required String doctorId,
  });
}

class ProfilePatientsDataSourceImpl implements ProfilePatientsDataSource {
  final ApiServices _apiServices;

  ProfilePatientsDataSourceImpl(this._apiServices);

  @override
  Future<GetProfilePatientsModelResponse> getProfilePatients(
      {required int pageNumber, required String doctorId}) async {
    return _apiServices.getProfilePatients(pageNumber, doctorId);
  }
}
