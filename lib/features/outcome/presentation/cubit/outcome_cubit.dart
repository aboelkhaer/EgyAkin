import '../../../../exports.dart';
import '../../../../app/shared/functions/select_question_has_displayable_answer.dart';

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
  String? outcomeAiMode;
  String? outcomeAiHint;

  /// Max voice recording length from API (`ai_voice_time`), in seconds.
  int? outcomeAiVoiceTime;

  /// Question ids whose value was applied from AI voice fill.
  final Set<String> aiFilledQuestionIds = {};

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

  String getCurrentWholeValue(int index) {
    final current = questionModelList[index].answer ?? 0.0;
    if (current is double) return current.toString().split('.')[0];
    if (current is String) {
      return double.tryParse(current)?.toString().split('.')[0] ?? '0';
    }
    return '0';
  }

  String getCurrentDecimalValue(int index) {
    final current = questionModelList[index].answer ?? 0.0;
    if (current is double) {
      final parts = current.toString().split('.');
      return parts.length > 1
          ? parts[1].padRight(2, '0').substring(0, 2)
          : '00';
    }
    if (current is String) {
      final parsed = double.tryParse(current);
      if (parsed != null) {
        final parts = parsed.toString().split('.');
        return parts.length > 1
            ? parts[1].padRight(2, '0').substring(0, 2)
            : '00';
      }
    }
    return '00';
  }

  getOutcome(String patientId) async {
    emit(const OutcomeState.loading());
    await Future.delayed(const Duration(
        milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
    final result = await _getOutcomeUsecase
        .execute(GetOutcomeUsecaseInput(sectionId: '8', patientId: patientId));
    result.fold(
      (l) {
        outcomeAiMode = null;
        outcomeAiHint = null;
        outcomeAiVoiceTime = null;
        emit(OutcomeState.error(l.message));
      },
      (data) async {
        questionModelList = data.data!;
        submitterModel = data.submitter!;
        outcomeAiMode = data.aiMode?.trim().toLowerCase();
        outcomeAiHint = data.aiHint;
        outcomeAiVoiceTime = data.aiVoiceTime;
        aiFilledQuestionIds.clear();

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

  dynamic _normalizeVoiceAnswer(QuestionModel question, dynamic value) {
    if (question.type == AppStrings.multipleType) {
      if (value is Map<String, dynamic>) return value;
      if (value is List) {
        return {
          AppStrings.answers: value,
          AppStrings.otherField: AppStrings.empty,
        };
      }
      if (value is String && value.trim().isNotEmpty) {
        return {
          AppStrings.answers: value.split(',').map((e) => e.trim()).toList(),
          AppStrings.otherField: AppStrings.empty,
        };
      }
    }

    if (question.type == AppStrings.selectType ||
        question.type == AppStrings.questionTypeSelect) {
      if (value is Map<String, dynamic>) return value;
      return {
        AppStrings.answers: value,
        AppStrings.otherField: AppStrings.empty,
      };
    }

    return value;
  }

  bool _hasDisplayableAiAnswer(QuestionModel question, dynamic value) {
    if (value == null) return false;

    if (question.type == AppStrings.questionTypeSelect ||
        question.type == AppStrings.selectType) {
      return selectQuestionHasDisplayableAnswer(
        optionValues: question.values,
        storedAnswer: value,
      );
    }

    if (question.type == AppStrings.questionTypeMultiple ||
        question.type == AppStrings.multipleType) {
      if (value is Map) {
        final answers = value[AppStrings.answers];
        if (answers is List) return answers.isNotEmpty;
        if (answers is String) return answers.trim().isNotEmpty;
        return answers != null;
      }
      if (value is List) return value.isNotEmpty;
      if (value is String) return value.trim().isNotEmpty;
      return false;
    }

    if (value is String) return value.trim().isNotEmpty;
    if (value is Map) return value.isNotEmpty;
    if (value is List) return value.isNotEmpty;
    return true;
  }

  void applyVoiceAnswers(Map<String, dynamic> answersMap) {
    if (questionModelList.isEmpty) return;

    final updatedQuestionModelList = List<QuestionModel>.from(questionModelList);
    for (var i = 0; i < updatedQuestionModelList.length; i++) {
      final question = updatedQuestionModelList[i];
      final idKey = question.id?.toString();
      final textKey = (question.question ?? '').trim().toLowerCase();

      dynamic value;
      if (idKey != null && idKey.isNotEmpty) {
        value = answersMap[idKey];
      }
      value ??= answersMap[textKey];
      if (value == null) continue;

      final normalizedValue = _normalizeVoiceAnswer(question, value);
      updatedQuestionModelList[i] = question.copyWith(answer: normalizedValue);
      if (idKey != null && idKey.isNotEmpty) {
        formData[idKey] = normalizedValue;
        if (_hasDisplayableAiAnswer(question, normalizedValue)) {
          aiFilledQuestionIds.add(idKey);
        } else {
          aiFilledQuestionIds.remove(idKey);
        }
      }
    }

    questionModelList = updatedQuestionModelList;
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) => OutcomeState.loaded(
        questionModelList,
        value.isSubmitedOutcome,
        value.message,
        value.snackbarErrorCounter + 1,
        value.isSubmitedOutcomeLoading,
        submitterModel,
      ),
    ));
  }

  void clearAiFilledMark(String questionId) {
    if (!aiFilledQuestionIds.remove(questionId)) return;
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) => OutcomeState.loaded(
        value.questionList,
        value.isSubmitedOutcome,
        value.message,
        value.snackbarErrorCounter + 1,
        value.isSubmitedOutcomeLoading,
        submitterModel,
      ),
    ));
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
                  '${LocalizationService.instance.translate(AppStrings.youMustSelectAtLeastOneChoice)} \n{${question.question}}',
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
                LocalizationService.instance.translate(AppStrings.somethingWentWrong),
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
                '${LocalizationService.instance.translate(AppStrings.youMustAddOthersFieldIn)} \n{${question.question}}',
                snackbarErrorCounter += 1,
                false,
                submitterModel,
              ),
            ));

            isValid = false;
            break;
          }
        }

        if (question.type == AppStrings.selectType) {
          if (question.answer['answers'] == null ||
              question.answer['answers'] == '') {
            emit(state.maybeMap(
              orElse: () => state,
              loaded: (value) => OutcomeState.loaded(
                value.questionList,
                false,
                '${LocalizationService.instance.translate(AppStrings.thisQuestionIsRequired)} \n{${question.question}}',
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
                  '${LocalizationService.instance.translate(AppStrings.nationalIDShouldHave14Digits)}',
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
                  '${LocalizationService.instance.translate(AppStrings.nationalIDShouldHave14Digits)}',
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
                  '${LocalizationService.instance.translate(AppStrings.ageShouldBeLessThan120)}',
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
                  '${LocalizationService.instance.translate(AppStrings.phoneShouldHave11Digits)}',
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
                  '${LocalizationService.instance.translate(AppStrings.phoneShouldHave11Digits)}',
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
              '${LocalizationService.instance.translate(AppStrings.thisQuestionIsRequired)} \n{${question.question}}',
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
