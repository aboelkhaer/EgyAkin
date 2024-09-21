import 'package:egy_akin/features/doctor_info_view/data/models/block_user_model_response.dart';
import 'package:egy_akin/features/doctor_info_view/data/models/verify_user_email_model_response.dart';

import '../../../../exports.dart';

abstract class DoctorInfoViewDataSource {
  Future<DoctorInfoViewModelResponse> getDoctorInfoView(String doctorId);
  Future<GetDoctorProfileScoreModelResponse> getScoreHistory(
      int page, String doctorId);
  Future<List<GetAchievementsModelResponse>> getAchievements(String doctorId);
  Future<SyndicateCardVerifyModelResponse> changeSyndicateCardStatus(
      {required String status, required String doctorId});
  Future<BlockUserModelResponse> blockUser(
      {required bool status, required String doctorId});
  Future<VerifyUserEmailModelResponse> verifyDoctorEmail(
      {required String? timestamp, required String doctorId});
}

class DoctorInfoViewDataSourceImpl implements DoctorInfoViewDataSource {
  final ApiServices _apiServices;

  DoctorInfoViewDataSourceImpl(this._apiServices);

  @override
  Future<DoctorInfoViewModelResponse> getDoctorInfoView(String doctorId) async {
    return await _apiServices.getDoctorInfoView(doctorId);
  }

  @override
  Future<GetDoctorProfileScoreModelResponse> getScoreHistory(
      int page, String doctorId) async {
    return await _apiServices.getDoctorProfileScoreHistory(page, doctorId);
  }

  @override
  Future<List<GetAchievementsModelResponse>> getAchievements(
      String doctorId) async {
    return await _apiServices.getAchievements(doctorId);
  }

  @override
  Future<SyndicateCardVerifyModelResponse> changeSyndicateCardStatus(
      {required String status, required String doctorId}) async {
    return await _apiServices.changeSyndicateCardStatus(status, doctorId);
  }

  @override
  Future<BlockUserModelResponse> blockUser(
      {required bool status, required String doctorId}) async {
    return await _apiServices.blockDoctor(status, doctorId);
  }

  @override
  Future<VerifyUserEmailModelResponse> verifyDoctorEmail(
      {required String? timestamp, required String doctorId}) async {
    return await _apiServices.verifyDoctorEmail(timestamp, doctorId);
  }
}
