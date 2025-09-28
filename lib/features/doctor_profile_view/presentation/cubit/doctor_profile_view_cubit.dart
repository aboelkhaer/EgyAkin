import 'package:egy_akin/features/doctor_profile_view/presentation/cubit/doctor_profile_view_state.dart';

import '../../../../exports.dart';

class DoctorProfileViewCubit extends Cubit<DoctorProfileViewState> {
  DoctorProfileViewCubit(this._updateDoctorProfileUsecase)
      : super(const DoctorProfileViewState.initial());
  final UpdateDoctorProfileUsecase _updateDoctorProfileUsecase;

  static DoctorProfileViewCubit get(context) => BlocProvider.of(context);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String firstName = '';
  String lastName = '';
  String email = '';
  String phone = '';
  String age = '';
  String job = '';
  String workplace = '';
  String registrationNumber = '';
  String specialty = '';
  String highestDegree = '';

  int profileErrorValid = 0;

  // Original values for comparison
  String originalFirstName = '';
  String originalLastName = '';
  String originalEmail = '';
  String originalPhone = '';
  String originalAge = '';
  String originalJob = '';
  String originalWorkplace = '';
  String originalRegistrationNumber = '';
  String originalSpecialty = '';
  String originalHighestDegree = '';

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
    registrationNumber = currentDoctorModel.registrationNumber ?? '';
    specialty = currentDoctorModel.specialty ?? '';
    highestDegree = currentDoctorModel.highestdegree ?? '';

    // Store original values for comparison
    originalFirstName = firstName;
    originalLastName = lastName;
    originalEmail = email;
    originalPhone = phone;
    originalAge = age;
    originalJob = job;
    originalWorkplace = workplace;
    originalRegistrationNumber = registrationNumber;
    originalSpecialty = specialty;
    originalHighestDegree = highestDegree;

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

  checkForChanges() {
    bool hasChanges = firstName != originalFirstName ||
        lastName != originalLastName ||
        email != originalEmail ||
        phone != originalPhone ||
        age != originalAge ||
        job != originalJob ||
        workplace != originalWorkplace ||
        registrationNumber != originalRegistrationNumber ||
        specialty != originalSpecialty ||
        highestDegree != originalHighestDegree;

    if (hasChanges) {
      profileChangedIsTrue();
    } else {
      profileChangedIsFalse();
    }
  }

  updateDoctorProfile() async {
    if (formKey.currentState?.validate() ?? false) {
      emit(state.maybeMap(
        orElse: () => state,
        loaded: (value) => DoctorProfileViewState.loaded(
            value.currentDoctorModel, false, '', true, false),
      ));
      final result = await _updateDoctorProfileUsecase.execute(
        UpdateDoctorProfileUsecaseInput(
          firstName: firstName,
          lastName: lastName,
          email: email,
          phone: phone,
          age: age,
          job: job,
          workplace: workplace,
          registrationNumber: registrationNumber,
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
          registerationNumber: registrationNumber,
          specialty: specialty,
          highestDegree: highestDegree,
        );

        // Update original values after successful update
        originalFirstName = firstName;
        originalLastName = lastName;
        originalEmail = email;
        originalPhone = phone;
        originalAge = age;
        originalJob = job;
        originalWorkplace = workplace;
        originalRegistrationNumber = registrationNumber;
        originalSpecialty = specialty;
        originalHighestDegree = highestDegree;

        emit(state.maybeMap(
          orElse: () => state,
          loaded: (value) => DoctorProfileViewState.loaded(
              value.currentDoctorModel,
              false,
              r.message.toString(),
              false,
              true),
        ));
      });
    }
  }
}
