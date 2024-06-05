import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../exports.dart';

abstract class LocalStorageProcess {
  Future<void> setData(String key, dynamic value);
  Future<int>? getInt(String key);
  Future<String>? getString(String key);
  Future<bool>? getBool(String key);
  Future<double>? getDouble(String key);
  Future<dynamic> getDynamicData(String key);
  Future<void> clearAllData();
  Future<void> removeData(String key);
  Future<void> removeDoctorData();
  Future<void> setDoctorData(DoctorModel doctorModel);
  Future<DoctorModel?> getDoctorData();
  Future<void> setBool(String key, bool value);
  Future<void> updateDoctorImageData(String newImageUrl);
  Future<void> updateDoctorProfile({
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

class AppPreferences implements LocalStorageProcess {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  @override
  Future<bool>? getBool(String key) async {
    return _sharedPreferences.getBool(key) ?? false;
  }

  @override
  Future setBool(String key, bool value) async {
    return _sharedPreferences.setBool(key, value);
  }

  @override
  Future<double>? getDouble(String key) async {
    return _sharedPreferences.getDouble(key) ?? 0.0;
  }

  @override
  Future getDynamicData(String key) {
    throw UnimplementedError();
  }

  @override
  Future<int>? getInt(String key) async {
    return _sharedPreferences.getInt(key) ?? 0;
  }

  @override
  Future<String>? getString(String key) async {
    return _sharedPreferences.getString(key) ?? '';
  }

  @override
  Future<void> setData(String key, value) async {
    await _sharedPreferences.setString(key, value);
  }

  @override
  Future<void> removeData(String key) async {
    await _sharedPreferences.remove(key);
  }

  @override
  Future<void> clearAllData() async {
    await _sharedPreferences.clear();
  }

  @override
  Future<void> setDoctorData(DoctorModel doctorModel) async {
    final modelContainer = jsonEncode(doctorModel.toJson());
    await _sharedPreferences.setString(
        AppLocalStrings.doctorData, modelContainer);
  }

  @override
  Future<DoctorModel?> getDoctorData() async {
    final json = _sharedPreferences.getString(AppLocalStrings.doctorData);
    if (json != null) {
      final Map<String, dynamic> map = jsonDecode(json);
      return DoctorModel.fromJson(map);
    }
    return null;
  }

  @override
  Future<void> removeDoctorData() async {
    await _sharedPreferences.remove(AppLocalStrings.keyToken);
    await _sharedPreferences.remove(AppLocalStrings.doctorData);
  }

  @override
  Future<void> updateDoctorImageData(String newImageUrl) async {
    // Retrieve the doctor model from shared preferences
    final doctorModelString =
        _sharedPreferences.getString(AppLocalStrings.doctorData);
    if (doctorModelString != null) {
      final doctorMap = jsonDecode(doctorModelString) as Map<String, dynamic>;
      final doctorModel = DoctorModel.fromJson(doctorMap);

      // Update the image parameter in the doctor model
      final updatedDoctorModel = doctorModel.copyWith(image: newImageUrl);

      // Save the updated doctor model back to shared preferences
      await setDoctorData(updatedDoctorModel);
    }
  }

  @override
  Future<void> updateDoctorProfile(
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
    // Retrieve the doctor model from shared preferences
    final doctorModelString =
        _sharedPreferences.getString(AppLocalStrings.doctorData);
    if (doctorModelString != null) {
      final doctorMap = jsonDecode(doctorModelString) as Map<String, dynamic>;
      final doctorModel = DoctorModel.fromJson(doctorMap);

      // Update the image parameter in the doctor model
      final updatedDoctorModel = doctorModel.copyWith(
        firstName: firstName,
        lastName: lastName,
        email: email,
        phone: phone,
        age: age,
        job: job,
        workingplace: workplace,
        registrationNumber: registerationNumber,
        specialty: specialty,
        highestdegree: highestDegree,
      );

      // Save the updated doctor model back to shared preferences
      await setDoctorData(updatedDoctorModel);
    }
  }
}
