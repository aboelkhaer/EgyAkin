import 'package:egy_akin/features/profile_patients/data/models/get_profile_patients_model_response.dart';

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
