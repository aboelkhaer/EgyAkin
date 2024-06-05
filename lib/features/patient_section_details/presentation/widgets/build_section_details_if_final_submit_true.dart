import 'package:egy_akin/features/patient_section_details/presentation/widgets/convert_list_to_string.dart';
import '../../../../exports.dart';

class BuildSectionDetailsIfFinalSubmitTrue extends StatelessWidget {
  final List<QuestionModel> questionList;
  const BuildSectionDetailsIfFinalSubmitTrue({
    super.key,
    required this.questionList,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: questionList.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        var question = questionList[index];
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
                child: Text(
                  question.type == AppStrings.questionTypeMultiple
                      ? convertDynamicToString(question)
                      : question.type == AppStrings.questionTypeDate
                          ? formatDateTime(question.answer)
                          : question.question == AppStrings.nationalID
                              ? hideNationalId(question.answer ?? '...')
                              : question.answer ?? '...',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade900,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
