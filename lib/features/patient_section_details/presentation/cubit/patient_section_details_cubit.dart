import 'dart:developer';

import 'package:egy_akin/app/constants/app_strings.dart';
import 'package:egy_akin/features/add_patient/data/models/get_patient_history_for_add_patient.dart';
import 'package:egy_akin/features/patient_section_details/domain/usecases/get_patient_section_usecase.dart';
import 'package:egy_akin/features/patient_section_details/domain/usecases/update_patient_section_details_usecase.dart';
import 'package:egy_akin/features/patient_section_details/presentation/cubit/patient_section_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  void updateQuestionAnswer(String questionId, dynamic newAnswer) {
    // Create a new list from the existing list
    final updatedQuestionModelList =
        List<QuestionModel>.from(questionModelList);

    final questionIndex = updatedQuestionModelList
        .indexWhere((question) => question.id.toString() == questionId);
    if (questionIndex != -1) {
      updatedQuestionModelList[questionIndex] =
          updatedQuestionModelList[questionIndex].copyWith(answer: newAnswer);
      questionModelList =
          updatedQuestionModelList; // Replace the old list with the new list
      emit(PatientSectionDetailsState.loaded(
          updatedQuestionModelList, false, false, '', snackbarErrorCounter));
    }
  }

  getPatientSectionDetails(String sectionId, String patientId) async {
    emit(const PatientSectionDetailsState.loading());
    final result = await _getPatientSectionDetailsUsecase.execute(
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

  updateScreen() {
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) => PatientSectionDetailsState.loaded(
          value.questions, false, false, '', snackbarErrorCounter += 1),
    ));
  }

  updatePatientSectionDetails(String sectionId, String patientId) async {
    bool isValid = true;
    log(questionModelList.toString());

    for (var question in questionModelList) {
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
        if (question.question == 'Name') {
          if (formData.containsKey(question.id.toString())) {
            String name = formData[question.id.toString()];

            // Regular expression for checking only English alphabetic characters
            RegExp englishCharRegex = RegExp(r'^[a-zA-Z]+$');

            if (!englishCharRegex.hasMatch(name)) {
              emit(state.maybeMap(
                orElse: () => state,
                loaded: (value) => PatientSectionDetailsState.loaded(
                    value.questions,
                    false,
                    false,
                    'Name should contain only English letters',
                    snackbarErrorCounter += 1),
              ));

              isValid = false;
              break;
            }
          }
        }
        if (question.type == AppStrings.questionTypeString) {
          if (question.question == 'National ID') {
            String nationalID = question.answer;
            log('moatz123 $nationalID');
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

          if (question.question == 'Age') {
            String age = question.answer;

            if (int.tryParse(age) == null ||
                (int.parse(age) > 119 || int.parse(age) <= 0)) {
              emit(state.maybeMap(
                orElse: () => state,
                loaded: (value) => PatientSectionDetailsState.loaded(
                    value.questions,
                    false,
                    false,
                    'Age should be less than 120',
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
        if (question.answer == null || question.answer == '') {
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
    }

    if (isValid == true) {
      emit(state.maybeMap(
        orElse: () => state,
        loaded: (value) => PatientSectionDetailsState.loaded(
            value.questions, true, false, '', snackbarErrorCounter += 1),
      ));

      final result = await _updatePatientSectionDetailsUsecase.execute(
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
