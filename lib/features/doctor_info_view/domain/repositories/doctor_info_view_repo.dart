import 'package:egy_akin/features/doctor_info_view/data/models/block_user_model_response.dart';
import 'package:egy_akin/features/doctor_info_view/data/models/verify_user_email_model_response.dart';

import '../../../../exports.dart';
import 'package:dartz/dartz.dart';

abstract class DoctorInfoViewRepository {
  Future<Either<Failure, DoctorInfoViewModelResponse>> getDoctorInfo(
      String doctorId);

  Future<Either<Failure, GetDoctorProfileScoreModelResponse>> getScoreHistory(
      {required int page, required String doctorId});

  Future<Either<Failure, List<GetAchievementsModelResponse>>> getAchievements(
      String doctorId);
  Future<Either<Failure, SyndicateCardVerifyModelResponse>>
      changeSyndicateCardStatus({
    required String status,
    required String doctorId,
  });

  Future<Either<Failure, BlockUserModelResponse>> blockUser(
      {required String doctorId, required bool status});
  Future<Either<Failure, VerifyUserEmailModelResponse>> verifyDoctorEmail(
      {required String doctorId, required String? timestamp});
}
