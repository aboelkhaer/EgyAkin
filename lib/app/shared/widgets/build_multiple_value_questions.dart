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
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: 8,
          alignment: WrapAlignment.center,
          children: children,
        ),
        const SizedBox(height: 16),
        isOldAnswer == false
            ? listContainOther.contains('Others')
                ? CustomTextFormField(
                    title: 'Answer here',
                    initialValue: initialValue,
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    validator: validator,
                    onChanged: onChanged,
                  )
                : const SizedBox.shrink()
            : const SizedBox.shrink(),
        isOldAnswer
            ? Row(
                children: [
                  const Text('Old Answer:'),
                  const SizedBox(width: 5),
                  Text(
                    oldAnswer.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
