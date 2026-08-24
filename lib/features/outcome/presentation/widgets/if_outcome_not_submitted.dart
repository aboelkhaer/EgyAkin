import 'dart:developer';

import 'package:egy_akin/app/shared/functions/initial_value_in_question.dart';
import 'package:egy_akin/app/shared/functions/initial_value_in_select_question.dart';
import 'package:egy_akin/app/shared/functions/is_date.dart';
import 'package:egy_akin/app/shared/functions/multiple_question_has_displayable_answer.dart';
import 'package:egy_akin/app/shared/functions/select_question_has_displayable_answer.dart';
import 'package:egy_akin/features/home/presentation/widgets/dashboard/home_dashboard_shared.dart';
import 'package:egy_akin/features/outcome/presentation/widgets/submit_button.dart';
import 'package:egy_akin/features/patient_section_details/presentation/utils/patient_section_multiple_answer_utils.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

import '../../../../exports.dart';

class IfOutcomeNotSubmitted extends StatefulWidget {
  const IfOutcomeNotSubmitted({
    super.key,
    required this.cubit,
    required this.outcomeStatus,
    required this.accountVerification,
    required this.patientId,
    required this.isSyndicateCardRequired,
    required this.currentDoctorModel,
    required this.doctorId,
    required this.homeDataModel,
  });

  final OutcomeCubit cubit;
  final bool outcomeStatus;
  final String patientId;
  final bool accountVerification;
  final String isSyndicateCardRequired;
  final DoctorModel currentDoctorModel;
  final String doctorId;
  final HomeModelResponse homeDataModel;

  @override
  State<IfOutcomeNotSubmitted> createState() => _IfOutcomeNotSubmittedState();
}

class _IfOutcomeNotSubmittedState extends State<IfOutcomeNotSubmitted> {
  Map<String, dynamic> answerMap = {};
  final Map<String, GlobalKey> _questionKeys = {};
  final ValueNotifier<String?> _invalidHighlightId =
      ValueNotifier<String?>(null);
  double? _pinnedInvalidScrollOffset;
  int _lastHandledErrorCounter = -1;

  @override
  void initState() {
    answerMap = {
      AppStrings.answers: [],
      AppStrings.otherField: AppStrings.empty,
    };
    super.initState();
  }

  @override
  void dispose() {
    _invalidHighlightId.dispose();
    super.dispose();
  }

  GlobalKey _keyForQuestion(String questionId) {
    return _questionKeys.putIfAbsent(questionId, GlobalKey.new);
  }

  double? _revealOffsetForQuestion(String questionId) {
    final ctx = _questionKeys[questionId]?.currentContext;
    if (ctx == null || !ctx.mounted) return null;
    final ro = ctx.findRenderObject();
    if (ro == null || !ro.attached) return null;
    final viewport = RenderAbstractViewport.maybeOf(ro);
    if (viewport == null) return null;
    return viewport.getOffsetToReveal(ro, 0.12).offset;
  }

