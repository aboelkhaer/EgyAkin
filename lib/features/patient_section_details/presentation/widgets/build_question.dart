import 'dart:developer';

import 'package:egy_akin/app/shared/functions/initial_value_in_question.dart';
import 'package:egy_akin/app/shared/functions/initial_value_in_select_question.dart';
import 'package:egy_akin/app/shared/functions/is_date.dart';
import 'package:egy_akin/features/patient_section_details/presentation/utils/patient_section_multiple_answer_utils.dart';
import 'package:egy_akin/features/patient_section_details/presentation/widgets/repeatable_question_widget.dart';
import 'package:egy_akin/features/patient_section_details/presentation/widgets/section_files_question.dart';
import 'package:intl/intl.dart';

import '../../../../exports.dart';
import 'package:egy_akin/app/services/theme_bloc.dart';

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
            // Get current value (null if no answer exists)
            final currentAnswer = cubit.questionModelList[widget.index].answer;
            final qidDouble =
                cubit.questionModelList[widget.index].id.toString();

            // Split into whole and decimal parts only if value exists
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

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Whole number part
                    SizedBox(
                      width: 50,
                      child: CustomTextFormField(
                        title: '00',
                        textInputType: TextInputType.number,
                        contentPadding: EdgeInsets.zero,
                        maxLength: 2,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        textAlign: TextAlign.center,
                        initialValue: initialWhole, // null will show title '00'
                        onChanged: (wholeValue) {
                          cubit.clearAiFilledMark(qidDouble);
                          final decimalValue =
                              cubit.getCurrentDecimalValue(widget.index);
                          _updateDoubleValue(
                            cubit: cubit,
                            index: widget.index,
                            whole: wholeValue,
                            decimal: decimalValue,
                          );
                        },
                        validator: (val) {
                          if (cubit.questionModelList[widget.index].mandatory ==
                                  true &&
                              (val == null || val.isEmpty)) {
                            return AppStrings.thisFieldIsRequired;
                          }
                          return null;
                        },
                      ),
                    ),

                    //! Decimal point
                    Container(
                      width: 4,
                      height: 4,
                      margin:
                          const EdgeInsets.only(bottom: 5, left: 10, right: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade500,
                        shape: BoxShape.circle,
                      ),
                    ),

                    //! Decimal part
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
                        initialValue:
                            initialDecimal, // null will show title '00'
                        onChanged: (decimalValue) {
                          cubit.clearAiFilledMark(qidDouble);
                          final wholeValue =
                              cubit.getCurrentWholeValue(widget.index);
                          _updateDoubleValue(
                            cubit: cubit,
                            index: widget.index,
                            whole: wholeValue,
                            decimal: decimalValue,
                          );
                        },
                        validator: (value) => null,
                      ),
                    ),
                  ],
                ),
              ],
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
              initialValue:
                  answerMap[AppStrings.otherField]?.toString() ?? '',
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
                    margin: EdgeInsets.only(bottom: 6.h),
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? primaryLocal
                              .withOpacity(isDarkMode ? 0.28 : 0.14)
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
            var questionAnswer = cubit.questionModelList[widget.index].answer;
            final qidDate = cubit.questionModelList[widget.index].id.toString();
            final storedRaw = cubit.formData[qidDate] ?? questionAnswer;

            DateTime selectedDate = DateTime.now();
            if (storedRaw != null &&
                storedRaw.toString().trim().isNotEmpty) {
              try {
                selectedDate = DateTime.parse(storedRaw.toString());
              } catch (_) {
                selectedDate = DateTime.now();
              }
            }

            final primaryLocal =
                isDarkMode ? AppColors.darkPrimary : AppColors.primary;
            final fieldBg = isDarkMode
                ? const Color(0xFF2A2A2E)
                : const Color(0xFFF3F4F6);
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
                      cubit.clearInvalidHighlight(qidDate);
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
                isValidDate(
                        cubit.questionModelList[widget.index].answer.toString())
                    ? const SizedBox.shrink()
                    : cubit.questionModelList[widget.index].answer == null
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
                                    cubit.questionModelList[widget.index]
                                        .answer
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
