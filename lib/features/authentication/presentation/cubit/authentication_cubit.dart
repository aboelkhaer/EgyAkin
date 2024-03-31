import '../../../../exports.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit(this._signInUsecase, this._registerUsecase)
      : super(const AuthenticationState.initial());

  final SignInUsecase _signInUsecase;
  final RegisterUsecase _registerUsecase;
  static AuthenticationCubit get(context) => BlocProvider.of(context);

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
      final result = await _signInUsecase.excute(
        SignInUseCaseInput(
          email: signInEmail,
          password: signInPassword,
        ),
      );
      result.fold(
        (l) {
          emit(AuthenticationState.error(l.message));
        },
        (doctorModel) async {
          emit(AuthenticationState.loaded(doctorModel));
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

  List<String> highestDegreeList = [
    'MBBCH',
    'Master Degree',
    'Fellowship',
    'MD',
    'Other'
  ];

  Future register() async {
    if (registerFormKey.currentState!.validate()) {
      emit(const AuthenticationState.loading());
      await Future.delayed(const Duration(
          milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
      final result = await _registerUsecase.excute(DoctorModel(
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
      ));
      result.fold(
        (l) {
          emit(AuthenticationState.error(l.message));
        },
        (doctorModel) async {
          emit(AuthenticationState.loaded(doctorModel));
        },
      );
    }
  }
  //! ---------------
}
