import 'package:egy_akin/app/shared/functions/convert_dynamic_list_to_string_list.dart';
import 'package:egy_akin/app/shared/functions/hide_email.dart';
import 'package:egy_akin/app/shared/functions/show_answer_with_select_type.dart';
import 'package:egy_akin/features/patient_section_details/presentation/widgets/convert_list_to_string.dart';
import 'package:egy_akin/features/patient_section_details/presentation/widgets/file_list_when_submit.dart';
import '../../../../exports.dart';
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
    return ListView.builder(
      itemCount: questionList.length,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(bottom: 70.h),
      itemBuilder: (context, index) {
        var question = questionList[index];
        String answerText = getAnswerText(question.answer);

        return Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.primary,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${index + 1} - ${question.question!}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: question.type == 'files'
                    ? FileListWhenSubmit(
                        files: convertDynamicListToStringList(question.answer))
                    : Text(
                        question.type == AppStrings.questionTypeMultiple
                            ? convertDynamicToString(question)
                            : question.type == AppStrings.questionTypeSelect
                                ? showAnswerWithSelectType(question.answer)
                                : question.type == AppStrings.questionTypeDate
                                    ? formatDateTime(question.answer)
                                    : question.question == AppStrings.nationalID
                                        ? currentDoctorId == doctorId
                                            ? question.answer ?? '...'
                                            : hideNationalId(
                                                question.answer ?? '...')
                                        : question.question == 'Name'
                                            ? currentDoctorId == doctorId
                                                ? question.answer ?? '...'
                                                : isAllDataOpen
                                                    ? question.answer ?? '...'
                                                    : convertTextToSymbols(
                                                        question.answer)
                                            : question.question == 'Phone'
                                                ? currentDoctorId == doctorId
                                                    ? question.answer ?? '...'
                                                    : isAllDataOpen
                                                        ? question.answer ??
                                                            '...'
                                                        : hideNationalId(
                                                            question.answer)
                                                : question.question == 'Email'
                                                    ? currentDoctorId ==
                                                            doctorId
                                                        ? question.answer ??
                                                            '...'
                                                        : isAllDataOpen
                                                            ? question.answer ??
                                                                '...'
                                                            : hideEmail(
                                                                question.answer)
                                                    : question.answer ?? '...',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade900,
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
  }
}

String getAnswerText(dynamic answer) {
  if (answer is String) {
    return answer; // If it's already a string, return it.
  } else if (answer is Map<String, dynamic>) {
    // If it's a Map, attempt to retrieve the string.
    return answer.values.isNotEmpty
        ? answer.values.first.toString()
        : ''; // Adjust this based on your expected key.
  } else {
    return ''; // Return a default value if the type is unexpected.
  }
}
