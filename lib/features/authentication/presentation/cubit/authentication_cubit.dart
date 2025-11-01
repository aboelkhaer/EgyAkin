import 'dart:developer';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:egy_akin/app/shared/functions/device_info_helper.dart';
import 'package:egy_akin/features/authentication/domain/usecases/sign_in_with_google_usecase.dart';

import '../../../../exports.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit(
      this._signInUsecase, this._registerUsecase, this._signInWithGoogleUsecase)
      : super(const AuthenticationState.initial());

  final SignInUsecase _signInUsecase;
  final RegisterUsecase _registerUsecase;
  final SignInWithGoogleUsecase _signInWithGoogleUsecase;
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
        (doctorModel) async {
          emit(AuthenticationState.loaded(doctorModel, true, false));
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
  int registerErrorValid = 0;

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
              phone: registerPhone,
              age: registerAge,
              job: registerJop,
              workingplace: registerWorkplace,
              registrationNumber: registerRegistrationNumber,
              specialty: registerSpecialty,
              highestdegree: registerHighestDegree,
              fcmToken: fcmToken == 'No fcmToken' ? null : fcmToken,
              deviceId: deviceId,
            ),
          ),
        );
        result.fold(
          (l) {
            emit(AuthenticationState.error(l.message));
          },
          (doctorModel) async {
            emit(AuthenticationState.loaded(doctorModel, false, true));
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
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        // User cancelled the sign-in
        emit(const AuthenticationState.initial());
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final String? accessToken = googleAuth.accessToken;

      if (accessToken == null) {
        emit(const AuthenticationState.error('Failed to get access token'));
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
        ),
      );
      result.fold(
        (l) {
          emit(AuthenticationState.error(l.message));
        },
        (doctorModel) async {
          emit(AuthenticationState.loaded(doctorModel, true, false));
        },
      );
    } catch (e) {
      emit(AuthenticationState.error(e.toString()));
    }
  }
}
