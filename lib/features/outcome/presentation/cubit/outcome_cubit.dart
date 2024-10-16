import '../../../../exports.dart';

class OutcomeCubit extends Cubit<OutcomeState> {
  OutcomeCubit(this._getOutcomeUsecase, this._submitOutcomeUsecase)
      : super(const OutcomeState.initial());
  final GetOutcomeUsecase _getOutcomeUsecase;
  final SubmitOutcomeUsecase _submitOutcomeUsecase;
  static OutcomeCubit get(context) => BlocProvider.of(context);
  GlobalKey<FormState> outcomeFormKey = GlobalKey<FormState>();
  Map<String, dynamic> formData = {};
  int snackbarErrorCounter = 0;
  List<QuestionModel> questionModelList = [];
  OutcomeSubmitterModel submitterModel = const OutcomeSubmitterModel();

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
      emit(OutcomeState.loaded(
        questionModelList,
        false,
        '',
        snackbarErrorCounter,
        false,
        submitterModel,
      ));
    }
  }

  getOutcome(String patientId) async {
    emit(const OutcomeState.loading());
    await Future.delayed(const Duration(
        milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
    final result = await _getOutcomeUsecase
        .execute(GetOutcomeUsecaseInput(sectionId: '8', patientId: patientId));
    result.fold(
      (l) {
        emit(OutcomeState.error(l.message));
      },
      (data) async {
        questionModelList = data.data!;
        submitterModel = data.submitter!;

        emit(OutcomeState.loaded(
          questionModelList,
          false,
          '',
          snackbarErrorCounter,
          false,
          submitterModel,
        ));
      },
    );
  }

  // submitOutcome(String patientId) async {
  //   emit(const OutcomeState.loading());
  //   await Future.delayed(const Duration(
  //       milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
  //   final result = await _submitOutcomeUsecase.excute(
  //     SubmitUseCaseInput(
  //       patientId: patientId,
  //       sectionId: '8',
  //       map: formData,
  //     ),
  //   );
  //   result.fold(
  //     (l) {
  //       emit(OutcomeState.error(l.message));
  //     },
  //     (response) async {
  //       emit(OutcomeState.loaded(
  //           [], true, response.message!, snackbarErrorCounter, false));
  //     },
  //   );
  // }

  submitOutcome(String patientId) async {
    bool isValid = true;

    for (var question in questionModelList) {
      // if (question.question == 'Hospital') {
      //   log(question.toString());
      // }
      if (question.mandatory == true) {
        if (question.type == 'multiple') {
          Map myMap = formData[question.id.toString()] ??= {
            "answers": [],
            "other_field": ''
          };

          // Check if "answers" key is either null or an empty list
          if (myMap.containsKey('answers')) {
            dynamic answersValue = myMap['answers'];

            if (answersValue == null ||
                (answersValue is List && answersValue.isEmpty)) {
              debugPrint('"answers" key is either null or an empty list.');

              emit(state.maybeMap(
                orElse: () => state,
                loaded: (value) => OutcomeState.loaded(
                  value.questionList,
                  false,
                  'You must select at least one choice. \n{${question.question}}',
                  snackbarErrorCounter += 1,
                  false,
                  submitterModel,
                ),
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
              loaded: (value) => OutcomeState.loaded(
                value.questionList,
                false,
                AppStrings.somethingWentWrong,
                snackbarErrorCounter += 1,
                false,
                submitterModel,
              ),
            ));
            isValid = false;
            break;
          }

          if ((myMap['other_field'] == null ||
                  myMap['other_field'].toString().isEmpty) &&
              (myMap['answers'] as List).contains('Others')) {
            emit(state.maybeMap(
              orElse: () => state,
              loaded: (value) => OutcomeState.loaded(
                value.questionList,
                false,
                'You must add "Others" field in \n{${question.question}}',
                snackbarErrorCounter += 1,
                false,
                submitterModel,
              ),
            ));

            isValid = false;
            break;
          }
        }
        if (question.type == AppStrings.questionTypeString) {
          if (question.question == 'National ID') {
            String nationalID = question.answer;
            if (nationalID.length != 14) {
              emit(state.maybeMap(
                orElse: () => state,
                loaded: (value) => OutcomeState.loaded(
                  value.questionList,
                  false,
                  'National ID should have 14 digits',
                  snackbarErrorCounter += 1,
                  false,
                  submitterModel,
                ),
              ));

              isValid = false;
              break;
            }
            if (int.tryParse(nationalID) == null) {
              emit(state.maybeMap(
                orElse: () => state,
                loaded: (value) => OutcomeState.loaded(
                  value.questionList,
                  false,
                  'National ID should have 14 digits',
                  snackbarErrorCounter += 1,
                  false,
                  submitterModel,
                ),
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
                loaded: (value) => OutcomeState.loaded(
                  value.questionList,
                  false,
                  'Age should be less than 120',
                  snackbarErrorCounter += 1,
                  false,
                  submitterModel,
                ),
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
                loaded: (value) => OutcomeState.loaded(
                  value.questionList,
                  false,
                  'Phone should have 11 digits',
                  snackbarErrorCounter += 1,
                  false,
                  submitterModel,
                ),
              ));
              isValid = false;
              break;
            }

            if (int.tryParse(phoneNumber) == null) {
              emit(state.maybeMap(
                orElse: () => state,
                loaded: (value) => OutcomeState.loaded(
                  value.questionList,
                  false,
                  'Phone should have 11 digits',
                  snackbarErrorCounter += 1,
                  false,
                  submitterModel,
                ),
              ));
              isValid = false;
              break;
            }
          }
        }
        if (question.answer == null || question.answer == '') {
          emit(state.maybeMap(
            orElse: () => state,
            loaded: (value) => OutcomeState.loaded(
              value.questionList,
              false,
              'This question is required \n{${question.question}}',
              snackbarErrorCounter += 1,
              false,
              submitterModel,
            ),
          ));

          isValid = false;
          break;
        }
      }
    }

    if (isValid == true) {
      emit(state.maybeMap(
        orElse: () => state,
        loaded: (value) => OutcomeState.loaded(
          value.questionList,
          false,
          '',
          value.snackbarErrorCounter,
          true,
          submitterModel,
        ),
      ));

      final result = await _submitOutcomeUsecase.execute(
        SubmitUseCaseInput(
          patientId: patientId,
          sectionId: '8',
          map: formData,
        ),
      );
      result.fold(
        (l) {
          emit(state.maybeMap(
            orElse: () => state,
            loaded: (value) => OutcomeState.loaded(
              value.questionList,
              false,
              l.message,
              value.snackbarErrorCounter,
              false,
              submitterModel,
            ),
          ));
        },
        (response) async {
          // emit(OutcomeState.loaded(
          //     [], true, response.message!, snackbarErrorCounter, false));
          emit(state.maybeMap(
            orElse: () => state,
            loaded: (value) => OutcomeState.loaded(
              value.questionList,
              true,
              response.message.toString(),
              value.snackbarErrorCounter,
              false,
              submitterModel,
            ),
          ));
        },
      );
    } else {}
  }
}
