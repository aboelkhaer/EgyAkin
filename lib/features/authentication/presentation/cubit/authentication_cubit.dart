import 'dart:developer';

import '../../../../exports.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit(this._signInUsecase, this._registerUsecase)
      : super(const AuthenticationState.initial());

  final SignInUsecase _signInUsecase;
  final RegisterUsecase _registerUsecase;
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
      await Future.delayed(const Duration(
          milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
      final result = await _signInUsecase.execute(
        SignInUseCaseInput(
          email: signInEmail,
          password: signInPassword,
          fcmToken: fcmToken,
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

        await Future.delayed(const Duration(
            milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
        final result = await _registerUsecase.execute(DoctorModel(
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
          fcmToken: fcmToken,
        ));
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
          context: context, message: 'You must agree to the Privacy Policy.');
    }
  }
  //! ---------------
}
