import 'dart:developer';

import 'package:egy_akin/app/shared/functions/initial_value_in_question.dart';
import 'package:egy_akin/app/shared/functions/initial_value_in_select_question.dart';
import 'package:egy_akin/app/shared/functions/is_date.dart';
import 'package:egy_akin/features/patient_section_details/presentation/utils/patient_section_multiple_answer_utils.dart';
import 'package:egy_akin/features/patient_section_details/presentation/widgets/repeatable_question_widget.dart';
import 'package:egy_akin/features/patient_section_details/presentation/widgets/section_files_question.dart';
import 'package:intl/intl.dart';

import '../../../../exports.dart';

class BuildQuestion extends StatefulWidget {
  final DoctorModel currentDoctorModel;
  final String doctorId;
  final int index;
  final HomeModelResponse homeDataModel;
  final bool isAllDataOpen;
  final String patientId;
  final SectionModel sectionModel;
  const BuildQuestion(
      {super.key,
      required this.index,
      required this.currentDoctorModel,
      required this.doctorId,
      required this.homeDataModel,
      required this.isAllDataOpen,
      required this.patientId,
      required this.sectionModel});

  @override
  State<BuildQuestion> createState() => _BuildQuestionState();
}

class _BuildQuestionState extends State<BuildQuestion> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;

        PatientSectionDetailsCubit cubit =
            PatientSectionDetailsCubit.get(context);

        switch (cubit.questionModelList[widget.index].type) {
          //! double
          case AppStrings.questionTypeDouble:
            final currentAnswer = cubit.questionModelList[widget.index].answer;
            final qidDouble =
                cubit.questionModelList[widget.index].id.toString();
            final isMandatory =
                cubit.questionModelList[widget.index].mandatory == true;

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

            return _CompactDoubleQuestionField(
              isDarkMode: isDarkMode,
              isMandatory: isMandatory,
              initialWhole: initialWhole,
              initialDecimal: initialDecimal,
              onChanged: (whole, decimal) {
                cubit.clearAiFilledMark(qidDouble);
                _updateDoubleValue(
                  cubit: cubit,
                  index: widget.index,
                  whole: whole,
                  decimal: decimal,
                );
              },
            );

          //! String
          case AppStrings.questionTypeString:
            var questionAnswer = cubit.questionModelList[widget.index].answer;
            final qidStr = cubit.questionModelList[widget.index].id.toString();
            return BuildStringValueQuestions(
              questionList: cubit.questionModelList,
              index: widget.index,
              showAiFilledBanner: false,
              compact: true,
              onClearAiFilledMark: () => cubit.clearAiFilledMark(qidStr),
              initialValue: initialValueInQuestions(
                answer: questionAnswer,
                currentDoctorId: widget.currentDoctorModel.id.toString(),
                doctorId: widget.doctorId.toString(),
                question:
                    cubit.questionModelList[widget.index].question.toString(),
                questionAnswerInForm: cubit.formData[
                    cubit.questionModelList[widget.index].id.toString()],
                currentDoctorRole: widget.homeDataModel.role.toString(),
                isAllDataOpen: widget.isAllDataOpen,
              ),
              textInputFormatter:
                  cubit.questionModelList[widget.index].question ==
                          AppStrings.phone
                      ? [
                          LengthLimitingTextInputFormatter(11),
                        ]
                      : cubit.questionModelList[widget.index].question ==
                              AppStrings.nationalID
                          ? [
                              LengthLimitingTextInputFormatter(14),
                            ]
                          : [
                              LengthLimitingTextInputFormatter(255),
                            ],
              onChanged: (val) {
                setState(() {
                  if (questionAnswer != val) {
                    cubit.updateQuestionAnswer(
                        cubit.questionModelList[widget.index].id.toString(),
                        val);
                    cubit.formData[cubit.questionModelList[widget.index].id
                        .toString()] = val;
                  } else {
                    cubit.updateQuestionAnswer(
                        cubit.questionModelList[widget.index].id.toString(),
                        null);
                    cubit.formData.remove(
                        cubit.questionModelList[widget.index].id.toString());
                  }
                });
              },
              validator: (val) {
                if (cubit.questionModelList[widget.index].mandatory == true &&
                    (val == null || val.isEmpty)) {
                  return AppStrings.thisFieldIsRequired;
                }

                return null;
              },
            );

          //! Select
          case AppStrings.questionTypeSelect:
            var questionAnswer = cubit.questionModelList[widget.index].answer;
            final qidSel = cubit.questionModelList[widget.index].id.toString();

            // Keep a mutable map tied to formData (never store null other_field).
            Map<String, dynamic> answerMap = Map<String, dynamic>.from(
              cubit.formData[qidSel] is Map
                  ? cubit.formData[qidSel] as Map
                  : (questionAnswer is Map
                      ? Map<String, dynamic>.from(questionAnswer)
                      : {
                          AppStrings.answers: '',
                          AppStrings.otherField: AppStrings.empty,
                        }),
            );
            answerMap[AppStrings.answers] ??= '';
            answerMap[AppStrings.otherField] ??= AppStrings.empty;
            cubit.formData[qidSel] = answerMap;

            final storedAnswer = answerMap[AppStrings.answers];
            final modelAnswer = questionAnswer is Map
                ? questionAnswer[AppStrings.answers]
                : questionAnswer;

            return BuildSelectValueQuestion(
              questionList: cubit.questionModelList,
              index: widget.index,
              formData: cubit.formData,
              isAddPatient: true,
              overlayLeadingInset: 0,
              embedOthersField: true,
              showFieldBorder: true,
              showAiFilledBanner: false,
              onClearAiFilledMark: () => cubit.clearAiFilledMark(qidSel),
              selected: initialValueInSelectQuestion(
                questionAnswer: storedAnswer ?? modelAnswer,
                selectedValue: storedAnswer,
                values: cubit.questionModelList[widget.index].values!,
              ),
              validator: (val) {
                final answers = answerMap[AppStrings.answers];
                if (cubit.questionModelList[widget.index].mandatory == true &&
                    (answers == null ||
                        answers.toString().trim().isEmpty ||
                        answers == AppStrings.empty)) {
                  return AppStrings.thisFieldIsRequired;
                }
                return null;
              },
              onChanged: (val) {
                cubit.clearInvalidHighlight(qidSel);
                setState(() {
                  answerMap[AppStrings.answers] = val ?? '';
                  if (val != AppStrings.others && val != 'Others') {
                    answerMap[AppStrings.otherField] = AppStrings.empty;
                  }
                  cubit.updateQuestionAnswer(qidSel, answerMap);
                  cubit.formData[qidSel] = Map<String, dynamic>.from(answerMap);
                });
                log(cubit.formData.toString());
              },
              onChangedForOtherField: (value) {
                setState(() {
                  answerMap[AppStrings.otherField] = value ?? AppStrings.empty;
                  cubit.updateQuestionAnswer(qidSel, answerMap);
                  cubit.formData[qidSel] = Map<String, dynamic>.from(answerMap);
                });
                log(cubit.formData.toString());
              },
            );

          //! Multiple
          case AppStrings.questionTypeMultiple:
            final questionAnswer = cubit.questionModelList[widget.index].answer;
            final qidMulti =
                cubit.questionModelList[widget.index].id.toString();

            final answerMap = resolveMultipleAnswerMap(
              questionAnswer: questionAnswer,
              formEntry: cubit.formData[qidMulti],
            );
            final hasLegacyStringAnswer =
                answerMap[AppStrings.answers] is String;
            final String oldAnswer = hasLegacyStringAnswer
                ? (answerMap[AppStrings.answers] as String? ?? AppStrings.empty)
                : AppStrings.empty;
            final List<dynamic> answers = hasLegacyStringAnswer
                ? cubit.questionModelList[widget.index].values!
                    .where((value) => oldAnswer.contains(value.toString()))
                    .toList()
                : List<dynamic>.from(
                    answerMap[AppStrings.answers] as List<dynamic>? ??
                        <dynamic>[],
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

            return BuildMultipleValueQuestion(
              index: widget.index,
              questionList: cubit.questionModelList,
              initialValue: answerMap[AppStrings.otherField]?.toString() ?? '',
              listContainOther: answers,
              oldAnswer: null,
              isOldAnswer: false,
              showAiFilledBanner: false,
              onClearAiFilledMark: () => cubit.clearAiFilledMark(qidMulti),
              onChanged: (val) {
                setState(() {
                  answerMap[AppStrings.otherField] = val;
                  syncMultipleAnswer();
                });

                log('map ${cubit.formData}');
              },
              validator: (val) {
                if (cubit.questionModelList[widget.index].mandatory == true &&
                    answers.contains(AppStrings.others)) {
                  if (val == null || val.isEmpty) {
                    return AppStrings.thisFieldIsRequired;
                  }
                }
                return null;
              },
              children:
                  cubit.questionModelList[widget.index].values!.map((value) {
                final isSelected = answers.contains(value);
                final primaryLocal =
                    isDarkMode ? AppColors.darkPrimary : AppColors.primary;

                return GestureDetector(
                  onTap: () {
                    cubit.clearAiFilledMark(qidMulti);
                    cubit.clearInvalidHighlight(qidMulti);
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
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

          //! Repeatable (e.g. creatinine readings)
          case AppStrings.questionTypeRepeatable:
            final qidRepeatable =
                cubit.questionModelList[widget.index].id.toString();
            return RepeatableQuestionWidget(
              questionIndex: widget.index,
              keyboardType: cubit.questionModelList[widget.index].keyboardType,
              mandatory:
                  cubit.questionModelList[widget.index].mandatory == true,
              showAiFilledBanner: false,
              onClearAiFilledMark: () => cubit.clearAiFilledMark(qidRepeatable),
            );

          //! Date

          case AppStrings.questionTypeDate:
            return _SectionDateQuestionField(
              questionIndex: widget.index,
              isDarkMode: isDarkMode,
            );

          //! File
          case AppStrings.questionTypeFiles:
            return PermissionGuard(
              permission: AppPermissions.uploadPatientFiles,
              fallback: Container(
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? const Color(0xFF2A2A2E)
                      : const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  context.tr(
                    AppStrings.youDontHavePermissionToUploadPatientFiles,
                  ),
                  style: TextStyle(
                    color: isDarkMode ? Colors.grey.shade400 : Colors.grey,
                    fontSize: 12.sp,
                  ),
                ),
              ),
              child: SectionFilesQuestion(
                questionIndex: widget.index,
                patientId: widget.patientId,
                sectionId: widget.sectionModel.sectionId.toString(),
                isDark: isDarkMode,
              ),
            );
          default:
            return Container();
        }
      },
    );
  }

  void _updateDoubleValue({
    required PatientSectionDetailsCubit cubit,
    required int index,
    required String whole,
    required String decimal,
  }) {
    cubit.clearAiFilledMark(cubit.questionModelList[index].id.toString());
    final wholeNum = whole.isEmpty ? 0 : int.parse(whole);
    final decimalNum = decimal.padRight(2, '0');
    final doubleValue = wholeNum + (int.parse(decimalNum) / 100);

    cubit.updateQuestionAnswer(
      cubit.questionModelList[index].id.toString(),
      doubleValue,
    );

    // Also update formData to prevent the "You should update and data to submit" dialog
    cubit.formData[cubit.questionModelList[index].id.toString()] = doubleValue;
  }
}

class _SectionDateQuestionField extends StatefulWidget {
  final int questionIndex;
  final bool isDarkMode;

  const _SectionDateQuestionField({
    required this.questionIndex,
    required this.isDarkMode,
  });

  @override
  State<_SectionDateQuestionField> createState() =>
      _SectionDateQuestionFieldState();
}

class _SectionDateQuestionFieldState extends State<_SectionDateQuestionField> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    final cubit = PatientSectionDetailsCubit.get(context);
    final question = cubit.questionModelList[widget.questionIndex];
    final qidDate = question.id.toString();
    final questionAnswer = question.answer;
    final storedRaw = cubit.formData[qidDate] ?? questionAnswer;

    DateTime selectedDate = DateTime.now();
    if (storedRaw != null && storedRaw.toString().trim().isNotEmpty) {
      try {
        selectedDate = DateTime.parse(storedRaw.toString());
      } catch (_) {
        selectedDate = DateTime.now();
      }
    }

    final isDarkMode = widget.isDarkMode;
    final primaryLocal = isDarkMode ? AppColors.darkPrimary : AppColors.primary;
    final fieldBg = isDarkMode ? AppColors.darkCardBG : AppColors.subBG;
    final mutedLocal = isDarkMode ? Colors.white54 : const Color(0xFF6B7280);
    final titleLocal = isDarkMode ? Colors.white : const Color(0xFF111827);
    final hasStoredAnswer = cubit.formData.containsKey(qidDate) ||
        (questionAnswer != null && questionAnswer.toString().trim().isNotEmpty);
    final borderColor = _isSelected
        ? primaryLocal
        : (isDarkMode ? AppColors.darkBorder : Colors.grey.shade300);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () => _openPicker(
              cubit: cubit,
              qidDate: qidDate,
              selectedDate: selectedDate,
              primaryLocal: primaryLocal,
            ),
            child: Ink(
              decoration: BoxDecoration(
                color: fieldBg,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: borderColor, width: 1),
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
        isValidDate(question.answer.toString())
            ? const SizedBox.shrink()
            : question.answer == null
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
                            question.answer.toString(),
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
  }

  Future<void> _openPicker({
    required PatientSectionDetailsCubit cubit,
    required String qidDate,
    required DateTime selectedDate,
    required Color primaryLocal,
  }) async {
    cubit.clearInvalidHighlight(qidDate);
    setState(() => _isSelected = true);
    try {
      final picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: widget.isDarkMode
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
      cubit.formData[qidDate] = picked.toString();
      log(cubit.formData[qidDate].toString());
    } finally {
      if (mounted) setState(() => _isSelected = false);
    }
  }
}

