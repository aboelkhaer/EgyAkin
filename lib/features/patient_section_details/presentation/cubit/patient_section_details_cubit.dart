import 'dart:developer';

import '../../../../exports.dart';

class PatientSectionDetailsCubit extends Cubit<PatientSectionDetailsState> {
  PatientSectionDetailsCubit(this._getPatientSectionDetailsUsecase,
      this._updatePatientSectionDetailsUsecase)
      : super(const PatientSectionDetailsState.initial());
  final GetPatientSectionDetailsUsecase _getPatientSectionDetailsUsecase;
  final UpdatePatientSectionDetailsUsecase _updatePatientSectionDetailsUsecase;
  static PatientSectionDetailsCubit get(context) => BlocProvider.of(context);

  ScrollController scrollController = ScrollController();
  List<QuestionModel> questionModelList = [];
  Map<String, dynamic> formData = {};
  GlobalKey<FormState> sectionDetailsKeyForm = GlobalKey<FormState>();
  int snackbarErrorCounter = 0;
  getPatientSectionDetails(String sectionId, String patientId) async {
    emit(const PatientSectionDetailsState.loading());
    final result = await _getPatientSectionDetailsUsecase.excute(
        GetPatientSectionDetailsUsecaseInput(
            patientId: patientId, sectionId: sectionId));

    result.fold(
      (l) {
        emit(PatientSectionDetailsState.error(l.message));
      },
      (response) async {
        questionModelList = response.data!;
        emit(PatientSectionDetailsState.loaded(
            response.data!, false, false, '', 0));
      },
    );
  }

  updatePatientSectionDetails(
      String sectionId, String patientId, List<QuestionModel> questions) async {
    bool isValid = true;

    for (var question in questions) {
      // if (question.question == 'Hospital') {
      //   log(question.toString());
      // }
      if (question.mandatory == true) {
        if (question.type == 'multiple') {
          Map myMap = question.answer;
          // ??
          //     {
          //       "answers": [],
          //       "other_field": '',
          //     };
          // Map myMap = formData[question.id.toString()] ??= {
          //   "answers": [],
          //   "other_field": ''
          // };

          // Check if "answers" key is either null or an empty list
          if (myMap.containsKey('answers')) {
            dynamic answersValue = myMap['answers'];

            if (answersValue == null ||
                (answersValue is List && answersValue.isEmpty)) {
              debugPrint('"answers" key is either null or an empty list.');

              emit(state.maybeMap(
                orElse: () => state,
                loaded: (value) => PatientSectionDetailsState.loaded(
                    value.questions,
                    false,
                    false,
                    'You must select at least one choice. \n{${question.question}}',
                    snackbarErrorCounter += 1),
              ));

              isValid = false;
              break;
            } else {
              debugPrint(
                  '"answers" key is present and has a non-empty list value: $answersValue');
            }
          } else {
            debugPrint('"answers" key is not present in the map.');

            emit(state.maybeMap(
              orElse: () => state,
              loaded: (value) => PatientSectionDetailsState.loaded(
                  value.questions,
                  false,
                  false,
                  AppStrings.somethingWentWrong,
                  snackbarErrorCounter += 1),
            ));
            isValid = false;
            break;
          }

          if ((myMap['other_field'] == null ||
                  myMap['other_field'].toString().isEmpty) &&
              (myMap['answers'] as List).contains('Others')) {
            emit(state.maybeMap(
              orElse: () => state,
              loaded: (value) => PatientSectionDetailsState.loaded(
                  value.questions,
                  false,
                  false,
                  'You must add "Others" field in \n{${question.question}}',
                  snackbarErrorCounter += 1),
            ));

            isValid = false;
            break;
          }
        }
        if (question.type == AppStrings.questionTypeString) {
          if (question.question == 'National ID') {
            if (formData.containsKey(question.id.toString())) {
              String nationalID = formData[question.id.toString()];
              if (nationalID.length != 14) {
                emit(state.maybeMap(
                  orElse: () => state,
                  loaded: (value) => PatientSectionDetailsState.loaded(
                      value.questions,
                      false,
                      false,
                      'National ID should have 14 digits',
                      snackbarErrorCounter += 1),
                ));

                isValid = false;
                break;
              }
              if (int.tryParse(nationalID) == null) {
                emit(state.maybeMap(
                  orElse: () => state,
                  loaded: (value) => PatientSectionDetailsState.loaded(
                      value.questions,
                      false,
                      false,
                      'National ID should have 14 digits',
                      snackbarErrorCounter += 1),
                ));

                isValid = false;
                break;
              }
            }
          }

          if (question.question == 'Age') {
            if (formData.containsKey(question.id.toString())) {
              String age = formData[question.id.toString()];

              if (int.tryParse(age) == null || int.parse(age) > 99) {
                emit(state.maybeMap(
                  orElse: () => state,
                  loaded: (value) => PatientSectionDetailsState.loaded(
                      value.questions,
                      false,
                      false,
                      'Age should be less than 99',
                      snackbarErrorCounter += 1),
                ));

                isValid = false;
                break;
              }
            }
          }

          if (formData.containsKey(question.id.toString())) {
            String stringAnswer = formData[question.id.toString()];
            if (stringAnswer.isEmpty || stringAnswer == '') {
              debugPrint('moatz123 $question');
              log('Answer is empty or null for question: ${question.question}');
              emit(state.maybeMap(
                orElse: () => state,
                loaded: (value) => PatientSectionDetailsState.loaded(
                    value.questions,
                    false,
                    false,
                    'This question is required \n{${question.question}}',
                    snackbarErrorCounter += 1),
              ));

              isValid = false;
              break;
            }
          }

          if (question.question == 'Phone') {
            String phoneNumber = question.answer;

            if (phoneNumber.length != 11) {
              emit(state.maybeMap(
                orElse: () => state,
                loaded: (value) => PatientSectionDetailsState.loaded(
                    value.questions,
                    false,
                    false,
                    'Phone should have 11 digits',
                    snackbarErrorCounter += 1),
              ));
              isValid = false;
              break;
            }
            if (int.tryParse(phoneNumber) == null) {
              emit(state.maybeMap(
                orElse: () => state,
                loaded: (value) => PatientSectionDetailsState.loaded(
                    value.questions,
                    false,
                    false,
                    'Phone should have 11 digits',
                    snackbarErrorCounter += 1),
              ));
              isValid = false;
              break;
            }
          }
        }
      }
    }

    if (isValid == true) {
      emit(state.maybeMap(
        orElse: () => state,
        loaded: (value) => PatientSectionDetailsState.loaded(
            value.questions, true, false, '', snackbarErrorCounter += 1),
      ));

      final result = await _updatePatientSectionDetailsUsecase.excute(
          UpdatePatientSectionDetailsUsecaseInput(
              patientId: patientId, sectionId: sectionId, map: formData));

      result.fold(
        (l) {
          emit(state.maybeMap(
            orElse: () => state,
            loaded: (value) => PatientSectionDetailsState.loaded(
                value.questions,
                false,
                false,
                l.message,
                snackbarErrorCounter += 1),
          ));
        },
        (response) async {
          emit(state.maybeMap(
            orElse: () => state,
            loaded: (value) => PatientSectionDetailsState.loaded(
                value.questions,
                false,
                true,
                response.message.toString(),
                snackbarErrorCounter += 1),
          ));
        },
      );
    } else {}
  }
}
