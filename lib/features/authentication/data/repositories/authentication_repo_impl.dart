import 'package:dartz/dartz.dart';
import 'package:egy_akin/features/authentication/data/models/authentication_with_google_model_response.dart';
import '../../../../exports.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final AuthenticationDataSource authenticationRemoteDataSource;
  final NetworkInfo networkInfo;

  AuthenticationRepositoryImpl(
      this.authenticationRemoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, AuthenticationModelResponse>> signIn({
    required String email,
    required String password,
    required String? fcmToken,
    required String deviceId,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await authenticationRemoteDataSource.signIn(
          email: email,
          password: password,
          fcmToken: fcmToken,
          deviceId: deviceId,
        );
        await sl<AppPreferences>()
            .setData(AppLocalStrings.keyToken, response.token ?? '');
        await sl<AppPreferences>().setDoctorData(response.doctorModel!);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }

  @override
  Future<Either<Failure, AuthenticationModelResponse>> register({
    required DoctorModel doctorModel,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await authenticationRemoteDataSource.register(
          doctorModel: doctorModel,
        );
        await sl<AppPreferences>()
            .setData(AppLocalStrings.keyToken, response.token ?? '');
        await sl<AppPreferences>().setDoctorData(response.doctorModel!);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }

  @override
  Future<Either<Failure, SendFCMTokenModelResponse>> sendFCMToken(
      {required String? fcmToken}) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await authenticationRemoteDataSource.sendFCMToken(
            fcmToken: fcmToken);

        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }

  @override
  Future<Either<Failure, AuthenticationWithGoogleModelResponse>> signInWithGoogle({
    required String? accessToken,
    required String deviceId,
    required String? fcmToken,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await authenticationRemoteDataSource.signInWithGoogle(
            accessToken: accessToken, deviceId: deviceId, fcmToken: fcmToken);
        await sl<AppPreferences>()
            .setData(AppLocalStrings.keyToken, response.data!.token ?? '');
        await sl<AppPreferences>().setDoctorData(response.data!.doctorModel!);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }

  @override
  Future<Either<Failure, AuthenticationWithGoogleModelResponse>> signInWithApple({
    required String? identityToken,
    required String? authorizationCode,
    required String deviceId,
    required String? fcmToken,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await authenticationRemoteDataSource.signInWithApple(
            identityToken: identityToken, authorizationCode: authorizationCode, deviceId: deviceId, fcmToken: fcmToken);
        await sl<AppPreferences>()
            .setData(AppLocalStrings.keyToken, response.data!.token ?? '');
        await sl<AppPreferences>().setDoctorData(response.data!.doctorModel!);
        return Right(response);
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.noInternetConnection.getFailure());
  }
}
