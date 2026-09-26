import 'package:egy_akin/app/shared/functions/convert_dynamic_list_to_string_list.dart';
import 'package:egy_akin/app/shared/functions/hide_email.dart';
import 'package:egy_akin/app/shared/functions/show_answer_with_select_type.dart';
import 'package:egy_akin/app/shared/functions/permissions_helper.dart';
import 'package:egy_akin/app/shared/permissions/app_permissions.dart';
import 'package:egy_akin/features/patient_section_details/presentation/widgets/convert_list_to_string.dart';
import 'package:egy_akin/features/patient_section_details/presentation/widgets/file_list_when_submit.dart';
import 'package:egy_akin/features/patient_section_details/presentation/models/repeatable_reading_entry.dart';

import '../../../../exports.dart';
import '../../../../app/services/theme_bloc.dart';
import 'dart:ui' as ui;

class BuildSectionDetailsIfFinalSubmitTrue extends StatelessWidget {
  final List<QuestionModel> questionList;
  final String currentDoctorId;
  final String doctorId;
  final bool isAllDataOpen;
  const BuildSectionDetailsIfFinalSubmitTrue({
    super.key,
    required this.questionList,
    required this.currentDoctorId,
    required this.doctorId,
    required this.isAllDataOpen,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;

        return ListView.builder(
          itemCount: questionList.length,
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.only(bottom: 70.h),
          itemBuilder: (context, index) {
            var question = questionList[index];
            String answerText = getAnswerText(question.answer);
            final canViewPatientIdentity = PermissionHelper.canPermission(
              AppPermissions.viewPatientsName,
            );

            return Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isDarkMode ? AppColors.darkCardBG : Colors.white,
                border: Border.all(
                  color: AppColors.primary,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${index + 1} - ${question.question!}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: isDarkMode ? AppColors.darkTitle : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 16),
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      color: isDarkMode
                          ? AppColors.primary.withOpacity(0.1)
                          : AppColors.primary.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: question.type == 'files'
                        ? FileListWhenSubmit(
                            files:
                                convertDynamicListToStringList(question.answer))
                        : Text(
                            _resolvedSubmittedAnswer(
                              question: question,
                              currentDoctorId: currentDoctorId,
                              doctorId: doctorId,
                              isAllDataOpen: isAllDataOpen,
                              canViewPatientIdentity: canViewPatientIdentity,
                            ),
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: isDarkMode
                                  ? Colors.white
                                  : Colors.grey.shade900,
                              fontSize: 15,
                            ),
                            textDirection:
                                RegExp(r'[\u0600-\u06FF]').hasMatch(answerText)
                                    ? ui.TextDirection.rtl
                                    : ui.TextDirection.ltr,
                          ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

String _resolvedSubmittedAnswer({
  required QuestionModel question,
  required String currentDoctorId,
  required String doctorId,
  required bool isAllDataOpen,
  required bool canViewPatientIdentity,
}) {
  final raw = answerAsDisplayString(question);
  final q = question.question;

  if (q == AppStrings.nationalID) {
    if (currentDoctorId == doctorId || canViewPatientIdentity) return raw;
    return hideNationalId(raw);
  }
  if (q == 'Name') {
    if (currentDoctorId == doctorId ||
        canViewPatientIdentity ||
        isAllDataOpen) {
      return raw;
    }
    return convertTextToSymbols(raw);
  }
  if (q == 'Phone') {
    if (currentDoctorId == doctorId ||
        canViewPatientIdentity ||
        isAllDataOpen) {
      return raw;
    }
    return hideNationalId(raw);
  }
  if (q == 'Email') {
    if (currentDoctorId == doctorId || isAllDataOpen) return raw;
    return hideEmail(raw);
  }
  return raw;
}

String getAnswerText(dynamic answer) {
  if (answer == null) return '';
  if (answer is String) return answer;
  if (answer is num || answer is bool) return answer.toString();
  if (answer is Map) {
    final map = Map<String, dynamic>.from(
      answer.map((k, v) => MapEntry(k.toString(), v)),
    );
    if (map.containsKey(AppStrings.answers)) {
      return showAnswerWithSelectType(map);
    }
    return map.values.isNotEmpty ? map.values.first.toString() : '';
  }
  if (answer is List) {
    return answer.map((e) => e?.toString() ?? '').join(', ');
  }
  return answer.toString();
}

/// Safe display text for any question answer (API may send int/num for labs).
String answerAsDisplayString(QuestionModel question) {
  final answer = question.answer;
  if (answer == null) return '...';

  final type = question.type;
  if (type == AppStrings.questionTypeMultiple) {
    try {
      return convertDynamicToString(question);
    } catch (_) {
      return getAnswerText(answer);
    }
  }
  if (type == AppStrings.questionTypeSelect) {
    if (answer is Map) {
      return showAnswerWithSelectType(
        Map<String, dynamic>.from(
          answer.map((k, v) => MapEntry(k.toString(), v)),
        ),
      );
    }
    return getAnswerText(answer);
  }
  if (type == AppStrings.questionTypeDate) {
    final asText = getAnswerText(answer);
    if (asText.isEmpty) return '...';
    try {
      return formatDateTime(asText);
    } catch (_) {
      return asText;
    }
  }
  if (type == AppStrings.questionTypeRepeatable) {
    return formatRepeatableAnswerForDisplay(answer);
  }
  return getAnswerText(answer);
}
