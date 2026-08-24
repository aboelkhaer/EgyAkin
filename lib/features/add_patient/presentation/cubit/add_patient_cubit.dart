import '../../../../app/shared/functions/select_question_has_displayable_answer.dart';
import '../../../../app/shared/functions/multiple_question_has_displayable_answer.dart';
import '../../../../exports.dart';

class AddPatientCubit extends Cubit<AddPatientState> {
  AddPatientCubit(
    this._getPatientHistoryForAddPatientUsecase,
    this._addPatientForFirstTimetUsecase,
  ) : super(const AddPatientState.initial());
  static AddPatientCubit get(context) => BlocProvider.of(context);
  final GetPatientHistoryForAddPatientUsecase
      _getPatientHistoryForAddPatientUsecase;
  final AddPatientForFirstTimetUsecase _addPatientForFirstTimetUsecase;
  int snackbarErrorCounter = 0;
  GlobalKey<FormState> addPatientKeyForm = GlobalKey<FormState>();
  List<QuestionModel>? questionModelList = [];
  Map<String, dynamic> formData = {};
  /// HTML guidance from API (`ai_hint`) for voice recording on add patient.
  String? addPatientAiHint;

  /// Max voice recording length from API (`ai_voice_time`), in seconds.
  int? addPatientAiVoiceTime;

  /// Question id to scroll to after validation failure (UI reads this).
  String? firstInvalidQuestionId;

  /// Index in [questionModelList] for the first invalid question.
  int? firstInvalidQuestionIndex;

  /// Question ids whose current value was last applied from voice/AI (cleared on manual edit).
  final Set<String> aiFilledQuestionIds = {};

