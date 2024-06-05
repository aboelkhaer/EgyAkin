import 'package:egy_akin/features/doctor_profile_view/domain/usecases/update_doctor_profile_usecase.dart';
import 'package:egy_akin/features/doctor_profile_view/presentation/cubit/doctor_profile_view_state.dart';

import '../../../../exports.dart';

class DoctorProfileViewCubit extends Cubit<DoctorProfileViewState> {
  DoctorProfileViewCubit(this._updateDoctorProfileUsecase)
      : super(const DoctorProfileViewState.initial());
  final UpdateDoctorProfileUsecase _updateDoctorProfileUsecase;

  static DoctorProfileViewCubit get(context) => BlocProvider.of(context);
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String firstName = '';
  String lastName = '';
  String email = '';
  String phone = '';
  String age = '';
  String job = '';
  String workplace = '';
  String registerationNumber = '';
  String specialty = '';
  String highestDegree = '';

  int profileErrorValid = 0;

  getCurrentDoctorModelFromLocal() async {
    emit(const DoctorProfileViewState.loading());
    await Future.delayed(const Duration(
        milliseconds: AppStrings.delayForAPIRequestInMilliseconds));

    DoctorModel currentDoctorModel =
        (await sl<AppPreferences>().getDoctorData())!;
    firstName = currentDoctorModel.firstName ?? '';
    lastName = currentDoctorModel.lastName ?? '';
    email = currentDoctorModel.email ?? '';
    phone = currentDoctorModel.phone ?? '';
    age = currentDoctorModel.age ?? '';
    job = currentDoctorModel.job ?? '';
    workplace = currentDoctorModel.workingplace ?? '';
    registerationNumber = currentDoctorModel.registrationNumber ?? '';
    specialty = currentDoctorModel.specialty ?? '';
    highestDegree = currentDoctorModel.highestdegree ?? '';
    emit(DoctorProfileViewState.loaded(
        currentDoctorModel, false, '', false, false));
  }

  profileChangedIsTrue() {
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) => DoctorProfileViewState.loaded(
          value.currentDoctorModel, true, '', false, false),
    ));
  }

  profileChangedIsFalse() {
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) => DoctorProfileViewState.loaded(
          value.currentDoctorModel, false, '', false, false),
    ));
  }

  updateDoctorProfile() async {
    // if (formKey.currentState!.validate()) {
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) => DoctorProfileViewState.loaded(
          value.currentDoctorModel, false, '', true, false),
    ));
    final result = await _updateDoctorProfileUsecase.excute(
      UpdateDoctorProfileUsecaseInput(
        firstName: firstName,
        lastName: lastName,
        email: email,
        phone: phone,
        age: age,
        job: job,
        workplace: workplace,
        registerationNumber: registerationNumber,
        specialty: specialty,
        highestDegree: highestDegree,
      ),
    );
    result.fold((l) {
      emit(state.maybeMap(
        orElse: () => state,
        loaded: (value) => DoctorProfileViewState.loaded(
            value.currentDoctorModel, false, l.message, false, false),
      ));
    }, (r) async {
      await sl<AppPreferences>().updateDoctorProfile(
        firstName: firstName,
        lastName: lastName,
        email: email,
        phone: phone,
        age: age,
        job: job,
        workplace: workplace,
        registerationNumber: registerationNumber,
        specialty: specialty,
        highestDegree: highestDegree,
      );
      emit(state.maybeMap(
        orElse: () => state,
        loaded: (value) => DoctorProfileViewState.loaded(
            value.currentDoctorModel, false, r.message.toString(), false, true),
      ));
    });
    // }
  }
}