  Future<void> _scrollToInvalidQuestion({
    required ScrollController scrollController,
    required String? questionId,
    required int? questionIndex,
  }) async {
    if (!scrollController.hasClients) return;
    FocusManager.instance.primaryFocus?.unfocus();

    final maxExtent = scrollController.position.maxScrollExtent;

    if (questionIndex != null && questionIndex >= 0) {
      final estimate = (10.h + questionIndex * 140.h).clamp(0.0, maxExtent);
      if ((scrollController.offset - estimate).abs() > 24) {
        scrollController.jumpTo(estimate);
        await WidgetsBinding.instance.endOfFrame;
        if (!mounted) return;
        await Future<void>.delayed(const Duration(milliseconds: 24));
        if (!mounted || !scrollController.hasClients) return;
      }
    }

    double? measured =
        questionId != null ? _revealOffsetForQuestion(questionId) : null;
    final latestMax = scrollController.position.maxScrollExtent;
    final target = (measured ?? scrollController.offset).clamp(0.0, latestMax);
    final distance = (target - scrollController.offset).abs();
    if (distance > 2) {
      await scrollController.animateTo(
        target,
        duration: Duration(milliseconds: distance > 400 ? 420 : 280),
        curve: Curves.easeOutCubic,
      );
    }

    if (!mounted || !scrollController.hasClients) return;
    _pinnedInvalidScrollOffset = scrollController.offset;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !scrollController.hasClients || questionId == null) {
        return;
      }
      final refined = _revealOffsetForQuestion(questionId);
      if (refined == null) return;
      final refinedClamped =
          refined.clamp(0.0, scrollController.position.maxScrollExtent);
      if ((refinedClamped - scrollController.offset).abs() > 4) {
        scrollController.jumpTo(refinedClamped);
      }
      _pinnedInvalidScrollOffset = scrollController.offset;
    });
  }

  void _restorePinnedInvalidScroll(ScrollController scrollController) {
    final pinned = _pinnedInvalidScrollOffset;
    if (pinned == null || !scrollController.hasClients) return;
    final max = scrollController.position.maxScrollExtent;
    final target = pinned.clamp(0.0, max);
    if ((scrollController.offset - target).abs() > 1) {
      scrollController.jumpTo(target);
    }
  }

  Future<void> _handleValidationMessage({
    required OutcomeCubit cubit,
    required String message,
    required int snackbarErrorCounter,
  }) async {
    if (message.isEmpty) return;
    if (snackbarErrorCounter == _lastHandledErrorCounter) return;
    _lastHandledErrorCounter = snackbarErrorCounter;

    final invalidId = cubit.firstInvalidQuestionId;
    final invalidIndex = cubit.firstInvalidQuestionIndex;
    final errorMessage = message;
    _invalidHighlightId.value = invalidId;

    FocusManager.instance.primaryFocus?.unfocus();
    await WidgetsBinding.instance.endOfFrame;
    if (!mounted) return;

    await _scrollToInvalidQuestion(
      scrollController: cubit.outcomeScrollController,
      questionId: invalidId,
      questionIndex: invalidIndex,
    );
    if (!mounted) return;

    await showHintDialog(
      context: context,
      message: errorMessage,
      dialogType: DialogType.error,
    );
    if (!mounted) return;

    cubit.acknowledgeFieldErrorDialog();
    await Future<void>.delayed(const Duration(milliseconds: 50));
    if (!mounted) return;
    FocusManager.instance.primaryFocus?.unfocus();
    _restorePinnedInvalidScroll(cubit.outcomeScrollController);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      FocusManager.instance.primaryFocus?.unfocus();
      _restorePinnedInvalidScroll(cubit.outcomeScrollController);
    });
  }

  void _clearInvalid(OutcomeCubit cubit, String questionId) {
    cubit.clearInvalidHighlight(questionId);
    if (_invalidHighlightId.value == questionId) {
      _invalidHighlightId.value = null;
    }
  }

  bool _shouldShowAiBadge({
    required OutcomeCubit cubit,
    required QuestionModel question,
    required String questionId,
  }) {
    if (!cubit.aiFilledQuestionIds.contains(questionId)) return false;
    if (question.type == AppStrings.questionTypeSelect ||
        question.type == AppStrings.selectType) {
      return selectQuestionHasDisplayableAnswer(
        optionValues: question.values,
        storedAnswer: cubit.formData[questionId] ?? question.answer,
      );
    }
    if (question.type == AppStrings.multipleType ||
        question.type == AppStrings.questionTypeMultiple) {
      return multipleQuestionHasDisplayableAnswer(
        optionValues: question.values,
        storedAnswer: cubit.formData[questionId] ?? question.answer,
      );
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;
        final primary = HomeDashboardColors.primary(isDarkMode);
        final cardBg = HomeDashboardColors.cardBg(isDarkMode);
        final titleColor = HomeDashboardColors.title(isDarkMode);
        final muted = HomeDashboardColors.subtitle(isDarkMode);
        Size size = MediaQuery.of(context).size;
        OutcomeCubit cubit = OutcomeCubit.get(context);

        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          behavior: HitTestBehavior.deferToChild,
          child: Stack(
          children: [
            Form(
              key: cubit.outcomeFormKey,
              child: Column(
                children: [
                  BlocConsumer<OutcomeCubit, OutcomeState>(
                    listenWhen: (previous, current) {
                      return current.maybeWhen(
                        loaded: (_, isSubmitedOutcome, message, ____, _____,
                            ______) {
                          return isSubmitedOutcome || message.isNotEmpty;
                        },
                        orElse: () => false,
                      );
                    },
                    listener: (context, state) {
                      state.maybeWhen(
                        orElse: () {},
                        loaded: (
                          response,
                          isSubmitedOutcome,
                          message,
                          snackbarErrorCounter,
                          isSubmitedOutcomeLoading,
                          submitterModel,
                        ) {
                          if (isSubmitedOutcome) {
                            navigatorKey.currentState?.pushReplacementNamed(
                                AppRoutes.home,
                                arguments: 0);
                            if (message.isNotEmpty) {
                              customSnackBar(
                                  context: context, message: message);
                            }
                            return;
                          }
                          if (isSubmitedOutcomeLoading) return;
                          if (message.isNotEmpty) {
                            _handleValidationMessage(
                              cubit: cubit,
                              message: message,
                              snackbarErrorCounter: snackbarErrorCounter,
                            );
                          }
                        },
                      );
                    },
                    buildWhen: (previous, current) {
                      return previous.maybeWhen(
                        loaded: (questions, _, __, ___, isLoading, ____) {
                          return current.maybeWhen(
                            loaded: (q2, _, __, ___, loading2, ____) =>
                                !identical(questions, q2) ||
                                isLoading != loading2,
                            orElse: () => true,
                          );
                        },
                        orElse: () => true,
                      );
                    },
                    builder: (context, state) {
                      return state.maybeWhen(
                        orElse: () {
                          return const Expanded(
                            child: SingleChildScrollView(
                              child: ShimmerLoadingPatientsCards(
                                ishorizontal: false,
                              ),
                            ),
                          );
                        },
                        loaded: (
                          response,
                          isSubmitedOutcome,
                          message,
                          _,
                          isSubmitedOutcomeLoading,
                          submitterModel,
                        ) {
                          List<QuestionModel> questions = response;
                          if (isSubmitedOutcomeLoading) {
                            return const Expanded(
                              child: SingleChildScrollView(
                                child: ShimmerLoadingPatientsCards(
                                  ishorizontal: false,
                                ),
                              ),
                            );
                          }

                          return Expanded(
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                inputDecorationTheme: InputDecorationTheme(
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 8.w,
                                    vertical: 10.h,
                                  ),
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  hintStyle: TextStyle(
                                    fontSize: 11.sp,
                                    color: muted,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  labelStyle: TextStyle(
                                    fontSize: 11.sp,
                                    color: muted,
                                  ),
                                ),
                                textTheme: Theme.of(context).textTheme.apply(
                                      fontSizeFactor: 0.92,
                                    ),
                              ),
                              child: ListView.separated(
                                itemCount: questions.length,
                                controller: cubit.outcomeScrollController,
                                physics: const BouncingScrollPhysics(),
                                keyboardDismissBehavior:
                                    ScrollViewKeyboardDismissBehavior.onDrag,
                                cacheExtent: 10000,
                                padding: EdgeInsets.fromLTRB(
                                  14.w,
                                  10.h,
                                  14.w,
                                  110.h,
                                ),
                                separatorBuilder: (_, __) =>
                                    SizedBox(height: 8.h),
                                itemBuilder: (context, index) {
                                  final question = questions[index];
                                  final questionId = question.id.toString();
                                  final isRequired =
                                      question.mandatory == true;
                                  const errorRed = Color(0xFFEF4444);
                                  final showAi = _shouldShowAiBadge(
                                    cubit: cubit,
                                    question: question,
                                    questionId: questionId,
                                  );

                                  return ValueListenableBuilder<String?>(
                                    valueListenable: _invalidHighlightId,
                                    builder: (context, invalidId, _) {
                                      final isInvalidHighlight =
                                          invalidId == questionId;
                                      return KeyedSubtree(
                                        key: _keyForQuestion(questionId),
                                        child: TweenAnimationBuilder<double>(
                                          key: ValueKey(
                                            'q-$questionId-invalid-$isInvalidHighlight',
                                          ),
                                          tween: Tween<double>(
                                            begin: isInvalidHighlight
                                                ? 0.96
                                                : 1.0,
                                            end: 1.0,
                                          ),
                                          duration: Duration(
                                            milliseconds: isInvalidHighlight
                                                ? 560
                                                : 220,
                                          ),
                                          curve: isInvalidHighlight
                                              ? Curves.easeOutBack
                                              : Curves.easeOutCubic,
                                          builder: (context, scale, child) {
                                            return Transform.scale(
                                              scale: scale,
                                              alignment: Alignment.center,
                                              child: child,
                                            );
                                          },
                                          child: AnimatedContainer(
                                            duration: const Duration(
                                                milliseconds: 320),
                                            curve: Curves.easeOutCubic,
                                            padding: EdgeInsets.fromLTRB(
                                              12.w,
                                              10.h,
                                              12.w,
                                              10.h,
                                            ),
                                            decoration: BoxDecoration(
                                              color: isInvalidHighlight
                                                  ? (isDarkMode
                                                      ? errorRed
                                                          .withOpacity(0.14)
                                                      : const Color(
                                                          0xFFFEF2F2))
                                                  : cardBg,
                                              borderRadius:
                                                  BorderRadius.circular(16.r),
                                              border: Border.all(
                                                color: isInvalidHighlight
                                                    ? errorRed.withOpacity(0.55)
                                                    : (isDarkMode
                                                        ? Colors.white
                                                            .withOpacity(0.06)
                                                        : const Color(
                                                            0xFFE8E8EE)),
                                                width: isInvalidHighlight
                                                    ? 1.4
                                                    : 1,
                                              ),
                                              boxShadow: isDarkMode
                                                  ? null
                                                  : [
                                                      BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.03),
                                                        blurRadius: 10,
                                                        offset: const Offset(
                                                            0, 3),
                                                      ),
                                                    ],
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .center,
                                                  children: [
                                                    Expanded(
                                                      child: RichText(
                                                        text: TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text:
                                                                  '${index + 1} · ',
                                                              style:
                                                                  TextStyle(
                                                                fontSize:
                                                                    11.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: isInvalidHighlight
                                                                    ? errorRed
                                                                    : primary,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text: question
                                                                      .question ??
                                                                  '',
                                                              style:
                                                                  TextStyle(
                                                                fontSize:
                                                                    12.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color:
                                                                    titleColor,
                                                                height: 1.25,
                                                              ),
                                                            ),
                                                            if (isRequired)
                                                              TextSpan(
                                                                text: ' *',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      12.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800,
                                                                  color:
                                                                      errorRed,
                                                                ),
                                                              ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    if (showAi) ...[
                                                      SizedBox(width: 8.w),
                                                      const AiFilledFieldBanner(
                                                        compact: true,
                                                      ),
                                                    ],
                                                  ],
                                                ),
                                                SizedBox(height: 10.h),
                                                buildQuestionWidget(
                                                  cubit.questionModelList,
                                                  index,
                                                  size,
                                                  cubit,
                                                  isDarkMode: isDarkMode,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  Container(
                    height: 78,
                    color: isDarkMode
                        ? AppColors.darkScaffoldBG
                        : HomeDashboardColors.scaffold(false),
                  ),
                ],
              ),
            ),
            BlocConsumer<OutcomeCubit, OutcomeState>(
              listener: (context, state) {
                state.maybeWhen(
                  orElse: () {},
                  loaded: (
                    response,
                    isSubmitedOutcome,
                    message,
                    _,
                    isSubmitedOutcomeLoading,
                    submitterModel,
                  ) {},
                  error: (message) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      showCustomDialog(
                        context: context,
                        title: context.tr(AppStrings.attention),
                        description: message,
                        coloredButtonText: context.tr(AppStrings.cancel),
                        isNoColorShow: false,
                        coloredButtonOnTap: () {
                          Navigator.of(context).pop();
                        },
                      );
                    });
                  },
                );
              },
              builder: (context, state) {
                final isLoading = state.maybeWhen(
                  orElse: () => false,
                  loading: () => true,
                  loaded: (
                    _,
                    __,
                    ___,
                    ____,
                    isSubmitedOutcomeLoading,
                    _____,
                  ) =>
                      isSubmitedOutcomeLoading,
                );

                return SubmitButtonForOutcome(
                  cubit: cubit,
                  patientId: widget.patientId,
                  accountVerification: widget.accountVerification,
                  isSyndicateCardRequired: widget.isSyndicateCardRequired,
                  currentDoctorModel: widget.currentDoctorModel,
                  isDark: isDarkMode,
                  isLoading: isLoading,
                );
              },
            ),
          ],
        ),
        );
      },
    );
  }

  void _updateDoubleValue({
    required OutcomeCubit cubit,
    required int index,
    required String whole,
    required String decimal,
  }) {
    final wholeNum = whole.isEmpty ? 0 : int.parse(whole);
    final decimalNum = decimal.padRight(2, '0');
    final doubleValue = wholeNum + (int.parse(decimalNum) / 100);

    cubit.updateQuestionAnswer(
      cubit.questionModelList[index].id.toString(),
      doubleValue,
    );

    final qid = cubit.questionModelList[index].id.toString();
    _clearInvalid(cubit, qid);
    cubit.formData[qid] = doubleValue;
  }

  Widget buildQuestionWidget(
    List<QuestionModel> questionList,
    int index,
    Size size,
    OutcomeCubit cubit, {
    required bool isDarkMode,
  }) {
    switch (cubit.questionModelList[index].type) {
      case AppStrings.questionTypeDouble:
        final currentAnswer = cubit.questionModelList[index].answer;
        final qidDouble = cubit.questionModelList[index].id.toString();

        String? initialWhole;
        String? initialDecimal;

        if (currentAnswer != null) {
          final currentValue = currentAnswer is String
              ? double.tryParse(currentAnswer) ?? 0.0
              : currentAnswer as double;
          final parts = currentValue.toString().split('.');
          initialWhole = parts[0];
          initialDecimal = parts.length > 1
              ? parts[1].padRight(2, '0').substring(0, 2)
              : '00';
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              width: 50,
              child: CustomTextFormField(
                title: '00',
                textInputType: TextInputType.number,
                contentPadding: EdgeInsets.zero,
                maxLength: 2,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                textAlign: TextAlign.center,
                initialValue: initialWhole,
                onChanged: (wholeValue) {
                  cubit.clearAiFilledMark(qidDouble);
                  final decimalValue = cubit.getCurrentDecimalValue(index);
                  _updateDoubleValue(
                    cubit: cubit,
                    index: index,
                    whole: wholeValue,
                    decimal: decimalValue,
                  );
                },
                validator: (val) {
                  if (cubit.questionModelList[index].mandatory == true &&
                      (val == null || val.isEmpty)) {
                    return AppStrings.thisFieldIsRequired;
                  }
                  return null;
                },
              ),
            ),
            Container(
              width: 4,
              height: 4,
              margin: const EdgeInsets.only(bottom: 5, left: 10, right: 10),
              decoration: BoxDecoration(
                color: Colors.grey.shade500,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(
              width: 50,
              child: CustomTextFormField(
                title: '00',
                textInputType: TextInputType.number,
                contentPadding: EdgeInsets.zero,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(2),
                ],
                maxLength: 2,
                textAlign: TextAlign.center,
                initialValue: initialDecimal,
                onChanged: (decimalValue) {
                  cubit.clearAiFilledMark(qidDouble);
                  final wholeValue = cubit.getCurrentWholeValue(index);
                  _updateDoubleValue(
                    cubit: cubit,
                    index: index,
                    whole: wholeValue,
                    decimal: decimalValue,
                  );
                },
                validator: (value) => null,
              ),
            ),
          ],
        );

      case AppStrings.questionTypeString:
        var questionAnswer = cubit.questionModelList[index].answer;
        final qid = cubit.questionModelList[index].id.toString();
        return BuildStringValueQuestions(
          questionList: cubit.questionModelList,
          index: index,
          showAiFilledBanner: false,
          compact: true,
          onClearAiFilledMark: () => cubit.clearAiFilledMark(qid),
          initialValue: initialValueInQuestions(
            answer: questionAnswer,
            currentDoctorId: widget.currentDoctorModel.id.toString(),
            doctorId: widget.doctorId.toString(),
            question: cubit.questionModelList[index].question.toString(),
            questionAnswerInForm:
                cubit.formData[cubit.questionModelList[index].id.toString()],
            currentDoctorRole: widget.homeDataModel.role.toString(),
            isAllDataOpen: false,
          ),
          textInputFormatter: cubit.questionModelList[index].question ==
                  AppStrings.phone
              ? [
                  LengthLimitingTextInputFormatter(11),
                ]
              : cubit.questionModelList[index].question == AppStrings.nationalID
                  ? [
                      LengthLimitingTextInputFormatter(14),
                    ]
                  : [
                      LengthLimitingTextInputFormatter(255),
                    ],
          onChanged: (val) {
            final qid = cubit.questionModelList[index].id.toString();
            _clearInvalid(cubit, qid);
            setState(() {
              if (questionAnswer != val) {
                cubit.updateQuestionAnswer(qid, val);
                cubit.formData[qid] = val;
              } else {
                cubit.updateQuestionAnswer(qid, null);
                cubit.formData.remove(qid);
              }
            });
          },
          validator: (val) {
            if (cubit.questionModelList[index].mandatory == true &&
                (val == null || val.isEmpty)) {
              return AppStrings.thisFieldIsRequired;
            }
            return null;
          },
        );

      case AppStrings.questionTypeSelect:
        var questionAnswer = cubit.questionModelList[index].answer;
        final qidSelect = cubit.questionModelList[index].id.toString();
        Map<String, dynamic> answerMap = Map<String, dynamic>.from(
          cubit.formData[qidSelect] is Map
              ? cubit.formData[qidSelect] as Map
              : (questionAnswer is Map
                  ? Map<String, dynamic>.from(questionAnswer)
                  : {
                      AppStrings.answers: '',
                      AppStrings.otherField: AppStrings.empty,
                    }),
        );
        answerMap[AppStrings.answers] ??= '';
        answerMap[AppStrings.otherField] ??= AppStrings.empty;
        cubit.formData[qidSelect] = answerMap;

        final storedAnswer = answerMap[AppStrings.answers];
        final modelAnswer = questionAnswer is Map
            ? questionAnswer[AppStrings.answers]
            : questionAnswer;

        return BuildSelectValueQuestion(
          questionList: cubit.questionModelList,
          index: index,
          isAddPatient: true,
          formData: cubit.formData,
          overlayLeadingInset: 0,
          embedOthersField: true,
          showFieldBorder: true,
          showAiFilledBanner: false,
          onClearAiFilledMark: () => cubit.clearAiFilledMark(qidSelect),
          selected: initialValueInSelectQuestion(
            questionAnswer: storedAnswer ?? modelAnswer,
            selectedValue: storedAnswer,
            values: cubit.questionModelList[index].values!,
          ),
          validator: (val) {
            final answers = answerMap[AppStrings.answers];
            if (cubit.questionModelList[index].mandatory == true &&
                (answers == null ||
                    answers.toString().trim().isEmpty ||
                    answers == AppStrings.empty)) {
              return AppStrings.thisFieldIsRequired;
            }
            return null;
          },
          onChanged: (val) {
            _clearInvalid(cubit, qidSelect);
            setState(() {
              answerMap[AppStrings.answers] = val ?? '';
              if (val != AppStrings.others && val != 'Others') {
                answerMap[AppStrings.otherField] = AppStrings.empty;
              }
              cubit.updateQuestionAnswer(qidSelect, answerMap);
              cubit.formData[qidSelect] = Map<String, dynamic>.from(answerMap);
            });
            log(cubit.formData.toString());
          },
          onChangedForOtherField: (value) {
            _clearInvalid(cubit, qidSelect);
            setState(() {
              answerMap[AppStrings.otherField] = value ?? AppStrings.empty;
              cubit.updateQuestionAnswer(qidSelect, answerMap);
              cubit.formData[qidSelect] = Map<String, dynamic>.from(answerMap);
            });
            log(cubit.formData.toString());
          },
        );

      case AppStrings.questionTypeMultiple:
        final questionAnswer = cubit.questionModelList[index].answer;
        final qidMulti = cubit.questionModelList[index].id.toString();
        final answerMap = resolveMultipleAnswerMap(
          questionAnswer: questionAnswer,
          formEntry: cubit.formData[qidMulti],
        );
        final hasLegacyStringAnswer = answerMap[AppStrings.answers] is String;
        final String oldAnswer = hasLegacyStringAnswer
            ? (answerMap[AppStrings.answers] as String? ?? AppStrings.empty)
            : AppStrings.empty;
        final List<dynamic> answers = hasLegacyStringAnswer
            ? cubit.questionModelList[index].values!
                .where((value) => oldAnswer.contains(value.toString()))
                .toList()
            : List<dynamic>.from(
                answerMap[AppStrings.answers] as List<dynamic>? ?? <dynamic>[],
              );

        void syncMultipleAnswer() {
          final payload = multipleAnswerPayload(
            answers: answers,
            otherText: answerMap[AppStrings.otherField],
          );
          answerMap[AppStrings.answers] = payload[AppStrings.answers];
          answerMap[AppStrings.otherField] = payload[AppStrings.otherField];
          cubit.updateQuestionAnswer(qidMulti, payload);
          cubit.formData[qidMulti] = payload;
        }

        final primaryLocal =
            isDarkMode ? AppColors.darkPrimary : AppColors.primary;

        return BuildMultipleValueQuestion(
          index: index,
          questionList: cubit.questionModelList,
          initialValue: answerMap[AppStrings.otherField]?.toString() ?? '',
          listContainOther: answers,
          oldAnswer: null,
          isOldAnswer: false,
          showAiFilledBanner: false,
          onClearAiFilledMark: () => cubit.clearAiFilledMark(qidMulti),
          onChanged: (val) {
            _clearInvalid(cubit, qidMulti);
            setState(() {
              answerMap[AppStrings.otherField] = val;
              syncMultipleAnswer();
            });
            log('map ${cubit.formData}');
          },
          validator: (val) {
            if (cubit.questionModelList[index].mandatory == true &&
                answers.contains(AppStrings.others)) {
              if (val == null || val.isEmpty) {
                return AppStrings.thisFieldIsRequired;
              }
            }
            return null;
          },
          children: cubit.questionModelList[index].values!.map((value) {
            final isSelected = answers.contains(value);
            return GestureDetector(
              onTap: () {
                cubit.clearAiFilledMark(qidMulti);
                _clearInvalid(cubit, qidMulti);
                setState(() {
                  if (isSelected) {
                    answers.remove(value);
                    if (value == AppStrings.others) {
                      answerMap[AppStrings.otherField] = AppStrings.empty;
                    }
                  } else {
                    if (!answers.contains(value)) {
                      answers.add(value);
                    }
                  }
                  syncMultipleAnswer();
                  log('map ${cubit.formData}');
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 140),
                margin: EdgeInsets.only(bottom: 6.h),
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? primaryLocal.withOpacity(isDarkMode ? 0.28 : 0.14)
                      : (isDarkMode
                          ? const Color(0xFF2A2A2E)
                          : const Color(0xFFF3F4F6)),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: isSelected
                        ? primaryLocal.withOpacity(0.55)
                        : (isDarkMode
                            ? Colors.white.withOpacity(0.08)
                            : const Color(0xFFE5E7EB)),
                  ),
                ),
                child: Text(
                  value.toString(),
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: isSelected
                        ? (isDarkMode ? Colors.white : primaryLocal)
                        : (isDarkMode
                            ? Colors.white70
                            : const Color(0xFF4B5563)),
                  ),
                ),
              ),
            );
          }).toList(),
        );

      case AppStrings.questionTypeDate:
        var questionAnswer = cubit.questionModelList[index].answer;
        final qidDate = cubit.questionModelList[index].id.toString();
        final storedRaw = cubit.formData[qidDate] ?? questionAnswer;

        DateTime selectedDate = DateTime.now();
        if (storedRaw != null && storedRaw.toString().trim().isNotEmpty) {
          try {
            selectedDate = DateTime.parse(storedRaw.toString());
          } catch (_) {
            selectedDate = DateTime.now();
          }
        }

        final primaryLocal =
            isDarkMode ? AppColors.darkPrimary : AppColors.primary;
        final fieldBg =
            isDarkMode ? const Color(0xFF2A2A2E) : const Color(0xFFF3F4F6);
        final mutedLocal =
            isDarkMode ? Colors.white54 : const Color(0xFF6B7280);
        final titleLocal =
            isDarkMode ? Colors.white : const Color(0xFF111827);
        final hasStoredAnswer = cubit.formData.containsKey(qidDate) ||
            (questionAnswer != null &&
                questionAnswer.toString().trim().isNotEmpty);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(12.r),
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: isDarkMode
                              ? ColorScheme.dark(
                                  primary: primaryLocal,
                                  onPrimary: Colors.white,
                                  surface: const Color(0xFF1C1C1E),
                                  onSurface: Colors.white,
                                )
                              : ColorScheme.light(
                                  primary: primaryLocal,
                                  onPrimary: Colors.white,
                                  surface: Colors.white,
                                  onSurface: const Color(0xFF111827),
                                ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (picked == null) return;
                  cubit.clearAiFilledMark(qidDate);
                  _clearInvalid(cubit, qidDate);
                  final value = picked.toString();
                  cubit.formData[qidDate] = value;
                  log(cubit.formData[qidDate].toString());
                  setState(() {});
                },
                child: Ink(
                  decoration: BoxDecoration(
                    color: fieldBg,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: primaryLocal.withOpacity(0.55),
                      width: 1.2,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 12.h,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 36.w,
                          height: 36.w,
                          decoration: BoxDecoration(
                            color: primaryLocal.withOpacity(
                              isDarkMode ? 0.22 : 0.12,
                            ),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Icon(
                            Icons.calendar_today_rounded,
                            size: 16.sp,
                            color: primaryLocal,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                hasStoredAnswer
                                    ? '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}'
                                    : context.tr(AppStrings.selectDate),
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w700,
                                  color: titleLocal,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                hasStoredAnswer
                                    ? DateFormat('EEEE, d MMM yyyy')
                                        .format(selectedDate)
                                    : context.tr(AppStrings.addDate),
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w500,
                                  color: mutedLocal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.chevron_right_rounded,
                          size: 20.sp,
                          color: mutedLocal,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            isValidDate(cubit.questionModelList[index].answer.toString())
                ? const SizedBox.shrink()
                : cubit.questionModelList[index].answer == null
                    ? const SizedBox.shrink()
                    : Padding(
                        padding: EdgeInsets.only(top: 8.h),
                        child: Row(
                          children: [
                            Text(
                              '${context.tr(AppStrings.oldAnswer)}:',
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: mutedLocal,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Flexible(
                              child: Text(
                                cubit.questionModelList[index].answer
                                    .toString(),
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w700,
                                  color: titleLocal,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
          ],
        );

      default:
        return const SizedBox.shrink();
    }
  }
}
