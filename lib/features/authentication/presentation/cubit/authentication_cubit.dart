import 'dart:convert';
import 'dart:developer';
import 'package:flutter/services.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:egy_akin/app/shared/functions/device_info_helper.dart';
import 'package:egy_akin/app/shared/functions/permissions_helper.dart';
import 'package:egy_akin/features/authentication/domain/usecases/sign_in_with_google_usecase.dart';
import 'package:egy_akin/features/authentication/domain/usecases/sign_in_with_apple_usecase.dart';

import '../../../../exports.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit(this._signInUsecase, this._registerUsecase,
      this._signInWithGoogleUsecase, this._signInWithAppleUsecase)
      : super(const AuthenticationState.initial());

  final SignInUsecase _signInUsecase;
  final RegisterUsecase _registerUsecase;
  final SignInWithGoogleUsecase _signInWithGoogleUsecase;
  final SignInWithAppleUsecase _signInWithAppleUsecase;
  // final SendFCMTokenUsecase _sendFCMTokenUsecase;
  static AuthenticationCubit get(context) => BlocProvider.of(context);
  bool isConfirmationChecked = false;
  String fcmToken = '';
  getFCMToken() async {
    sl<NotificationServices>().getDeviceToken().then((value) {
      fcmToken = value.toString();
      log('fcmToken: $fcmToken');
    });
  }

  int changedCounter = 0;
  refreshScreen() {
    emit(AuthenticationState.checkConfirmation(changedCounter));
    changedCounter += 1;
  }

  //! Sign in
  GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();
  int signInErrorValidCounter = 0;
  String signInEmail = '';
  String signInPassword = '';

  bool signInObscureText = true;
  bool signInVisiblePasswordIcon = false;

  showPasswordFunction() {
    signInVisiblePasswordIcon = !signInVisiblePasswordIcon;
    signInObscureText = !signInObscureText;
    emit(AuthenticationState.changePasswordVisibility(
        signInObscureText, signInVisiblePasswordIcon));
  }

  signIn() async {
    if (signInFormKey.currentState!.validate()) {
      emit(const AuthenticationState.loading());
      final String deviceId = await DeviceIdService.getPersistentDeviceId();
      await Future.delayed(const Duration(
          milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
      debugPrint(deviceId);
      final result = await _signInUsecase.execute(
        SignInUseCaseInput(
          email: signInEmail,
          password: signInPassword,
          fcmToken: fcmToken == 'No fcmToken' ? null : fcmToken,
          deviceId: deviceId,
        ),
      );
      result.fold(
        (l) {
          emit(AuthenticationState.error(l.message));
        },
        (response) async {
          // Save permissions to local storage
          if (response.permissions != null &&
              response.permissions!.isNotEmpty) {
            final permissionsJson = jsonEncode(response.permissions);
            await sl<AppPreferences>()
                .setData(AppLocalStrings.permissions, permissionsJson);
            // Refresh permission cache
            await PermissionHelper.refreshPermissions();
          }

          emit(AuthenticationState.loaded(response, true, false));
        },
      );
    }
  }
  //! ---------------

  //! Register
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  final TextEditingController registerPasswordController =
      TextEditingController();
  String registerFirstName = '',
      registerLastName = '',
      registerEmail = '',
      registerPasswordConformation = '',
      registerPhone = '',
      registerAge = '',
      registerJop = '',
      registerWorkplace = '',
      registerRegistrationNumber = '',
      registerSpecialty = '',
      registerHighestDegree = '';
  bool isMedicalStatistics = false;
  int registerErrorValid = 0;

  void toggleMedicalStatistics(bool value) {
    isMedicalStatistics = value;
    refreshScreen();
  }

  Future register(context) async {
    if (isConfirmationChecked) {
      if (registerFormKey.currentState!.validate()) {
        emit(const AuthenticationState.loading());
        final String deviceId = await DeviceIdService.getPersistentDeviceId();
        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        debugPrint(deviceId);
        final result = await _registerUsecase.execute(
          RegisterUsecaseInput(
            doctorModel: DoctorModel(
              firstName: registerFirstName,
              lastName: registerLastName,
              email: registerEmail,
              password: registerPasswordController.text,
              passwordConfirmation: registerPasswordConformation,
              phone: isMedicalStatistics ? registerPhone : null,
              age: isMedicalStatistics ? registerAge : null,
              job: isMedicalStatistics ? registerJop : null,
              workingplace: isMedicalStatistics ? registerWorkplace : null,
              registrationNumber:
                  isMedicalStatistics ? registerRegistrationNumber : null,
              specialty: isMedicalStatistics ? registerSpecialty : null,
              highestdegree: isMedicalStatistics ? registerHighestDegree : null,
              fcmToken: fcmToken == 'No fcmToken' ? null : fcmToken,
              deviceId: deviceId,
              userType: isMedicalStatistics ? 'medical_statistics' : 'normal',
            ),
          ),
        );
        result.fold(
          (l) {
            emit(AuthenticationState.error(l.message));
          },
          (response) async {
            // Save permissions to local storage (same as signIn)
            if (response.permissions != null &&
                response.permissions!.isNotEmpty) {
              final permissionsJson = jsonEncode(response.permissions);
              await sl<AppPreferences>()
                  .setData(AppLocalStrings.permissions, permissionsJson);
              await PermissionHelper.refreshPermissions();
            }
            emit(AuthenticationState.loaded(response, false, true));
          },
        );
      }
    } else {
      customSnackBar(
          context: context,
          message: LocalizationService.instance
              .translate(AppStrings.youMustAgreeToThePrivacyPolicy));
    }
  }
  //! ---------------

  //! Sign in with Google
  signInWithGoogle() async {
    emit(const AuthenticationState.loading());

    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['email', 'profile'],
      );

      GoogleSignInAccount? googleUser;
      try {
        googleUser = await googleSignIn.signIn();
      } on PlatformException catch (e) {
        log('Google Sign-In PlatformException: ${e.code} - ${e.message}');
        String errorMessage = 'Google Sign-In failed';

        if (e.code == 'sign_in_canceled') {
          // User cancelled - just return to initial state
          emit(const AuthenticationState.initial());
          return;
        } else if (e.code == 'sign_in_failed' ||
            e.code == 'network_error' ||
            e.code == 'channel-error') {
          errorMessage =
              'Network error. Please check your connection and try again.';
        } else if (e.message?.contains('GIDClientID') == true ||
            e.message?.contains('No active configuration') == true ||
            e.message?.contains('Info.plist') == true) {
          errorMessage =
              'Google Sign-In is not configured. Please contact support.';
        } else if (e.message != null && e.message!.isNotEmpty) {
          errorMessage = 'Google Sign-In error: ${e.message}';
        }

        emit(AuthenticationState.error(errorMessage));
        return;
      } catch (e) {
        log('Google Sign-In error: $e');
        emit(const AuthenticationState.error(
            'Google Sign-In failed. Please try again.'));
        return;
      }

      if (googleUser == null) {
        // User cancelled the sign-in
        emit(const AuthenticationState.initial());
        return;
      }

      GoogleSignInAuthentication googleAuth;
      try {
        googleAuth = await googleUser.authentication;
      } catch (e) {
        log('Error getting authentication: $e');
        emit(const AuthenticationState.error(
            'Failed to authenticate with Google. Please try again.'));
        return;
      }

      final String? accessToken = googleAuth.accessToken;

      if (accessToken == null) {
        emit(const AuthenticationState.error(
            'Failed to get access token from Google. Please try again.'));
        return;
      }

      final String deviceId = await DeviceIdService.getPersistentDeviceId();
      await Future.delayed(const Duration(
          milliseconds: AppStrings.delayForAPIRequestInMilliseconds));

      debugPrint(deviceId);

      final result = await _signInWithGoogleUsecase.execute(
        SignInWithGoogleUseCaseInput(
          accessToken: accessToken,
          deviceId: deviceId,
          fcmToken: fcmToken == 'No fcmToken' ? null : fcmToken,
        ),
      );
      result.fold(
        (l) {
          emit(AuthenticationState.error(l.message));
        },
        (response) async {
          // Save token and doctor data (same as signIn function)
          // Ensure token is saved before emitting loaded state
          log(response.data!.token.toString());
          final token = response.data!.token ?? '';
          if (token.isNotEmpty) {
            await sl<AppPreferences>().setData(AppLocalStrings.keyToken, token);
            // Verify token was saved
            final savedToken =
                await sl<AppPreferences>().getString(AppLocalStrings.keyToken);
            log('Token saved: ${(savedToken ?? '').isNotEmpty ? "Success" : "Failed"}');
            // Small delay to ensure SharedPreferences is fully committed
            await Future.delayed(const Duration(milliseconds: 50));
          }
          await sl<AppPreferences>().setDoctorData(response.data!.doctorModel!);

          // Save permissions to local storage
          if (response.data!.permissions != null &&
              response.data!.permissions!.isNotEmpty) {
            final permissionsJson = jsonEncode(response.data!.permissions);
            await sl<AppPreferences>()
                .setData(AppLocalStrings.permissions, permissionsJson);
            // Refresh permission cache
            await PermissionHelper.refreshPermissions();
          }

          // Convert AuthenticationWithGoogleModelResponse to AuthenticationModelResponse
          // since they have the same structure
          final authenticationResponse = AuthenticationModelResponse(
            value: true, // Success indicator for authentication
            token: response.data!.token,
            doctorModel: response.data!.doctorModel,
            provider: response.data!.provider,
            permissions: response.data!.permissions,
          );
          emit(AuthenticationState.loaded(authenticationResponse, true, false));
        },
      );
    } on PlatformException catch (e) {
      log('PlatformException in signInWithGoogle: ${e.code} - ${e.message}');
      String errorMessage = 'Google Sign-In failed';

      if (e.code == 'sign_in_canceled') {
        emit(const AuthenticationState.initial());
        return;
      } else if (e.message?.contains('GIDClientID') == true ||
          e.message?.contains('No active configuration') == true) {
        errorMessage =
            'Google Sign-In is not configured. Please contact support.';
      } else if (e.message != null && e.message!.isNotEmpty) {
        errorMessage = 'Google Sign-In error: ${e.message}';
      }

      emit(AuthenticationState.error(errorMessage));
    } catch (e, stackTrace) {
      log('Unexpected error in signInWithGoogle: $e');
      log('Stack trace: $stackTrace');
      emit(const AuthenticationState.error(
          'An unexpected error occurred. Please try again.'));
    }
  }

  //! Sign in with Apple
  signInWithApple() async {
    emit(const AuthenticationState.loading());

    try {
      // Check if Apple Sign-In is available
      final isAvailable = await SignInWithApple.isAvailable();
      if (!isAvailable) {
        emit(const AuthenticationState.error(
            'Apple Sign-In is not available on this device. Please use iOS 13.0 or later.'));
        return;
      }

      // Request Apple Sign-In
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final String? identityToken = appleCredential.identityToken;
      final String authorizationCode = appleCredential.authorizationCode;

      if (identityToken == null) {
        emit(const AuthenticationState.error(
            'Failed to get credentials from Apple. Please try again.'));
        return;
      }

      final String deviceId = await DeviceIdService.getPersistentDeviceId();
      await Future.delayed(const Duration(
          milliseconds: AppStrings.delayForAPIRequestInMilliseconds));

      debugPrint(deviceId);

      final result = await _signInWithAppleUsecase.execute(
        SignInWithAppleUseCaseInput(
          identityToken: identityToken,
          authorizationCode: authorizationCode,
          deviceId: deviceId,
          fcmToken: fcmToken == 'No fcmToken' ? null : fcmToken,
        ),
      );
      result.fold(
        (l) {
          emit(AuthenticationState.error(l.message));
        },
        (response) async {
          // Save token and doctor data (same as signIn function)
          // Ensure token is saved before emitting loaded state
          log(response.data!.token.toString());
          final token = response.data!.token ?? '';
          if (token.isNotEmpty) {
            await sl<AppPreferences>().setData(AppLocalStrings.keyToken, token);
            // Verify token was saved
            final savedToken =
                await sl<AppPreferences>().getString(AppLocalStrings.keyToken);
            log('Token saved: ${(savedToken ?? '').isNotEmpty ? "Success" : "Failed"}');
            // Small delay to ensure SharedPreferences is fully committed
            await Future.delayed(const Duration(milliseconds: 50));
          }
          await sl<AppPreferences>().setDoctorData(response.data!.doctorModel!);

          // Save permissions to local storage
          if (response.data!.permissions != null &&
              response.data!.permissions!.isNotEmpty) {
            final permissionsJson = jsonEncode(response.data!.permissions);
            await sl<AppPreferences>()
                .setData(AppLocalStrings.permissions, permissionsJson);
            // Refresh permission cache
            await PermissionHelper.refreshPermissions();
          }

          // Convert AuthenticationWithGoogleModelResponse to AuthenticationModelResponse
          // since they have the same structure
          final authenticationResponse = AuthenticationModelResponse(
            value: true, // Success indicator for authentication
            token: response.data!.token,
            doctorModel: response.data!.doctorModel,
            provider: response.data!.provider,
            permissions: response.data!.permissions,
          );
          emit(AuthenticationState.loaded(authenticationResponse, true, false));
        },
      );
    } on SignInWithAppleAuthorizationException catch (e) {
      log('Apple Sign-In AuthorizationException: ${e.code} - ${e.message}');
      String errorMessage = 'Apple Sign-In failed';

      if (e.code == AuthorizationErrorCode.canceled) {
        // User cancelled - just return to initial state
        emit(const AuthenticationState.initial());
        return;
      } else if (e.code == AuthorizationErrorCode.unknown) {
        // Error 1000 - Configuration issue
        errorMessage =
            'Apple Sign-In is not properly configured. Please ensure:\n'
            '1. Sign in with Apple capability is enabled in your Apple Developer account\n'
            '2. The capability is enabled in Xcode project settings\n'
            '3. Your app is signed with a valid provisioning profile\n'
            '4. The bundle identifier matches your Apple Developer account';
      } else if (e.code == AuthorizationErrorCode.failed ||
          e.code == AuthorizationErrorCode.invalidResponse ||
          e.code == AuthorizationErrorCode.notHandled) {
        errorMessage =
            'Network error. Please check your connection and try again.';
      } else if (e.message.isNotEmpty) {
        errorMessage = 'Apple Sign-In error: ${e.message}';
      }

      emit(AuthenticationState.error(errorMessage));
    } catch (e, stackTrace) {
      log('Unexpected error in signInWithApple: $e');
      log('Stack trace: $stackTrace');
      emit(const AuthenticationState.error(
          'An unexpected error occurred. Please try again.'));
    }
  }
}
