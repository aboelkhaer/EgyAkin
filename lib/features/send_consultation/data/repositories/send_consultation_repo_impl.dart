import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/send_consultation/data/models/add_doctors_for_consultation_model_response.dart';
import 'package:egy_akin/features/send_consultation/data/models/get_members_for_consultation_model_response.dart';
import 'package:egy_akin/features/send_consultation/data/models/remove_member_from_consultation_model_response.dart';
import 'package:egy_akin/features/send_consultation/data/models/send_invitation_model_response.dart';

import '../../../../exports.dart';

class SendConsultationRepositoryImpl extends SendConsultationRepository {
  final SendConsultationDataSource sendConsultationDataSource;
  final NetworkInfo networkInfo;

  SendConsultationRepositoryImpl(
      this.sendConsultationDataSource, this.networkInfo);

  @override
  Future<Either<Failure, GetConsultationSearchModelResponse>>
      consultationDoctorSearch({required String searchContent}) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response = await sendConsultationDataSource
            .consultationDoctorSearch(searchContent: searchContent);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }

  @override
  Future<Either<Failure, SendConsultationModelResponse>> sendConsultation({
    required String patientId,
    required String message,
    required List<String> doctorsIDS,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response = await sendConsultationDataSource.sendConsultation(
            patientId: patientId, message: message, doctorsIDS: doctorsIDS);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }

  @override
  Future<Either<Failure, SendInvitationModelResponse>> sendGroupInvitation(
      {required String groupId,
      required String message,
      required List<String> doctorsIDS}) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response = await sendConsultationDataSource.sendGroupInvitation(
            groupId: groupId, message: message, doctorsIDS: doctorsIDS);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }
  @override
  Future<Either<Failure, GetMembersForConsultationModelResponse>> getMembersForConsultation({required String consultationId}) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response = await sendConsultationDataSource.getMembersForConsultation(consultationId: consultationId);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }
  @override
  Future<Either<Failure, RemoveMemberFromConsultationModelResponse>> removeMemberFromConsultation({required String consultationId, required String doctorId}) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response = await sendConsultationDataSource.removeMemberFromConsultation(consultationId: consultationId, doctorId: doctorId);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }

  @override
  Future<Either<Failure, AddDoctorsForConsultationModelResponse>> addDoctorsForConsultation({required String consultationId, required String message, required List<String> doctorsIDS}) async {
    if (await networkInfo.isConnected) {
      try {
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final response = await sendConsultationDataSource.addDoctorsForConsultation(consultationId: consultationId, message: message, doctorsIDS: doctorsIDS);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }



}
