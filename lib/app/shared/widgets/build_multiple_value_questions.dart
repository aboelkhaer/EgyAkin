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
    final showOtherField =
        !isOldAnswer && listContainOther.contains(AppStrings.others);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (showAiFilledBanner) const AiFilledFieldBanner(),
        Wrap(
          spacing: 8.w,
          runSpacing: 6.h,
          alignment: WrapAlignment.start,
          children: children,
        ),
        if (showOtherField) ...[
          SizedBox(height: 10.h),
          MultipleQuestionOtherField(
            key: ValueKey('multiple_other_${questionList[index].id}'),
            initialValue: initialValue,
            validator: validator,
            onClearAiFilledMark: onClearAiFilledMark,
            onChanged: onChanged,
          ),
        ],
        if (isOldAnswer)
          Padding(
            padding: EdgeInsets.only(top: 8.h),
            child: Row(
              children: [
                Text('${context.tr(AppStrings.oldAnswer)}:'),
                SizedBox(width: 5.w),
                Flexible(
                  child: Text(
                    context.tr(oldAnswer ?? ''),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