  void _emitFieldError(String questionId, String message) {
    firstInvalidQuestionId = questionId;
    firstInvalidQuestionIndex = questionModelList?.indexWhere(
      (q) => q.id.toString() == questionId,
    );
    if (firstInvalidQuestionIndex != null && firstInvalidQuestionIndex! < 0) {
      firstInvalidQuestionIndex = null;
    }
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) => AddPatientState.loaded(
        value.questions,
        false,
        0,
        false,
        message,
        snackbarErrorCounter += 1,
      ),
    ));
  }

  /// Clears the red highlight after the user edits the invalid field.
  void clearInvalidHighlight([String? questionId]) {
    if (firstInvalidQuestionId == null) return;
    if (questionId != null && firstInvalidQuestionId != questionId) return;
    firstInvalidQuestionId = null;
    firstInvalidQuestionIndex = null;
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) => AddPatientState.loaded(
        value.questions,
        value.isAddedPatientSuccessfully,
        value.patientId,
        value.isAddPatientLoading,
        // Clear message so state != previous (Bloc skips equal emits).
        '',
        value.snackbarErrorCounter,
      ),
    ));
  }

  /// Clears the dialog message only — keeps highlight + scroll target.
  void acknowledgeFieldErrorDialog() {
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) {
        if (value.message.isEmpty) return state;
        return AddPatientState.loaded(
          value.questions,
          value.isAddedPatientSuccessfully,
          value.patientId,
          value.isAddPatientLoading,
          '',
          value.snackbarErrorCounter,
        );
      },
    ));
  }

  getPatientHistoryForAddPatient() async {
    addPatientAiHint = null;
    addPatientAiVoiceTime = null;
    emit(const AddPatientState.loading());
    await Future.delayed(const Duration(
        milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
    final result = await _getPatientHistoryForAddPatientUsecase.execute('1');
    result.fold(
      (l) {
        addPatientAiHint = null;
        addPatientAiVoiceTime = null;
        emit(AddPatientState.error(l.message));
      },
      (response) async {
        questionModelList = response.data;
        addPatientAiHint = response.aiHint;
        addPatientAiVoiceTime = response.aiVoiceTime;
        aiFilledQuestionIds.clear();
        emit(AddPatientState.loaded(
            response.data ?? [], false, 0, false, '', snackbarErrorCounter));
      },
    );
  }

  addPatientForFirstTime() async {
    bool isValid = true;
    firstInvalidQuestionId = null;
    firstInvalidQuestionIndex = null;
    addPatientKeyForm.currentState?.validate();
    // Prevent Form focus restoration from jumping to Age / other text fields.
    FocusManager.instance.primaryFocus?.unfocus();

    for (var question in questionModelList!) {
      final questionId = question.id.toString();
      if (question.mandatory == true) {
        if (question.type == 'select') {
          Map myMap = formData[questionId] ??= {
            'answers': '',
            'other_field': '',
          };

          // Never keep null in other_field — breaks text fields / casts.
          myMap['other_field'] ??= '';

          if (myMap.containsKey('answers')) {
            dynamic answersValue = myMap['answers'];
            if (answersValue == null ||
                answersValue.toString().trim().isEmpty) {
              debugPrint('"answers" key is either null or an empty list.');
              _emitFieldError(
                questionId,
                '${LocalizationService.instance.translate(AppStrings.youMustSelectAtLeastOneChoice)} \n{${question.question}}',
              );
              isValid = false;
              break;
            }
          }
        }

        if (question.type == 'multiple') {
          Map myMap = formData[questionId] ??= {
            'answers': [],
            'other_field': '',
          };
          myMap['other_field'] ??= '';

          if (myMap.containsKey('answers')) {
            dynamic answersValue = myMap['answers'];

            if (answersValue == null ||
                (answersValue is List && answersValue.isEmpty)) {
              debugPrint('"answers" key is either null or an empty list.');
              _emitFieldError(
                questionId,
                '${LocalizationService.instance.translate(AppStrings.youMustSelectAtLeastOneChoice)} \n{${question.question}}',
              );
              isValid = false;
              break;
            } else {
              debugPrint(
                  '"answers" key is present and has a non-empty list value: $answersValue');
            }
          } else {
            debugPrint('"answers" key is not present in the map.');
            _emitFieldError(
              questionId,
              LocalizationService.instance
                  .translate(AppStrings.somethingWentWrong),
            );
            isValid = false;
            break;
          }

          if ((myMap['other_field'] == null ||
                  myMap['other_field'].toString().isEmpty) &&
              (myMap['answers'] as List).contains('Others')) {
            _emitFieldError(
              questionId,
              '${LocalizationService.instance.translate(AppStrings.youMustAddOthersFieldIn)} \n{${question.question}}',
            );
            isValid = false;
            break;
          }
        }
        if (question.question == 'Name') {
          if (formData.containsKey(questionId)) {
            final rawName = formData[questionId];
            if (rawName is! String) {
              _emitFieldError(
                questionId,
                '${LocalizationService.instance.translate(AppStrings.thisQuestionIsRequired)} \n{${question.question}}',
              );
              isValid = false;
              break;
            }
            final name = rawName;

            RegExp englishCharRegex = RegExp(r'^[a-zA-Z\s]+$');

            if (!englishCharRegex.hasMatch(name)) {
              _emitFieldError(
                questionId,
                LocalizationService.instance.translate(
                    AppStrings.nameShouldContainOnlyEnglishLetters),
              );
              isValid = false;
              break;
            }
          }
        }
        if (question.question == 'National ID') {
          if (formData.containsKey(questionId)) {
            final rawId = formData[questionId];
            if (rawId is! String) {
              _emitFieldError(
                questionId,
                LocalizationService.instance
                    .translate(AppStrings.nationalIDShouldHave14Digits),
              );
              isValid = false;
              break;
            }
            final nationalID = rawId;
            if (nationalID.length != 14) {
              _emitFieldError(
                questionId,
                LocalizationService.instance
                    .translate(AppStrings.nationalIDShouldHave14Digits),
              );
              isValid = false;
              break;
            }
            if (int.tryParse(nationalID) == null) {
              _emitFieldError(
                questionId,
                LocalizationService.instance
                    .translate(AppStrings.nationalIDShouldHave14Digits),
              );
              isValid = false;
              break;
            }
          }
        }

        if (question.question == 'Phone') {
          if (formData.containsKey(questionId)) {
            final rawPhone = formData[questionId];
            if (rawPhone is! String) {
              _emitFieldError(
                questionId,
                LocalizationService.instance
                    .translate(AppStrings.phoneShouldHave11Digits),
              );
              isValid = false;
              break;
            }
            final phoneNumber = rawPhone;
            if (phoneNumber.length != 11) {
              _emitFieldError(
                questionId,
                LocalizationService.instance
                    .translate(AppStrings.phoneShouldHave11Digits),
              );
              isValid = false;
              break;
            }
            if (int.tryParse(phoneNumber) == null) {
              _emitFieldError(
                questionId,
                LocalizationService.instance
                    .translate(AppStrings.phoneShouldHave11Digits),
              );
              isValid = false;
              break;
            }
          }
        }

        if (question.question == 'Age') {
          final rawAge = formData[questionId];
          final ageStr = rawAge is String ? rawAge.trim() : '';
          // Only validate range when the user entered something.
          // Empty age is handled by the required check below.
          if (ageStr.isNotEmpty) {
            final parsed = int.tryParse(ageStr);
            if (parsed == null || parsed > 119 || parsed <= 0) {
              _emitFieldError(
                questionId,
                LocalizationService.instance
                    .translate(AppStrings.ageShouldBeLessThan120),
              );
              isValid = false;
              break;
            }
          }
        }

        // Select/multiple store Maps — skip empty-string check for those.
        if (question.type != 'select' && question.type != 'multiple') {
          final value = formData[questionId];
          if (value == null ||
              value == '' ||
              (value is String && value.trim().isEmpty)) {
            _emitFieldError(
              questionId,
              '${LocalizationService.instance.translate(AppStrings.thisQuestionIsRequired)} \n{${question.question}}',
            );
            isValid = false;
            break;
          }
        }
      }
    }

    if (isValid == true) {
      firstInvalidQuestionId = null;
      firstInvalidQuestionIndex = null;
      emit(state.maybeMap(
        orElse: () => state,
        loaded: (value) => AddPatientState.loaded(
            value.questions, false, 0, true, '', snackbarErrorCounter),
      ));

      await Future.delayed(const Duration(
          milliseconds: AppStrings.delayForAPIRequestInMilliseconds));
      final result = await _addPatientForFirstTimetUsecase.execute(formData);
      result.fold(
        (l) {
          emit(state.maybeMap(
            orElse: () => state,
            loaded: (value) => AddPatientState.loaded(value.questions, false, 0,
                false, l.message, snackbarErrorCounter),
          ));
        },
        (response) async {
          emit(state.maybeMap(
            orElse: () => state,
            loaded: (value) => AddPatientState.loaded(value.questions, true,
                response.id!, false, '', snackbarErrorCounter),
          ));
        },
      );
    }
  }

  dynamic _normalizeVoiceAnswer(QuestionModel question, dynamic value) {
    if (question.type == AppStrings.multipleType) {
      final options = question.values ?? const <dynamic>[];
      final rawAnswers = <dynamic>[];
      var otherField = AppStrings.empty;

      if (value is Map) {
        final answersRaw = value[AppStrings.answers];
        if (answersRaw is List) {
          rawAnswers.addAll(answersRaw);
        } else if (answersRaw is String && answersRaw.trim().isNotEmpty) {
          rawAnswers.addAll(
            answersRaw.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty),
          );
        }
        final otherRaw = value[AppStrings.otherField];
        if (otherRaw != null && otherRaw.toString().trim().isNotEmpty) {
          otherField = otherRaw.toString().trim();
        }
      } else if (value is List) {
        rawAnswers.addAll(value);
      } else if (value is String && value.trim().isNotEmpty) {
        rawAnswers.addAll(
          value.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty),
        );
      }

      final matched = <dynamic>[];
      for (final raw in rawAnswers) {
        final mapped = matchMultipleOptionValue(raw, options);
        if (mapped != null && !matched.contains(mapped)) {
          matched.add(mapped);
        }
      }

      // Keep "Others" + free text when AI only provided other_field.
      if (otherField != AppStrings.empty &&
          otherField.trim().isNotEmpty &&
          !matched.any((e) => e.toString() == AppStrings.others)) {
        final othersOpt = matchMultipleOptionValue(AppStrings.others, options);
        if (othersOpt != null) matched.add(othersOpt);
      }

      return {
        AppStrings.answers: matched,
        AppStrings.otherField: otherField,
      };
    }

    if (question.type == AppStrings.questionTypeSelect) {
      if (value is Map<String, dynamic>) return value;
      if (value is Map) return Map<String, dynamic>.from(value);
      final options = question.values ?? const <dynamic>[];
      final matched = matchMultipleOptionValue(value, options) ?? value;
      return {
        AppStrings.answers: matched,
        AppStrings.otherField: AppStrings.empty,
      };
    }

    return value;
  }

  void applyVoiceAnswers(Map<String, dynamic> answersMap) {
    if (questionModelList == null || questionModelList!.isEmpty) return;

    for (final question in questionModelList!) {
      final idKey = question.id.toString();
      final textKey = (question.question ?? '').trim().toLowerCase();
      dynamic value = answersMap[idKey];
      value ??= answersMap[textKey];
      if (value == null) continue;

      final normalizedValue = _normalizeVoiceAnswer(question, value);
      formData[idKey] = normalizedValue;

      final shouldMarkAi = () {
        if (question.type == AppStrings.questionTypeSelect) {
          return selectQuestionHasDisplayableAnswer(
            optionValues: question.values,
            storedAnswer: normalizedValue,
          );
        }
        if (question.type == AppStrings.multipleType) {
          return multipleQuestionHasDisplayableAnswer(
            optionValues: question.values,
            storedAnswer: normalizedValue,
          );
        }
        if (normalizedValue is String) {
          return normalizedValue.trim().isNotEmpty;
        }
        if (normalizedValue is Map) {
          return normalizedValue.isNotEmpty;
        }
        if (normalizedValue is List) {
          return normalizedValue.isNotEmpty;
        }
        return normalizedValue != null;
      }();

      if (shouldMarkAi) {
        aiFilledQuestionIds.add(idKey);
      } else {
        aiFilledQuestionIds.remove(idKey);
      }
    }

    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) => AddPatientState.loaded(
        value.questions,
        value.isAddedPatientSuccessfully,
        value.patientId,
        value.isAddPatientLoading,
        value.message,
        value.snackbarErrorCounter + 1,
      ),
    ));
  }

  void clearAiFilledMark(String questionId) {
    if (!aiFilledQuestionIds.remove(questionId)) return;
    emit(state.maybeMap(
      orElse: () => state,
      loaded: (value) => AddPatientState.loaded(
        value.questions,
        value.isAddedPatientSuccessfully,
        value.patientId,
        value.isAddPatientLoading,
        value.message,
        value.snackbarErrorCounter + 1,
      ),
    ));
  }
}