/// Compact decimal input matching other section-detail fields (40.h shell).
/// Whole · decimal in one bordered control — no stray maxLength counter gap.
class _CompactDoubleQuestionField extends StatefulWidget {
  final bool isDarkMode;
  final bool isMandatory;
  final String? initialWhole;
  final String? initialDecimal;
  final void Function(String whole, String decimal) onChanged;

  const _CompactDoubleQuestionField({
    required this.isDarkMode,
    required this.isMandatory,
    required this.initialWhole,
    required this.initialDecimal,
    required this.onChanged,
  });

  @override
  State<_CompactDoubleQuestionField> createState() =>
      _CompactDoubleQuestionFieldState();
}

class _CompactDoubleQuestionFieldState
    extends State<_CompactDoubleQuestionField> {
  late final TextEditingController _wholeController;
  late final TextEditingController _decimalController;
  late final FocusNode _wholeFocus;
  late final FocusNode _decimalFocus;

  @override
  void initState() {
    super.initState();
    _wholeController = TextEditingController(text: widget.initialWhole ?? '');
    _decimalController =
        TextEditingController(text: widget.initialDecimal ?? '');
    _wholeFocus = FocusNode()..addListener(_onFocusChange);
    _decimalFocus = FocusNode()..addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (mounted) setState(() {});
  }

  @override
  void didUpdateWidget(covariant _CompactDoubleQuestionField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialWhole != widget.initialWhole &&
        (widget.initialWhole ?? '') != _wholeController.text) {
      _wholeController.text = widget.initialWhole ?? '';
    }
    if (oldWidget.initialDecimal != widget.initialDecimal &&
        (widget.initialDecimal ?? '') != _decimalController.text) {
      _decimalController.text = widget.initialDecimal ?? '';
    }
  }

  @override
  void dispose() {
    _wholeFocus.removeListener(_onFocusChange);
    _decimalFocus.removeListener(_onFocusChange);
    _wholeFocus.dispose();
    _decimalFocus.dispose();
    _wholeController.dispose();
    _decimalController.dispose();
    super.dispose();
  }

  void _emit() {
    widget.onChanged(_wholeController.text, _decimalController.text);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDarkMode;
    final primary = isDark ? AppColors.darkPrimary : AppColors.primary;
    final muted = isDark ? AppColors.darkDescription : Colors.grey.shade500;
    final title = isDark ? AppColors.darkTitle : const Color(0xFF111827);
    final focused = _wholeFocus.hasFocus || _decimalFocus.hasFocus;

    return FormField<String>(
      initialValue: widget.initialWhole,
      validator: (_) {
        if (widget.isMandatory && _wholeController.text.trim().isEmpty) {
          return AppStrings.thisFieldIsRequired;
        }
        return null;
      },
      builder: (state) {
        final hasError = state.hasError;
        final borderColor = hasError
            ? const Color(0xFFEF4444)
            : focused
                ? primary
                : (isDark ? AppColors.darkBorder : Colors.grey.shade300);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Compact value control — does not stretch full card width.
            Container(
              height: kSectionQuestionFieldHeight,
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCardBG : AppColors.subBG,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: borderColor, width: 1),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 44.w,
                    child: _digitField(
                      controller: _wholeController,
                      focusNode: _wholeFocus,
                      hint: '0',
                      titleColor: title,
                      mutedColor: muted,
                      textInputAction: TextInputAction.next,
                      onChanged: (v) {
                        state.didChange(v);
                        _emit();
                      },
                      onSubmitted: (_) => _decimalFocus.requestFocus(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Text(
                      '.',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        height: 1,
                        color: muted,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 44.w,
                    child: _digitField(
                      controller: _decimalController,
                      focusNode: _decimalFocus,
                      hint: '00',
                      titleColor: title,
                      mutedColor: muted,
                      textInputAction: TextInputAction.done,
                      onChanged: (_) => _emit(),
                    ),
                  ),
                ],
              ),
            ),
            if (hasError)
              Padding(
                padding: EdgeInsets.only(top: 2.h, bottom: 2.h),
                child: Text(
                  state.errorText ?? '',
                  style: TextStyle(
                    fontSize: 9.sp,
                    height: 1.2,
                    color: const Color(0xFFEF4444),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _digitField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String hint,
    required Color titleColor,
    required Color mutedColor,
    required TextInputAction textInputAction,
    required ValueChanged<String> onChanged,
    ValueChanged<String>? onSubmitted,
  }) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: TextInputType.number,
      textInputAction: textInputAction,
      textAlign: TextAlign.center,
      textAlignVertical: TextAlignVertical.center,
      maxLength: 2,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(2),
      ],
      style: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        height: 1.2,
        color: titleColor,
        fontFeatures: const [FontFeature.tabularFigures()],
      ),
      cursorWidth: 1.2,
      cursorHeight: 16.sp,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
        isDense: true,
        isCollapsed: true,
        counterText: '',
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        contentPadding: EdgeInsets.zero,
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          height: 1.2,
          color: mutedColor,
        ),
      ),
    );
  }
}
