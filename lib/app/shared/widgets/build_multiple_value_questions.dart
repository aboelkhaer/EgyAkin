import 'package:egy_akin/app/shared/widgets/multiple_question_other_field.dart';

import '../../../exports.dart';

class BuildMultipleValueQuestion extends StatelessWidget {
  final List<QuestionModel> questionList;
  final int index;
  final List<Widget> children;
  final String? Function(String?)? validator;
  final String initialValue;
  final Function(String)? onChanged;
  final List<dynamic> listContainOther;
  final bool isOldAnswer;
  final String? oldAnswer;
  final bool showAiFilledBanner;
  final VoidCallback? onClearAiFilledMark;

  const BuildMultipleValueQuestion({
    super.key,
    required this.questionList,
    required this.index,
    required this.onChanged,
    required this.initialValue,
    required this.validator,
    required this.children,
    required this.listContainOther,
    this.isOldAnswer = false,
    this.oldAnswer,
    this.showAiFilledBanner = false,
    this.onClearAiFilledMark,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (showAiFilledBanner) const AiFilledFieldBanner(),
        Wrap(
          spacing: 8,
          alignment: WrapAlignment.center,
          children: children,
        ),
        const SizedBox(height: 16),
        isOldAnswer == false
            ? listContainOther.contains(AppStrings.others)
                ? MultipleQuestionOtherField(
                    key: ValueKey('multiple_other_${questionList[index].id}'),
                    initialValue: initialValue,
                    validator: validator,
                    onClearAiFilledMark: onClearAiFilledMark,
                    onChanged: onChanged,
                  )
                : const SizedBox.shrink()
            : const SizedBox.shrink(),
        isOldAnswer
            ? Row(
                children: [
                  Text('${context.tr(AppStrings.oldAnswer)}:'),
                  const SizedBox(width: 5),
                  Flexible(
                    child: Text(
                      context.tr(oldAnswer ?? ''),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
