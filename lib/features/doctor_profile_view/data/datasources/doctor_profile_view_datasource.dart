import '../../../../exports.dart';

abstract class DoctorProfileViewDataSource {
  Future<UpdateDoctorProfileModelResponse> updateDoctorProfile({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String age,
    required String job,
    required String workplace,
    required String registerationNumber,
    required String specialty,
    required String highestDegree,
  });
}

class DoctorProfileViewDataSourceImpl implements DoctorProfileViewDataSource {
  final ApiServices _apiServices;

  DoctorProfileViewDataSourceImpl(this._apiServices);

  @override
  Future<UpdateDoctorProfileModelResponse> updateDoctorProfile(
      {required String firstName,
      required String lastName,
      required String email,
      required String phone,
      required String age,
      required String job,
      required String workplace,
      required String registerationNumber,
      required String specialty,
      required String highestDegree}) async {
    return await _apiServices.updateProfile(firstName, lastName, email, age,
        specialty, workplace, phone, job, highestDegree);
  }
}
